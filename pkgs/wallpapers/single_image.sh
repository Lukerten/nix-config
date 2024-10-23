#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq curl

# fetching Image
printf "Fetching image from %s\n" "$1"
clientid="501d56d2805f6ec"
image="$(echo "$1" | rev | cut -d '/' -f1 | rev | cut -d '.' -f1)"
image=$(curl -H "Authorization: Client-ID $clientid" https://api.imgur.com/3/image/"$image" | jq -r '.data | "\(.description)|\(.type)|\(.id)"')

# Metadata
name="$2"
ext=$(echo "$image" | cut -d '|' -f 2 | cut -d '/' -f 2)
id=$(echo "$image" | cut -d '|' -f 3)

# check if ./list.json exists, else try ./pkgs/wallpapers/list.json
# if neither exist, create a new list.json
image_path="$PWD"
if [ -f "$image_path/list.json" ]; then
    image_path="$image_path/list.json"
elif [ -f "$image_path"/pkgs/wallpapers/list.json ]; then
    image_path="$image_path/pkgs/wallpapers/list.json"
fi
printf "Using list.json in %s\n" "$image_path"

new_entry=$(jq -n \
    --arg name "$name" \
    --arg ext "$(echo "$image" | cut -d '|' -f 2 | cut -d '/' -f 2)" \
    --arg id "$(echo "$image" | cut -d '|' -f 3)" \
    --arg sha256 "$(nix-prefetch-url https://i.imgur.com/"$id"."$ext")" \
    '{"name": $name, "ext": $ext, "id": $id, "sha256": $sha256}')

echo "Adding $name to list.json"
echo "$new_entry" | jq

jq --argjson new_entry "$new_entry" '. += [$new_entry]' "$image_path" > temp.json && mv temp.json "$image_path"
