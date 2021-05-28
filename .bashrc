# base-files version 3.9-3

# To pick up the latest recommended .bashrc content,
# look in /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# Environment Variables
# #####################

# TMP and TEMP are defined in the Windows environment.  Leaving
# them set to the default Windows temporary directory can have
# unexpected consequences.
unset TMP
unset TEMP

# Alternatively, set them to the Cygwin temporary directory
# or to any other tmp directory of your choice
# export TMP=/tmp
# export TEMP=/tmp

# Or use TMPDIR instead
# export TMPDIR=/tmp

# Shell Options
# #############

# See man bash for more options...

# Don't wait for job termination notification
# set -o notify

# Don't use ^D to exit
# set -o ignoreeof

# Use case-insensitive filename globbing
# shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
# shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell


# Completion options
# ##################

# These completion tuning parameters change the default behavior of bash_completion:

# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# case $- in
#   *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
# esac


# History Options
# ###############

# Don't put duplicate lines in the history.
#export HISTCONTROL="ignoredups:ignorespace"

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:history'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well

# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"


# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

alias ls='ls -FA --color=auto'

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
alias grep='grep -P --color'                     # show differences in colour

# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'

alias ll='ls -lAhF --color=auto'                              # long list
alias m=less
alias gzcat='gzip -dc'
alias psg='ps -ef | grep'

alias prename='perl ~/Perl/rename -v'
alias eptitle='perl ~/Perl/episode'

# alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #



declare -A COLORS
COLORS[black]=000000
COLORS[brown]=804040
COLORS[gray]=666666
COLORS[purple]=222266
COLORS[blue]=0000ff
COLORS[red]=ff0000
COLORS[green]=00ff00

function bg() {
    if [ ${COLORS[$1]+_} ]; then
	bg ${COLORS[$1]}
#    if [ "$1" == "black" ]; then
#        bg 000000
#    elif [ "$1" == "brown" ]; then
#        bg 804040
#    elif [ "$1" == "gray" ]; then
#        bg 666666
#    elif [ "$1" == "purple" ]; then
#        bg 222266
#    elif [ "$1" == "blue" ]; then
#        bg 0000ff
    else
        echo -ne "\e]11;#$1\a";
    fi
}

function color {
    if [ "$1:" != ":" ]; then
        export BGCOLOR="$1"
    fi
    if [ "$BGCOLOR:" == ":" ]; then
        export BGCOLOR="auto"
    fi
    if [ "$BGCOLOR" != "auto" ]; then
        bg $BGCOLOR
    elif [ "$USERNAME" == "root" ]; then
        bg gray
    elif [[ $HOSTNAME == mds* ]]; then
        bg purple
    else
        bg black
    fi

}
alias blue='color blue'
alias black='color black'
alias brown='color brown'
alias gray='color gray'
alias purple='color purple'


function cdmds()
{
    if [ "$2" == "-b" ]; then
	cd ~/workspace/mds/$1/LinuxDebug
    elif [ "$2:" != ":" ]; then 
	cd ~/workspace/mds/$1/$2
    elif [ "$1:" != ":" ]; then
	cd ~/workspace/mds/$1
    else
	cd ~/workspace/mds
    fi
}

alias cdcore='cdmds core'
alias cdjava='cdmds java-api'
alias cddemo='cdmds demo'
alias cdrun='cdmds demo inventory/run/demo3-multithread/demo'
alias cdcpp='cdmds c++-api'
alias cddoc='cdmds doc'
alias cdgc='cdmds gc'
alias cdcommon='cdmds common'
alias cdpy='cdmds python-api'

function mds()
{
    ssh evank@mds${1}.hpl.hp.com
}

function nd()
{
    cwd=`pwd`
    echo ${1} ${cwd}
#    echo sed -ni "/^${1}/\!p" ~/.named-dirs
    sed -ni "/^${1} /!p" ~/.named-dirs
    echo ${1} ${cwd} >> ~/.named-dirs
}

function gd()
{
    dir=`grep "^${1} " ~/.named-dirs | cut -f2- -d ' '`
#    echo $dir
    if [ "${dir}:" == ":" ]; then
        echo No named dir \"${1}\"
    else
        echo cd "${dir}"
        cd "${dir}"
    fi
}

alias ldirs="sort ~/.named-dirs"

function mvextra() {
    dir=$2;
    type=$1;
    mv "${dir}" "/x/Video/${type}/${dir}/Extras"
}




# Functions
# #########

# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

#export PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h\[\e[33m\]\w\[\e[0m\]\n\!>"
# $SESSIONNAME is defined on non-admin shells.  Dunno why.
#if [ "$DISPLAY:" != ":" ]; then
#  export IS_ADMIN=0
#  export TITLE_PREFIX="[X] "
#  gray
#elif [ "$SESSIONNAME:" = ":" ]; then
#  brown
#  export TITLE_PREFIX="[ADMIN] "
#  export IS_ADMIN=1
#else
#  export IS_ADMIN=0
#  black
#fi
#export PS1="\[\e]0;$TITLE_PREFIX\w\a\]\n\[\e[32m\][\D{%a %m/%d %T}] \[\e[33m\]\w\[\e[0m\]\n\! \$ "

