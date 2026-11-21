#!/usr/bin/env python3
"""Tiny browser-based image uploader for the image-vision skill.

Why: chat/image attachments sometimes never land on this server's disk, so a
text-only model cannot call vision.sh on them. Open http://<server>:8388 in a
browser, pick an image, and it is saved locally where the agent can see it.

Stdlib only. Env vars:
  VISION_UPLOAD_PORT   (default 8388)
  VISION_UPLOAD_DIR    (default /tmp/opencode/vision_uploads)
"""
import http.server
import json
import os
import pathlib
import socketserver
import urllib.parse

PORT = int(os.environ.get("VISION_UPLOAD_PORT", "8388"))
OUT = pathlib.Path(os.environ.get("VISION_UPLOAD_DIR", "/tmp/opencode/vision_uploads"))
OUT.mkdir(parents=True, exist_ok=True)
LATEST = OUT.parent / "vision_latest.txt"
MAX_BYTES = 60 * 1024 * 1024

HTML = """<!doctype html>
<html><head><meta charset="utf-8"><title>Image upload for vision</title>
<style>
body{font:16px system-ui,sans-serif;max-width:640px;margin:3rem auto;padding:0 1rem}
input,button{font:inherit;padding:.6rem;margin:.4rem 0}
#msg{margin-top:1rem;white-space:pre-wrap;word-break:break-all}
</style></head><body>
<h2>Upload image so the agent can see it</h2>
<p>Pick a PNG/JPG/WEBP. It is saved under <code>/tmp/opencode/vision_uploads/</code>
and the path is written to <code>/tmp/opencode/vision_latest.txt</code>.</p>
<input type="file" id="f" accept="image/*"><br>
<button onclick="go()">Upload</button>
<div id="msg"></div>
<script>
async function go(){
  const f=document.getElementById('f').files[0];
  const m=document.getElementById('msg');
  if(!f){m.textContent='Pehle image chuno.';return;}
  m.textContent='Uploading...';
  try{
    const r=await fetch('/upload?name='+encodeURIComponent(f.name),{
      method:'POST', headers:{'Content-Type':'application/octet-stream'},
      body:await f.arrayBuffer()
    });
    const j=await r.json();
    m.textContent=(r.ok?'OK saved: ':'ERROR: ')+(j.path||j.error||JSON.stringify(j));
  }catch(e){m.textContent='ERROR: '+e;}
}
</script></body></html>"""


class Handler(http.server.BaseHTTPRequestHandler):
    def log_message(self, fmt, *args):
        print("%s - %s" % (self.address_string(), fmt % args), flush=True)

    def do_GET(self):
        if self.path in ("/", "/index.html"):
            body = HTML.encode()
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
        elif self.path == "/health":
            body = json.dumps({"ok": True, "dir": str(OUT)}).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
        else:
            self.send_error(404)
            return
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_POST(self):
        if not self.path.startswith("/upload"):
            self.send_error(404)
            return
        q = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query)
        name = pathlib.Path(q.get("name", ["image"])[0]).name or "image"
        stem = pathlib.Path(name).stem[:80] or "image"
        try:
            size = int(self.headers.get("Content-Length", "0"))
        except ValueError:
            size = 0
        if size <= 0 or size > MAX_BYTES:
            self._json({"error": "invalid size: %d" % size}, 400)
            return
        data = self.rfile.read(size)
        # Trust the bytes, not the filename a browser happens to send.
        if data.startswith(b"\x89PNG\r\n\x1a\n"):
            suffix = ".png"
        elif data.startswith(b"\xff\xd8\xff"):
            suffix = ".jpg"
        elif data[:4] == b"RIFF" and data[8:12] == b"WEBP":
            suffix = ".webp"
        elif data.startswith((b"GIF87a", b"GIF89a")):
            suffix = ".gif"
        else:
            self._json({"error": "not a recognized image"}, 400)
            return
        dest = OUT / ("%s%s" % (stem, suffix))
        dest.write_bytes(data)
        LATEST.write_text(str(dest) + "\n")
        self._json({"ok": True, "path": str(dest), "bytes": len(data)})

    def _json(self, obj, code=200):
        body = json.dumps(obj).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


class Server(socketserver.ThreadingTCPServer):
    allow_reuse_address = True
    daemon_threads = True


if __name__ == "__main__":
    print("Image upload page: http://0.0.0.0:%d/" % PORT, flush=True)
    print("Saving to: %s" % OUT, flush=True)
    Server(("0.0.0.0", PORT), Handler).serve_forever()
