#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq curl json_pp

clientid="501d56d2805f6ec"
image_name=$1

if [ -z "$image_name" ]; then
    echo "Usage: preview-image.sh <image_name>"
    exit 1
fi

# use ./list or $2 if set
json_file=${2:-./list.json}

# json format:
# [
#  {
#   "ext": "jpeg",
#   "id": "soEJGse",
#   "name": "aenami-15steps",
#   "sha256": "1y69chgaskv7x08nsdmr02rl6pdwk24ajnkjqdzpxqn3wxa3lzxl"
# }, ...
# ]
id=$(jq -r ".[] | select(.name == \"$image_name\") | .id" $json_file)
ext=$(jq -r ".[] | select(.name == \"$image_name\") | .ext" $json_file)

echo "https://i.imgur.com/$id.$ext"
