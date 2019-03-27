#!/bin/bash
if [ -f ~/.bash_aliases ]; then
 source ~/.bash_aliases
fi



# git info
source ~/.git-prompt.sh


check_conda_env ()
{
    if [ ! -z "$CONDA_DEFAULT_ENV" ]; then

      printf "<$CONDA_DEFAULT_ENV>"
    else
        printf -- "%s" ""
    fi
}


HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes
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


# printf -- "%s" '\[\e[0;35m\]<`basename $CONDA_DEFAULT_ENV`>\[\e[0m\] '

# Get repo info
if [ "$color_prompt" = yes ]; then
  PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;91m\]${APPNAME} \[\033[01;37m\]\w\[\033[00m\]$(__git_ps1 " \[\033[01;32m\][%s]")\[\033[00m\] \[\e[0;35m\]$(check_conda_env)\[\e[0m\] \[\033[01;34m\] \n#\[\033[00m\] '

fi
unset color_prompt force_color_prompt
#
# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

fi


. /opt/conda/etc/profile.d/conda.sh

conda activate base
