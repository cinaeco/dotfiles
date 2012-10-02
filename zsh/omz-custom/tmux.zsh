# tmux + vim solarised colours are strange:
# https://github.com/altercation/solarized/issues/159
# We need to force a TERM type for tmux
# Ensure that the terminal emulator also reports TERM as 'screen-256color'
alias tmux='TERM=screen-256color tmux'
# Seems to be needed for tmuxinator as well
alias mux='TERM=screen-256color mux'