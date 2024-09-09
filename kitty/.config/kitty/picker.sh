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

# fzf --reverse --preview "kitty @ get-text --ansi -m title:{}" <<<"${all_tabs}"
# fzf --reverse --preview "echo {}" --preview-window '~3' --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899' <<<"${all_tabs}"

# new_tab_id="$(fzf --reverse --preview "kitty @ get-text --ansi -m $('nvim . ~/l/flasher-lerna            id:36' | awk '{ print $NF }')" --preview-window '~3' <<<"${all_tabs}" | awk '{ print $NF }')"
# new_tab_id="$(fzf --reverse --preview "kitty @ get-text -m bs}" | awk '{ print $NF }')"
# new_tab_id="$(fzf --reverse --preview "kitty @ get-text -m $(echo '{}' | awk '{ print $NF }')" <<<"${all_tabs}" | awk '{ print $NF }')"
new_tab_id="$(fzf --reverse --preview "kitty @ get-text -m {}" <<<"${all_tabs}" | awk '{ print $NF }')"

# echo "$new_tab_id"

kitty @ focus-tab -m "${new_tab_id}"
