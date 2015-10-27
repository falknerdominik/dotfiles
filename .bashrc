#
# ~/.bashrc
#

# color in manpages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias

  # FPC
  alias fpcaud='fpc -Mtp -Criot -gl'

	# Listing
	alias ls='ls --color=auto'
	alias ll='ls -al'
	alias l='ls -CFlh'
	alias l.='ls -d .* --color=auto'
  alias lsym='ll | grep "\->"'

	# Change Directory
	alias ..='cd ..'
  alias ...='cd ../..'
  alias cdhome='cd ~'
	
    # Grep Color
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
	alias fgrep='fgrep --color=auto'

  # Make Parent Directorys ondemand
	alias mkdir='mkdir -pv'

	# Color for diff with colordiff
	alias diff='colordiff'

	# make Mount readable
	alias mount='mount | column -t'

	# confirm before action
	alias rm='rm -I --preserve-root'
	alias mv='mv -i'
	alias cp='cp -i'
	alias ln='ln -i'

  # clear
  alias c='clear'

PS1='[\u@\h \W]\$ '
