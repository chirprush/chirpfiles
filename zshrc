# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/rushil/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Functions
function fzf-cd() {
	a=$(find ~/Coding ~/Projects -type d ! -path "*/.git/*" ! -path "*/.git" ! -path "*/node_modules/*" ! -path "*/node_modules" ! -path "*/*cache*/*" ! -path "*/*cache*" | fzf)
	if [[ -n "$a" ]] then
		cd "$a"
		clear
		tree -L 1
	fi
	zle accept-line
}

function fzf-config-cd() {
	a=$(find ~/.config/ -mindepth 1 -maxdepth 1 -type d | fzf)
	if [[ -n "$a" ]] then
		cd "$a"
		clear
		tree -L 1
	fi
	zle accept-line
}

function fzf-vim-edit() {
	a=$(find ~/.config/nvim/plugins/ -maxdepth 1 -type d | fzf)
	if [[ -n "$a" ]] then
		cd $a
		clear
		tree
	fi
	zle accept-line
}

zle -N "fzf-cd"
zle -N "fzf-config-cd"
zle -N "fzf-vim-edit"

function jd() {
	dir=$(jdir $1)
	if [[ $? -eq 0 ]] then
		cd $dir
		echo -e "\e[1;93m$dir\e[0m"
		ls --group-directories-first
	else
		return $?
	fi
}

# Aliases
alias c='clear'
alias s='apt-cache search'
alias ls='ls --color=auto --group-directories-first'
alias p='python3 -B -q'
alias con='. con'
alias g='quick_grep'

# Settings
export FZF_DEFAULT_OPTS="-m --height 20% --min-height 3 --ansi --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -L 1 -C {}) 2> /dev/null | head -200'"
export PYTHONSTARTUP="$HOME/.pythonrc"
export LUA_INIT="@$HOME/.luarc"

export GREP_COLORS="sl=38;2;92;99;112:mt=01;93:fn=34:ln=32:se=36"
export VISUAL='/usr/bin/vim'
export EDITOR=$VISUAL
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=$PATH:$HOME/Scripts/
export PATH=$PATH:$HOME/.cabal/bin/

# Vim takes a long time to start up because of xsmp, this stops that
export SESSION_MANAGER=

# PS1='%(?.%F{blue}.%F{red})->%f %F{magenta}'
# preexec () {
# 	echo -ne '\e[0m'
# 	echo -ne '\e[2 q'
# }
PS1='%(?.%F{blue}.%F{red})->%f '

echo '( . \e[4m     \e[24m.)'
echo

bindkey -e "^[g" "fzf-cd"
bindkey -e "^[e" "fzf-config-cd"
bindkey -e "^[v" "fzf-vim-edit"

# Plugin stuff
autoload -U compinit
compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
