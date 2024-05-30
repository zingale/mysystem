# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

if [ -e ~/bin ]; then
    export PATH=".:~/bin:$PATH"
fi

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ssh='ssh -Y'

alias ipython='ipython3'

export EDITOR="emacs -nw"

alias screenkill="screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill"

# use bat instead of cat
a=$(which bat >& /dev/null); if [ $? == 0 ]; then
    alias cat='bat --map-syntax="*.H:C++"'
fi

# Microphysics
export MICROPHYSICS_HOME=/home/zingale/development/Microphysics

# initial models
export INITIAL_MODEL_HOME=/home/zingale/development/initial_models/

# AMReX
if [ -e /home/zingale/development/AMReX/ ]; then
    export AMREX_HOME=/home/zingale/development/AMReX
else
    export AMREX_HOME=/home/zingale/development/amrex
fi

# Castro stuff
export CASTRO_HOME=/home/zingale/development/Castro
export WDMERGER_HOME=/home/zingale/development/wdmerger

# plotting numerical exercises
export PYTHONPATH="$PYTHONPATH:/home/zingale/classes/numerical_exercises/:/home/zingale/classes/astro_animations"

# prompt -- this gets the git branch in the prompt
# we also use some coloring.  Note that we need to put the 
# coloring escape codes inside \[ \], otherwise, bash will include
# them in the line length calculation and things will be messed up.
# also deal with root
source /usr/share/git-core/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1    # * appears if dirty
export GIT_PS1_SHOWSTASHSTATE=1    # $ appears if stashes
export GIT_PS1_SHOWUPSTREAM="auto" # < = > appear if behind, on, ahead of remote
export PROMPT_DIRTRIM=2

WHITE_FG=`tput setaf 7`
YELLOW_FG=`tput setaf 3`
BLACK_FG=`tput setaf 0`

YELLOW_BG=`tput setab 11`
BLUE_BG=`tput setab 4`
GREEN_BG=`tput setab 2`
RED_BG=`tput setab 1`
MAG_BG=`tput setab 5`
RESET=`tput sgr0`

if [ $(id -u) -eq 0 ]; then
    # root
    #export PS1='\[\e[7;31m\][\u@\h \W]# \[\e[0m\]'
    export PS1='\[${WHITE_FG}\]\[${RED_BG}\]\u@\h \[${RESET}\] \W# '
else
    PS1='\n'
    # normal user
    if [[ -n $SSH_CLIENT ]]; then
        USE_BG=${MAG_BG}
    else
        USE_BG=${BLUE_BG}
    fi
    PS1+='\[${WHITE_FG}\]\[${USE_BG}\]'

    PS1+='\h \[${GREEN_BG}\]\[${BLACK_FG}\] \w \[${YELLOW_BG}\]$(__git_ps1 " %s ")\[${RESET}\]'
    PS1+='\[${WHITE_FG}\]\[${USE_BG}\]$\[${RESET}\] '
    export PS1
fi


# pick up .local first
export PATH=~/.local/bin:${PATH}

hostname=`uname -n`
if [ $hostname == "bender.astro.sunysb.edu" ]; then
    # PGI
    # CUDA
    export CUDA_PATH=/usr/local/cuda-12.1
    export PATH=$CUDA_PATH/bin:$PATH
fi

if [ $hostname == "groot.astro.sunysb.edu" ]; then

    # CUDA
    export CUDA_PATH=/usr/local/cuda-12.4
    export PATH=$CUDA_PATH/bin:$PATH

    # HYPRE
    export HYPRE_DIR=/opt/hypre/hypre-2.23
fi

if [ $hostname == "ahsoka.astro.sunysb.edu" ]; then
    # HYPRE
    export HYPRE_DIR=/opt/hypre/
fi


# hack for my laptop

if [ "`cat /etc/machine-id`" == "cbd4091cb4e449679f543c1f61d6b4cf" ]; then
    alias zoom="QT_DEVICE_PIXEL_RATIO=2 zoom"
fi

