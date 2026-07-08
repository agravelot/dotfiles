test -d /opt/homebrew/bin && fish_add_path --prepend /opt/homebrew/bin
test -d "$HOME/.orbstack/bin" && fish_add_path --prepend "$HOME/.orbstack/bin"
test -d "$VOLTA_HOME/bin" && fish_add_path --prepend "$VOLTA_HOME/bin"
fish_add_path --append /home/agravelot/.lmstudio/bin