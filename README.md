# Fedora Configuration Notes

This is based on a USB live install of Fedora 27


## Post Install

dnf update
dnf install emacs


## Securing

### SSH

start sshd:
```
systemctl enable sshd
systemctl start sshd
```

securing against root login:

* edit `/etc/ssh/sshd_config`

* change:
  ```
  #PermitRootLogin        yes
  ```
  to
  ```
  PermitRootLogin no
  ```

### fail2ban

install:

* `dnf install fail2ban`

* look over `/etc/fail2ban/jail.conf` for the configuration

* create `/etc/fail2ban/jail.local`:
  ```
  [DEFAULT]
  bantime = 3600
  backend = systemd
  sender = fail2ban@example.com
  destemail = root
  #action = %(action_mwl)s

  [sshd]
  enabled = true
  ```

* start it:
  ```
  systemctl start fail2ban
  systemctl enable fail2ban
  ```

to see the status:
```
fail2ban-client  status sshd
```
to unban, do:
```
fail2ban-client set sshd unbanip <IP>
```


## python

Install core packages via `dnf`, install rapidly changing/specialty ones through
pip.

```
dnf install python3-scipy ipython3 python3-matplotlib python3-sympy
dnf install python3-f2py python3-Cython python3-h5py
dnf install python3-pylint python3-pyflakes
```

```
pip3 install jupyter --user
```

Needed for development:
```
dnf install openssl-devel
```

Testing infrastructure:
```
pip3 install pytest --user
```

Sphinx infrastructure:
```
pip3 install nbsphinx --user
pip3 install numpydoc --user
pip3 install sphinx_rtd_theme --user

dnf install pandoc
```


## LaTeX

First line gets most of what is needed.  The remaining packages are used
by some of my docs:
```
dnf install texlive texlive-collection-latex texlive-collection-fontsrecommended texlive-collection-latexextra
dnf install texlive-epstopdf*

dnf install 'tex(raleway.sty)'
dnf install 'tex(ly1enc.def)'
dnf install 'tex(inconsolata.sty)'
dnf install 'tex(cantarell.sty)'
dnf install texlive-revtex
```

Also useful for publishing:
```
dnf install gv enscript netpbm-progs
```


## Developing

```
dnf install gcc-gfortran gcc-c++
dnf install valgrind
dnf install libasan libubsan
```

Useful tools:
```
dnf install screen xxdiff ack
```

MPI:
```
dnf install  mpich mpich-devel mpich-autoload
```


## Other Useful Packages

```
dnf install stellarium gnuplot

dnf install motif motif-devel
dnf install libXpm libXpm-devel
dnf install lyx-fonts
dnf install revelation
```


## GNOME

```
dnf install gnome-tweak-tool levien-inconsolata-fonts
```

terminal shortcut:  system-settings -> keyboard -> shortcuts, assign F1 to launch terminal

Run `gnome-tweak-tool`:

* extensions: turn on window list

* fonts:
  * hinting: full
  * antialiasing: subpixel
  * set monospace font to Inconsolata

* topbar: turn on date

* windows:
  * focus is secondary click
  * turn on maximize and minimize


### turn off maximize when windows hit top of screen

```
dnf install dconf-editor
```

Run `dconf-editor` and
set `org.gnome.shell.overrides.edge-tiling` to `disabled`


## Multimedia

### rpmfusion

Enable rpmfusion:

```
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```


### MS Core Fonts:

based on http://mscorefonts2.sourceforge.net/

```
dnf install curl cabextract xorg-x11-font-utils fontconfig
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
```

### Raleway fonts:

download raleway.zip from http://www.fontsquirrel.com/fonts/raleway

unzip

```
cd /usr/share/fonts
mkdir raleway
```

copy .ttf into raleway/
```
fc-cache -v
```

### Movies

```
dnf install mplayer mencoder gstreamer-plugins-{good,bad,ugly} gstreamer-ffmpeg gstreamer1-libav ffmpeg
```

### Images

```
dnf install inkscape gthumb gimp
```


## Communication

### Slack:

download slack: https://slack.com/downloads/linux
```
dnf install slack-3.0.5-0.1.fc21.x86_64.rpm
```

## Nvidia

### Wayland:

need to remove disable wayland in gdm:

  * edit `/etc/gdm/custom.conf`

  * uncomment: `WaylandEnable=False`


### Drivers

Do:
```
dnf install akmod-nvidia
```

