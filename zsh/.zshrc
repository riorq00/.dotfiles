# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/.config/rofi/scripts:$PATH

# Use powerline
USE_POWERLINE="true"
alias lon="xset led on"
alias lof="xset led off"


alias ls="exa -a --icons"
alias ll="exa -la -g --icons"
alias g="git"
alias vim="nvim"
alias vimdiff="nvim -d"
alias v="vim ."
alias nf="neofetch"
alias vsyncon="xrandr --output eDP --set TearFree on"
alias vsyncoff="xrandr --output eDP --set TearFree off"

#. /opt/asdf-vm/asdf.sh
. /home/riorq/.cargo/bin


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -r /usr/share/z/z.sh ]] && source /usr/share/z/z.sh

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
