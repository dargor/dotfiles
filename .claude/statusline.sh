#! /usr/bin/env bash
set -eu

input=$(cat)

MODEL_NAME=$(jq -r '.model.display_name' <<<"$input")
STATUS="🧠 ${MODEL_NAME}"

CONTEXT_REMAINING=$(jq -r '.context_window.remaining_percentage' <<<"$input")
if [ "$CONTEXT_REMAINING" != "null" ]; then
    STATUS="${STATUS} (${CONTEXT_REMAINING}% left)"
fi

PROJECT_DIR=$(jq -r '.workspace.project_dir' <<<"$input")
STATUS="${STATUS} | 📁 ${PROJECT_DIR##*/}"

if git rev-parse --git-dir >/dev/null 2>&1; then
    GIT_BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$GIT_BRANCH" ]; then
        STATUS="${STATUS} | 🌿 ${GIT_BRANCH}"
    fi
fi

FIVE_HOUR_USED=$(jq -r '.rate_limits.five_hour.used_percentage' <<<"$input")
SEVEN_DAY_USED=$(jq -r '.rate_limits.seven_day.used_percentage' <<<"$input")
if [ "$FIVE_HOUR_USED" != "null" ] && [ "$SEVEN_DAY_USED" != "null" ]; then
    STATUS="${STATUS} | 📊 5h ${FIVE_HOUR_USED}% 1w ${SEVEN_DAY_USED}%"
fi

COST=$(jq -r '.cost.total_cost_usd' <<<"$input")
if [ "$COST" != "0" ]; then
    COST_FMT=$(printf '$%.2f' "$COST")
    STATUS="${STATUS} | 💸 ${COST_FMT}"
fi

echo -e "${STATUS}"

