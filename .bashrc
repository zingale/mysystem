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

# MPI/gfortran stuff
export GFORTRAN_UNBUFFERED_ALL=1

# BoxLib python
if [ -e /usr/local/BoxLib ]; then
    export PYTHONPATH=/usr/local/BoxLib
    export PATH=/usr/local/BoxLib:$PATH
fi
export PYTHONPATH=/home/zingale/development/AmrPostprocessing/python:$PYTHONPATH
export PATH=/home/zingale/development/AmrPostprocessing/python:$PATH

export PYTHONPATH=/home/zingale/development/Microphysics/python_library:$PYTHONPATH

# Microphysics
export MICROPHYSICS_HOME=/home/zingale/development/Microphysics

# Maestro
export MAESTRO_HOME=/home/zingale/development/MAESTRO

# AMReX / BoxLib
export FBOXLIB_HOME=/home/zingale/development/FBoxLib/
export BOXLIB_USE_MPI_WRAPPERS=1

# initial models
export INITIAL_MODEL_HOME=/home/zingale/development/initial_models/

if [ -e /home/zingale/development/AMReX/ ]; then
    export AMREX_HOME=/home/zingale/development/AMReX/
else
    export AMREX_HOME=/home/zingale/development/amrex/
fi

# Castro stuff
export CASTRO_HOME=/home/zingale/development/Castro
export WDMERGER_HOME=/home/zingale/development/wdmerger

# plotting numerical exercises
export PYTHONPATH="$PYTHONPATH:/home/zingale/classes/numerical_exercises/:/home/zingale/development/pyro2/:/home/zingale/classes/astro_animations"

# visit
#export PATH="/usr/local/visit/bin:${PATH}"

# pyro
export PYRO_HOME=/home/zingale/development/pyro2/

# pynucastro
export PYTHONPATH="$PYTHONPATH:/home/zingale/development/pynucastro"

# prompt -- this gets the git branch in the prompt
# we also use some coloring.  Note that we need to put the 
# coloring escape codes inside \[ \], otherwise, bash will include
# them in the line length calculation and things will be messed up.
# also deal with root
source /usr/share/git-core/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1

if [ $(id -u) -eq 0 ]; then
    # root
    export PS1='\[\e[0;31m\][\u@\h \W]# \[\e[0m\]'
else
    # normal user 
    export PS1='[\u@\[\e[1;34m\]\h\[\e[0m\] \W]\[\e[1;34m\]$(__git_ps1 "(%s)")\[\e[0m\]$ '
fi


# pick up .local first
export PATH=~/.local/bin:${PATH}

hostname=`uname -n`
if [ $hostname == "bender.astro.sunysb.edu" ]; then
    # PGI
    # CUDA
    export CUDA_PATH=/usr/local/cuda-11.4
    export PATH=$CUDA_PATH/bin:$PATH
fi

if [ $hostname == "groot.astro.sunysb.edu" ]; then

    # CUDA
    export CUDA_PATH=/usr/local/cuda-11.4
    export PATH=$CUDA_PATH/bin:$PATH

    # HYPRE
    export HYPRE_DIR=/opt/hypre/hypre-2.20
fi


if [ $hostname == "inf.astro.sunysb.edu" ]; then
    # PGI
    export PGI=/opt/pgi;
    export PATH=/opt/pgi/linux86-64/18.10/bin:$PATH;
    export MANPATH=$MANPATH:/opt/pgi/linux86-64/18.10/man;
    export LM_LICENSE_FILE=$LM_LICENSE_FILE:/opt/pgi/license.dat; 

    # CUDA
    #export CUDA_PATH=/usr/local/cuda-9.2
    #export PATH=$CUDA_PATH/bin:$PATH

    # HYPRE
    export HYPRE_DIR=/opt/hypre/hypre-2.18

fi


# hack for my laptop

if [ "`cat /etc/machine-id`" == "cbd4091cb4e449679f543c1f61d6b4cf" ]; then
    alias zoom="QT_DEVICE_PIXEL_RATIO=2 zoom"
fi