Make sure it is pulling from rpmfusion.


### CUDA

Important, don't get the Xorg stuff from the Nvidia repo -- continue
getting it from rpmfusion.  Just get CUDA from Nvidia.


## PGI compilers

### Installing old GCC (probably not needed)

We need an older version of GCC since PGI tends not to be compatible
with the latest.

  * `wget http://gcc.parentingamerica.com/releases/gcc-5.4.0/gcc-5.4.0.tar.gz`

  * `tar xvzf gcc-5.4.0.tar.gz`

  * `cd gcc-5.4.0`

  * `./contrib/download_prerequisites`

  * in top dir,

    ```
    mkdir objdir/
    cd objdir/
    ../gcc-5.4.0/configure --prefix=/opt/gcc/gcc-5.4/ --enable-languages=c,c++,fortran --disable-multilib
    ```

  * `make -j 8`

  * (as root)

    ```
    mkdir /opt/gcc/gcc-5.4
    make install
    ```

Now create a module file:

```
#%Module1.0#####################################################################
##
## modules gcc/5.4
##
## modulefiles/gcc/5.4
##
proc ModulesHelp { } {
        global version modroot

        puts stderr "gcc/5.4 - sets the Environment for GCC 5.4 in my home directory"
}

module-whatis   "Sets the environment for using gcc-5.4.0 compilers (C, C++, Fortran)"

# for Tcl script use only
set     topdir          /opt/gcc/gcc-5.4
set     version         5.4
#set     sys             linux86

setenv          CC              $topdir/bin/gcc
setenv          GCC             $topdir/bin/gcc
setenv          CXX             $topdir/bin/g++
setenv          FC              $topdir/bin/gfortran
setenv          F77             $topdir/bin/gfortran
setenv          F90             $topdir/bin/gfortran
prepend-path    PATH            $topdir/include
prepend-path    PATH            $topdir/bin
prepend-path    MANPATH         $topdir/man
prepend-path    LD_LIBRARY_PATH $topdir/lib
```

as `/etc/modulefiles/gcc/5.4`

now tell PGI to use these:

```
makelocalrc `pwd` -gcc /opt/gcc/gcc-5.4/bin/gcc -gpp /opt/gcc/gcc-5.4/bin/g++ -g77 /opt/gcc/gcc-5.4/bin/gfortran -x -net
```

### OpenMPI module

```
#%Module 1.0
#
#  MPICH module for use with 'environment-modules' package:
# 

# Only allow one mpi module to be loaded at a time
conflict mpich-x64_64

# Define prefix so PATH and MANPATH can be updated.
set MPI_HOME /opt/pgi/linux86-64/18.4/mpi/openmpi
setenv        MPI_HOME      $MPI_HOME
setenv        MPI_BIN       $MPI_HOME/bin
setenv        MPI_FORTRAN_MOD_DIR $MPI_HOME/lib
setenv        MPI_INCLUDE   $MPI_HOME/include
setenv        MPI_LIB       $MPI_HOME/lib
setenv        MPI_MAN       $MPI_HOME/share/man
#setenv        MPI_COMPILER  mpich-pgi
setenv        MPI_SUFFIX    _mpi
setenv        HYPRE_DIR     /usr/local/hypre-pgi-openmpi/

prepend-path  PATH          $MPI_HOME/bin
prepend-path  LD_LIBRARY_PATH $MPI_HOME/lib
prepend-path  LD_LIBRARY_PATH /opt/pgi/linux86-64/18.4/lib
prepend-path  LD_LIBRARY_PATH /opt/pgi/linux86-64/2018/mpi/openmpi/lib
prepend-path  MANPATH       $MPI_HOME/share/man
```

as `/etc/modulefiles/mpi/mpi-pgi`


## Solvers

### Trilinos

```
dnf install netcdf netcdf-devel matio matio-devel
```

crate a `do_config` script with

```
#!/bin/bash

cmake \
  -DTPL_ENABLE_MPI=ON \
  -DMPI_BASE_DIR=/usr/lib64/mpich \
  -DTrilinos_ENABLE_ALL_PACKAGES=ON \
  -DTrilinos_ENABLE_Epetra=OFF \
  -DTrilinos_ENABLE_FEI=OFF \
  -DCMAKE_INSTALL_PREFIX=/opt/trilinos \
  ../trilinos-12.12.1-Source
```

then `./do_config` and `make -j 8 install`

