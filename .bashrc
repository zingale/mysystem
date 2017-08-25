# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ssh='ssh -Y'

alias ipython='ipython3'

export SVN_EDITOR=vi


# MPI/gfortran 
export GFORTRAN_UNBUFFERED_ALL=1

# BoxLib python
export PYTHONPATH="/home/zingale/development/AmrPostprocessing/python"
export PATH=/home/zingale/development/AmrPostprocessing/python:$PATH

# Microphysics / Maestro
export MICROPHYSICS_HOME="/home/zingale/development/Microphysics"
export MAESTRO_HOME="/home/zingale/development/MAESTRO"

# AMReX / BoxLib
export BOXLIB_HOME="/home/zingale/development/BoxLib/"
export BOXLIB_USE_MPI_WRAPPERS=1
export AMREX_HOME="/home/zingale/development/AMReX/"

# Castro
export CASTRO_HOME="/home/zingale/development/Castro"

# plotting numerical exercises
export PYTHONPATH="$PYTHONPATH:/home/zingale/classes/numerical_exercises/:/home/zingale/development/pyro2/:/home/zingale/classes/astro_animations"

# visit
#export PATH="/usr/local/visit/bin:${PATH}"

# pyro
export PYRO_HOME="/home/zingale/development/pyro2/"

# pyreaclib
export PYTHONPATH="$PYTHONPATH:/home/zingale/development/pyreaclib"

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


if [ -e /usr/local/hypre ]; then
    export HYPRE_DIR=/usr/local/hypre
fi
