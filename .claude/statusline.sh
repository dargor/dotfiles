#! /bin/sh
set -eu

input=$(cat)

MODEL_NAME=$(echo "$input" | jq -r '.model.display_name')
STATUS="🧠 ${MODEL_NAME}"

CONTEXT_REMAINING=$(echo "$input" | jq -r '.context_window.remaining_percentage')
if [ "$CONTEXT_REMAINING" != "null" ]; then
    STATUS="${STATUS} (${CONTEXT_REMAINING}% left)"
fi

PROJECT_DIR=$(echo "$input" | jq -r '.workspace.project_dir | sub("^" + env.HOME; "~")')
STATUS="${STATUS} | 📁 ${PROJECT_DIR}"

if git rev-parse --git-dir >/dev/null 2>&1; then
    GIT_BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$GIT_BRANCH" ]; then
        STATUS="${STATUS} | 🌿 ${GIT_BRANCH}"
    fi
fi

LINES_ADDED=$(echo "$input" | jq -r '.cost.total_lines_added')
LINES_REMOVED=$(echo "$input" | jq -r '.cost.total_lines_removed')
if [ "$LINES_ADDED" != "0" ] || [ "$LINES_REMOVED" != "0" ]; then
    STATUS="${STATUS} | 📊 [92m+${LINES_ADDED}[0m [91m-${LINES_REMOVED}[0m"
fi

echo "${STATUS}"

