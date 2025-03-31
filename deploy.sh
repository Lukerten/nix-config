host=$1
extra_args=$2

if [ -z "$host" ]; then
  echo "Usage: deploy.sh <hostname> [extra_args]"
  exit 1
fi

if [ -z "$extra_args" ]; then
  extra_args="--option allow-import-from-derivation true"
fi

# Test:
printf "\e[1;32m%s\e[0m\n" "testing flake outputs"
nix flake show $extra_args --all-systems
if [ $? -ne 0 ]; then
  echo "Test failed. Aborting deployment."
  exit 1
fi

# Deploy:
printf "\e[1;32m%s\e[0m\n" "deploying to $host"
deploy .#$host --interactive-sudo true -- $extra_args
