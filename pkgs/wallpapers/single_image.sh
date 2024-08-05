#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq curl json_pp

clientid="501d56d2805f6ec"
image="$(echo "$1" | rev | cut -d '/' -f1 | rev | cut -d '.' -f1)"
name=$2

image=$(curl -H "Authorization: Client-ID $clientid" https://api.imgur.com/3/image/$image | jq -r '.data | "\(.description)|\(.type)|\(.id)"')

ext=$(echo $image | cut -d '|' -f 2 | cut -d '/' -f 2)
id=$(echo $image | cut -d '|' -f 3)

new_entry=$(jq -n \
    --arg name "$(echo $name)" \
    --arg ext "$(echo $image | cut -d '|' -f 2 | cut -d '/' -f 2)" \
    --arg id "$(echo $image | cut -d '|' -f 3)" \
    --arg sha256 "$(nix-prefetch-url https://i.imgur.com/$id.$ext)" \
    '{"name": $name, "ext": $ext, "id": $id, "sha256": $sha256}')

echo "Adding $name to list.json"
echo $new_entry | json_pp

jq --argjson new_entry "$new_entry" '. += [$new_entry]' list.json > temp.json && mv temp.json list.json

