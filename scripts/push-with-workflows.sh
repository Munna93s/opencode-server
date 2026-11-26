#!/usr/bin/env bash
set -euo pipefail

# Push a commit that touches .github/workflows/* using a PAT that has the
# `workflows` permission. The server's default GitHub App token can write repo
# files but is rejected for workflow files:
#   refusing to allow a GitHub App to create or update workflow ... without
#   `workflows` permission
#
# The token is NEVER stored in this repository. It is read from:
#   1. WORKFLOW_PAT env var
#   2. GH_PAT env var
#   3. WORKFLOW_PAT=... line in ~/.config/opencode/.env.local (mode 0600)
#
# Usage:
#   push-with-workflows.sh [remote] [refspec]
#   push-with-workflows.sh                      # origin HEAD:main
#   push-with-workflows.sh origin main          # origin main
set -a
ENV_FILE="$HOME/.config/opencode/.env.local"
if [ -f "$ENV_FILE" ]; then
  # shellcheck disable=SC1090
  . "$ENV_FILE"
fi
set +a

PAT="${WORKFLOW_PAT:-${GH_PAT:-}}"
if [ -z "$PAT" ]; then
  echo "ERROR: set WORKFLOW_PAT (or GH_PAT) to a token with 'workflows' scope." >&2
  echo "Add this line to $ENV_FILE: WORKFLOW_PAT=<your PAT>" >&2
  exit 1
fi

REMOTE="${1:-origin}"
REFSPEC="${2:-HEAD:main}"
AUTH_HEADER="AUTHORIZATION: basic $(printf 'x-access-token:%s' "$PAT" | base64 -w0)"

echo "Pushing $REFSPEC to $REMOTE with a workflows-capable PAT..."
git -c "http.extraHeader=$AUTH_HEADER" push "$REMOTE" "$REFSPEC"
