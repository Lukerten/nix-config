# this is a stupid tool to auto generate random commit messages
# it is not usefull at all, but i can not stop myself from writing
# "minor changes" in the commit message, so i wrote this to help message

# Usage:
# git commit -m "$(commitmsg)"

tasks=("chore" "fix" "feat" "docs" "refactor" "perf" "test" "build" "ci" "temp")
index=$((RANDOM % ${#tasks[@]}))
task=${tasks[$index]}
echo "$task: $(curl -s https://whatthecommit.com/index.txt)"
