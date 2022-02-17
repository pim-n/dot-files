#
#   ________
#   | _____ \
#   | |  _/ /      Pim Nelissen
#   | | /__/       p1m@disroot.org
#   | |    	   https://pim.wtf/
#   \_|
#
# Zsh configuration file.

PS1="%F{green}%~%f %F{white}»%f "

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

# Vi mode
bindkey -v

# Vi keys for the tab completion menu.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Aliases
alias ls='ls --color=auto'
alias shutdown='sudo shutdown -h now'
alias sleep='betterlockscreen -s -l dim && sudo zzz'
alias reboot='sudo reboot'

# Extensions
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
