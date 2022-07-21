#/bin/zsh
export OS=$(uname -s)

zstyle ':z4h:' auto-update      'no'
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
if [ "$OS" != "Darwin" ]; then
  zstyle ':z4h:bindkey' keyboard  'mac'
else
  zstyle ':z4h:bindkey' keyboard  'pc'
fi

zstyle ':z4h:' start-tmux       no
zstyle ':z4h:' term-shell-integration 'yes'

zstyle ':z4h:autosuggestions' forward-char 'accept'

zstyle ':z4h:fzf-complete' recurse-dirs 'no'
zstyle ':z4h:*' fzf-flags --color=hl:5,hl+:5

zstyle ':z4h:direnv'         enable 'no'
zstyle ':z4h:direnv:success' notify 'yes'

zstyle ':z4h:ssh:trovadores'   enable 'yes'
zstyle ':z4h:ssh:*'                   enable 'no'
# zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Use additional Git repositories pulled in with `z4h install`.
z4h load   ohmyzsh/ohmyzsh/plugins/asdf  # load a plugin

# Autoload functions.
autoload -Uz zmv

setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# Load environment
[ -f "$HOME/.aliasrc" ] && source "$HOME/.envrc"

# Load aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"
