#   ________
#   | _____ \
#   | |  _/ /      Pim Nelissen
#   | | /__/       https://pim.wtf/
#   | |
#   \_|

# Zshell configuration.


# Terminal prompt in minimalist format.
PS1="%F{cyan}%~%f %F{white}»%f "

# History settings.
HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=2500

export GPG_TTY=$(tty)

# Load autocompletion & include hidden dotfiles.
zstyle :compinstall filename '/home/pim/.zshrc'
zstyle ':completion:*' menu select
zmodload zsh/complist
autoload -Uz compinit
compinit
_comp_options+=(globdots)

# Vi mode toggle.
bindkey -v

# Vi keys for the tab completion menu.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Aliases.
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias vim='nvim'
alias top='htop'

# Power aliases.
alias shutdown='sudo shutdown -h now'
alias sleep='betterlockscreen -s -l dim && sudo zzz'
alias reboot='sudo reboot'

# Load extensions.
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
