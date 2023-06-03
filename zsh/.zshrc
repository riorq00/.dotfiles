# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/.config/rofi/scripts:$PATH

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

if [[ -e ~/.dotfiles/zsh/mouse.sh ]]; then 
  source ~/.dotfiles/zsh/mouse.sh
fi

alias lon="xset led on"
alias lof="xset led off"


alias ls="exa -a --icons"
alias ll="exa -la -g --icons"
alias g="git"
alias vim="nvim"
alias vimdiff="nvim -d"
alias v="vim ."
alias nf="neofetch"

. /opt/asdf-vm/asdf.sh
. /home/riorq/.cargo/bin

#. /home/riorq/.dotfiles/zsh/mouse.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -r /usr/share/z/z.sh ]] && source /usr/share/z/z.sh
