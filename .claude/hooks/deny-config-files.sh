#!/usr/bin/env bash
# PreToolUse guard: the agent may not write governance files. Ported from
# HashiCorp's terraform-agentic-workflows reference (deny-config-files.sh);
# same idea, trimmed to this repo. Exit 2 is Claude Code's deny signal.
set -euo pipefail

if grep -qE '"(file_path|path|filePath)"[[:space:]]*:[[:space:]]*"([^"]*/)?(\.mcp\.json|\.gitignore|\.claude/[^"]*)"'; then
  echo "BLOCKED: governance-protected file; ask a human if a change is genuinely required." >&2
  exit 2
fi
exit 0
