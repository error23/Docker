# .bashrc
# set up umask
umask 022

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# if exists bashrc hallo source it
if [ -f ~/.bashrc_hallo ]; then
	source ~/.bashrc_hallo
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Define awk script in order to generate PS workingDirectory
MYPSDIR_AWK=$(cat << 'EOF'
BEGIN { FS = OFS = "/" }
{
   sub(ENVIRON["HOME"], "~");
   if (length($0) > 16 && NF > 4)
      print $1,$2,".." NF-4 "..",$(NF-1),$NF
   else
      print $0
}
EOF
)

# Replacement for \w prompt expansion
export MYPSDIR='$(echo -n "$PWD" | awk "$MYPSDIR_AWK")'

# set up PS1 and color prompt
force_color_prompt=yes

# default prompt values
user="\u"
host="\h"
workingDirectory="[$MYPSDIR]"
rootIndicator="\\$"

# check if can use color prompt
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
    else
		color_prompt=
    fi
fi

# if we are in color prompt set up PS1 color values
if [ "$color_prompt" = yes ]; then
	# set up color values
	host="\[\033[38;5;46m\]$host"
	workingDirectory="\[\033[38;5;63m\]$workingDirectory"

	# if user is root set it to red color
	if [ $EUID -eq 0 ]; then
		user="\[\033[38;5;196m\]$user"
	else
		user="\[\033[38;5;46m\]$user"
	fi
fi

# set up PS1 and clean variables
PS1="${debian_chroot:+($debian_chroot)}\[$(tput bold)\]$user@$host$workingDirectory$rootIndicator\[$(tput sgr0)\] "
unset color_prompt force_color_prompt user workingDirectory host rootIndicator

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first -h'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep -n --color=auto'
    alias fgrep='fgrep -n --color=auto'
    alias egrep='egrep -n --color=auto'
	alias rgrep='rgrep -n --color=auto'
fi

# some more ls aliases
alias l='ls -CF'
alias ll='ls -lF'
alias la='ls -A'
alias tree='tree -FC'
alias sl='sl -alF'
alias mkdir='mkdir -v'
alias cp='cp -avi'
alias mv='mv -vi'
alias rm='rm -Iv --preserve-root'
alias nc='nc -v'
alias rgrep='grep -R'
alias chmod='chmod -v'
alias screen='screen -aA'
alias du='du -h'
alias ok='exit'
alias merci='exit'
alias cool='exit'
alias whoareyou='uname --nodename'

alias docker_kill_all='docker kill $(docker ps -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
alias docker_clean_images='docker rmi --force $(docker images -a -q)'

# if there is one ~/.bash_aliases file source it
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
#sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export GPG_TTY=$(tty)

