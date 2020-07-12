# /etc/bash.bashrc: executed by bash(1) for non-login shells.
#
# THIS FILE IS MANAGEG BY CFENGINE. LOCAL CHANGES WILL BE OVERWRITTEN.
# PLEASE USE ~/.bashrc FOR LOCAL MODIFICATIONS

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
# Store the execution date in the history
HISTTIMEFORMAT="%d/%m/%y %T "
# Store the last 10000 commands and load the last 5000 into memory
HISTSIZE=5000
HISTFILESIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Use colors in the git prompt
GIT_PS1_SHOWCOLORHINTS=1
# Append + for staged and * for unstaged changes
GIT_PS1_SHOWDIRTYSTATE=1
# Append $ if there are stashed changes
GIT_PS1_SHOWSTASHSTATE=1
# Append $ if there are untracked changes
# GIT_PS1_SHOWUNTRACKEDFILES=1

# Use a colored prompt including git status information
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	COLOR_RED="\[$(tput setaf 1)\]"
	COLOR_GREEN="\[$(tput setaf 2)\]"
	COLOR_YELLOW="\[$(tput setaf 3)\]"
	COLOR_RESET="\[$(tput sgr0)\]"
else
	COLOR_RED=""
	COLOR_GREEN=""
	COLOR_YELLOW=""
	COLOR_RESET=""
fi

if [ "$USER" = "root" ]; then
	_PROMPT_AFFIX="${COLOR_RED}#${COLOR_RESET}"
else
	_PROMPT_AFFIX="\$"
fi

function prompt_command() {
	# Store command immediately to the history and reload it again
	# to allow sharing the history across bash sessions
	history -a
	history -c
	history -r
	# Show information about git repositories
	__git_ps1 "${COLOR_GREEN}${debian_chroot:+($debian_chroot)}${COLOR_RESET}\u@\h:${COLOR_YELLOW}\w${COLOR_RESET}" "${_PROMPT_AFFIX} " "(%s)"

	# Show the username, hostname and working dir in the title
	if [ "${TERM}" != "linux" ]; then
		echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"
	fi
}
PROMPT_COMMAND='prompt_command'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# case insensitve completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# Set umask to get the mask for ACL right
umask o+rwx,g+rwx,o+rx
