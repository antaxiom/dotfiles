export PF_INFO="ascii title os de shell uptime pkgs"
echo 'Welcome back to' (hostname), $USER

set fish_greeting                      # Supresses fish's intro message
set TERM "xterm-256color"              # Sets the terminal type
set EDITOR "nvim"
set VISUAL "code"
# Fishblocks prompt

  set -g __fish_git_prompt_show_informative_status 1
  set -g __fish_git_prompt_showupstream informative
  set -g __fish_git_prompt_showdirtystate yes
  set -g __fish_git_prompt_char_stateseparator ' '
  set -g __fish_git_prompt_char_cleanstate ' ✔ '
  set -g __fish_git_prompt_char_dirtystate ' ✚ '
  set -g __fish_git_prompt_char_invalidstate ' ✖ '
  set -g __fish_git_prompt_char_stagedstate ' ● '
  set -g __fish_git_prompt_char_stashstate ' ⚑ '
  set -g __fish_git_prompt_char_untrackedfiles ' ? '
  set -g __fish_git_prompt_char_upstream_ahead '  '
  set -g __fish_git_prompt_char_upstream_behind '  '
  set -g __fish_git_prompt_char_upstream_diverged ' ﱟ '
  set -g __fish_git_prompt_char_upstream_equal '  '
  set -g __fish_git_prompt_char_upstream_prefix ''''

# Aliases from zsh

# convienient dragon
alias dr="dragon-drag-and-drop"

# safe cp
alias cp="cp -i"                          # confirm before overwriting something

# config file fzf editor and runner
alias se="find ~/.scripts/* ~/.config/* -type f | fzf | xargs -r nvim"
alias ser="find ~/.scripts/* -type f | fzf | xargs -r bash"

# ls as exa with colors
alias ls="exa --color=always --group-directories-first"
alias l="exa -lah --color=always --group-directories-first"

# Other aliases
alias mkdir='mkdir -pv'
alias free='free -mt'
alias ps='ps auxf'

# Convenient cds
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Colored grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# Alias for managing configs
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Easter eggs
alias :q=exit

# Devour

alias sxiv='devour sxiv'
alias mpv='devour mpv'
alias zathura='devour zathura'

# Askpass
export SUDO_ASKPASS=/home/alex/suckless/dwm/dpass

# z.lua
source (lua ~/.zsh-plugins/z.lua/z.lua --init fish | psub)

# Env stuff

export EDITOR='nvim'
# THEME PURE #
set fish_function_path /home/alex/.config/fish/functions/theme-pure/functions/ $fish_function_path
source /home/alex/.config/fish/functions/theme-pure/conf.d/pure.fish

# Seems to help
set -x SHELL /bin/bash