#source ~/bin/git-prompt.sh
#export GIT_PS1_SHOWDIRTYSTATE=true
#export GIT_PS1_SHOWCOLORHINTS=true
#export PS1='\[\e]0;$TITLE_PREFIX\w\a\]\n\[\e[32m\][\D{%a %m/%d %T}] \[\e[33m\]\w\[\e[0m\] $(__git_ps1 " \[\e[1;35m\](%s)\[\e[0m\]")$(_git_ps_info)\n\[\e[36m\]\! \$\[\e[0m\] '
export PS1='$(color)\[\e]0;${TITLE_PREFIX}\h : \w\a\]\n\[\e[32m\][\D{%a %m/%d %T}] \[\e[31m\]\h\[\e[32m\]:\[\e[33m\]\w\[\e[0m\] $(_git_ps_info)\n\[\e[36m\]\! \$\[\e[0m\] '

if [ "$EMACS" == "t" ]; then
export PS1='\n\[\e[32m\][\D{%a %m/%d %T}] \[\e[31m\]\h\[\e[32m\]:\[\e[33m\]\w\[\e[0m\] $(_git_ps_info)\n\[\e[36m\]\! \$\[\e[0m\] '
fi    


export LC_ALL=C
export SVNROOT=/cygdrive/c/Users/evank/workspace
export SVNROOT=c:/Users/evank/workspace
export INPUTDIR=../input
export LESSCHARSET=utf-8

export HAS_GIT=$(which git 2>/dev/null)
_git_ps_info ()  {
  if [ -z "$HAS_GIT" ]; then
    return
  fi
  if [ -z "$(git rev-parse --git-dir --is-inside-git-dir --is-bare-reposittory --is-inside-work-tree --short HEAD 2>/dev/null)" ]; then
    return
  fi
  local color repo branch bcolor
  color="\e[1;35m"
  bcolor="\e[1;35m"
  repo="$(basename `git rev-parse --show-toplevel`)"
  branch="$(git rev-parse --abbrev-ref HEAD)"
  echo -e " ${bcolor}(${branch}${color} [${repo}]${bcolor})\e[0m"
}

## Note: ~/.ssh/environment should not be used, as it
##       already has a different purpose in SSH.

#env=~/.ssh/agent.env

## Note: Don't bother checking SSH_AGENT_PID. It's not used
##       by SSH itself, and it might even be incorrect
#       (for example, when using agent-forwarding over SSH).

#agent_is_running() {
#    if [ "$SSH_AUTH_SOCK" ]; then
#        # ssh-add returns:
#        #   0 = agent running, has keys
#        #   1 = agent running, no keys
#        #   2 = agent not running
#        # if your keys are not stored in ~/.ssh/id_rsa.pub or ~/.ssh/id_dsa.pub, you'll need
#        # to paste the proper path after ssh-add
#        ssh-add -l >/dev/null 2>&1 || [ $? -eq 1 ]
#    else
#        false
#    fi
#}

#agent_has_keys() {
#    # if your keys are not stored in ~/.ssh/id_rsa.pub or ~/.ssh/id_dsa.pub, you'll need
#    # to paste the proper path after ssh-add
#    ssh-add -l >/dev/null 2>&1
#}

#agent_load_env() {
#    . "$env" >/dev/null
#}

#agent_start() {
#    (umask 077; ssh-agent >"$env")
#    . "$env" >/dev/null
#}

#if ! agent_is_running; then
#    agent_load_env
#fi

## if your keys are not stored in ~/.ssh/id_rsa.pub or ~/.ssh/id_dsa.pub, you'll need
## to paste the proper path after ssh-add
#if ! agent_is_running; then
#    agent_start
#    ssh-add
#elif ! agent_has_keys; then
#    ssh-add
#fi

#unset env
PERL_MB_OPT="--install_base \"/cygdrive/c/Users/evank/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/cygdrive/c/Users/evank/perl5"; export PERL_MM_OPT;

# If a command is initiated with C-j (rather than enter), time it as well.
if [ -z "$EMACS" ]; then
   bind '"\C-j": "\C-atime \C-m"'
fi   
#export TIMEFORMAT='r: %R, u: %U, s: %S'

export GCC540=$HOME/tools/gcc-5.4.0
export GCC640=$HOME/tools/gcc-6.4.0
export CYGWIN='error_start=C:\cygwin64\bin\dumper.exe -d %1 %2'

export DISPLAY=:0.0

export ANTL4JAR=$(cygpath -w /usr/local/lib/antlr-4.9.2-complete.jar)

export CLASSPATH=".;$ANTL4JAR;$CLASSPATH"
alias antlr4='java -Xmx500M -cp "$ANTLR4JAR:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "$ANTLR4JAR:$CLASSPATH" org.antlr.v4.gui.TestRig' 

