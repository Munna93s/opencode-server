---
name: gh-workflow-push
description: Push commits that modify .github/workflows/* when the default GitHub App token is rejected with "without `workflows` permission". Uses a PAT from WORKFLOW_PAT / GH_PAT env var or ~/.config/opencode/.env.local. Use whenever a workflow-file push fails or the user asks to save/reuse a PAT-based push command.
---

# GitHub workflow push (PAT fallback)

The server's default git credential is a GitHub App installation token
(`ghs_...`). It can push normal repo files but GitHub rejects workflow files:

```
remote rejected: refusing to allow a GitHub App to create or update workflow
.github/workflows/server.yml without `workflows` permission
```

Changing repo **Settings → Actions → General → Workflow permissions** does
not fix this — that setting controls the `GITHUB_TOKEN` used *inside* Actions,
not the App token used by `git push`.

## Saved command

`scripts/push-with-workflows.sh` is installed on PATH as `push-with-workflows`
by `setup.sh`. It reads the token from `WORKFLOW_PAT`, then `GH_PAT`, then
`~/.config/opencode/.env.local`. It never writes a token into the repo.

```bash
# One-time: add the PAT to the private env file (mode 0600)
printf 'WORKFLOW_PAT=%s\n' '<PAT with workflows scope>' >> ~/.config/opencode/.env.local

# Push the pending workflow commit
push-with-workflows

# Or explicitly
push-with-workflows origin main
```

A classic PAT needs the `workflows` scope. A fine-grained PAT needs
**Workflows: write** on the repository. After the push succeeds, the PAT is
only in the local env file / process environment, never in git history.

## Verification

```bash
git status --short --branch
git ls-remote origin HEAD
```
