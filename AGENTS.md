# AGENTS.md

## स्थायी नियम (Permanent rule — always follow)

जब भी यूज़र इस सर्वर पर कोई नया skill, tool, python/npm/apt पैकेज या AI मॉडल इंस्टॉल करवाए, तो काम पूरा होते ही तुरंत `setup.sh`, `requirements.txt` और `skills/` फ़ोल्डर को अपडेट करो। इसके बाद बड़ी वीडियो फ़ाइलों (`*.mp4`, `*.zip`) को छोड़कर बाकी सभी बदलावों को सीधे GitHub रिपॉजिटरी (`Munna93s/opencode-server`) में push कर दो।

### English (same rule, for reference)

Whenever the user installs any new skill, tool, Python/npm/apt package, or AI model on this server, immediately update `setup.sh`, `requirements.txt`, and the `skills/` folder as soon as the work is done. Then push every change except large video files (`*.mp4`, `*.zip`) directly to the GitHub repository `Munna93s/opencode-server`.

## Supporting notes

- Git push authentication is configured automatically on server start by `.github/workflows/server.yml` using the repository's `GH_PAT` secret. Do not ask the user for a token unless that secret is missing or invalid.
- Large binaries are listed in `.gitignore` and stay local only; captions, SRT, JSON and text manifests are backed up.
- After any install, run `bash -n setup.sh` and validate `.github/workflows/server.yml` before committing.
