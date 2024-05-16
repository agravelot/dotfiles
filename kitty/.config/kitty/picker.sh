#!/usr/bin/env bash
# fzf --with-nth 2.. --bind 'enter:execute-silent(kitty @ focus-tab -m id:{1})+accept' >/dev/null \
# 	<<<$(kitty @ ls | jq -r '.[] | .tabs[] | select(.is_focused == false) | (.id|tostring) + " " + .title')
#

all_tabs="$(
	kitty @ ls | jq -r '
        .[]
        | select(.is_active)
        | .tabs[]
        | select(.is_focused == false)
        | [.title, "id:\(.id)"]
        | @tsv
    ' | column -ts $'\t'
)"

new_tab_id="$(fzf --reverse <<<"${all_tabs}" | awk '{ print $NF }')"
kitty @ focus-tab -m "${new_tab_id}"
