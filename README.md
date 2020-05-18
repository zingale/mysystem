# Fedora Configuration Notes

updated for Fedora 31

## change root password

```
sudo passwd root
```

## Post Install

```
dnf update
dnf install emacs
```

## show grub menu (it is hidden by default)

```
grub2-editenv - unset menu_auto_hide
```

(see https://hansdegoede.livejournal.com/19081.html, https://fedoraproject.org/wiki/Changes/HiddenGrubMenu )

## change root prompt

edit `/root/.bashrc/` and add:

```
export PS1='\[\e[1;31m\][\u@\h \W]# \[\e[0m\]'
```

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
fail2ban-client status sshd
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
pip3 install numba --user
```

for jupyter lab,
as root:
```
dnf install nodejs
```
as user:
```
pip3 install jupyterlab --user
jupyter lab build
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
pip3 install sphinxcontrib-bibtex --user
pip3 install breathe --user

dnf install pandoc
```

## Julia

```
dnf install julia
```

at the julia prompt:
```
using Pkg
Pkg.add("IJulia")

```
then you can select the Julia kernel from Jupyter


## LaTeX

First line gets most of what is needed.  The remaining packages are used
by some of my docs:

```
dnf install texlive texlive-collection-latex texlive-collection-fontsrecommended texlive-collection-latexextra
dnf install texlive-epstopdf*
dnf install texlive-latexdiff

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
dnf install gcc-gfortran gcc-c++ redhat-rpm-config
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

BLAS

```
dnf install openblas openblas-devel
```


## Other Useful Packages

```
dnf install stellarium gnuplot

dnf install motif motif-devel
dnf install libXpm libXpm-devel
dnf install lyx-fonts
dnf install keepass
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
  * edge-tiling: off (this prevents window from maximizing when it hits the top of the screen)
  * focus is secondary click
  * turn on maximize and minimize

### connector

```
dnf install chrome-gnome-shell
```

### sound selector:

https://extensions.gnome.org/extension/906/sound-output-device-chooser/


## Multimedia

### rpmfusion

Enable rpmfusion:

```
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

disable the rpmfusion-nonfree.repo and rpmfusion-nonfree-updates.repo



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


### other fonts

```
dnf install adf-gillius-fonts
```

### Movies

```
dnf install mplayer mencoder gstreamer-plugins-* gstreamer-ffmpeg gstreamer1-libav ffmpeg
```

### Images

```
dnf install inkscape gthumb gimp
```


## Communication

### Slack:

Download from: https://slack.com/downloads/linux


## Nvidia

### Wayland:

need to remove disable wayland in gdm:

  * edit `/etc/gdm/custom.conf`

  * uncomment: `WaylandEnable=False`


### Drivers

Best to install via CUDA (make sure the rpmfusion-nonfree stuff is disabled)


```
rpm -i https://developer.download.nvidia.com/compute/cuda/repos/fedora27/x86_64/cuda-repo-fedora27-10.0.130-1.x86_64.rpm
dnf install cuda
```

That will install the drivers and  CUDA

For multiple GPUs, set which is wanted for CUDA via:
```
export CUDA_VISIBLE_DEVICES=1
```
(e.g. for device `1`)

Test it with

```
nvidia-smi
```


## PGI compilers

```
dnf install libatomic
dnf install ncurses-compat-libs
```

untar pgilinux-2018-1810-x86-64.tar.gz and run

```
./install
```

accept everything.  The license bit will fail, so do

```
ln -s /lib64/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3
```

then in `/opt/pgi/linux86-64/18.10/bin`, run

```
./pgi_license_tool
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


### GCC 8

The above will get the PGI compilers working with MPI, but not with
CUDA, since CUDA 10.2 does not support GCC 9.x.  To fix this we need
to install GCC 8.x and link PGI with them and have them be the
compilers to use with PGI/CUDA.

1. get the source

   ```
   wget http://www.netgull.com/gcc/releases/gcc-8.3.0/gcc-8.3.0.tar.gz
   ```

2. untar:

   ```
   tar xf gcc-8.3.0.tar.gz
   ```

3. get the needed packages

   ```
   cd gcc-8.3.0/
   ./contrib/download_prerequisites
   ```

4. make it

   in top dir (above `gcc-8.3.0/`)

   ```
   mkdir objdir
   cd objdir
   ../gcc-8.3.0/configure --prefix=/opt/gcc/gcc-8.3 --enable-languages=c,c++,fortran --disable-multilib --disable-libsanitizer

   make -j 16
   ```

5. as root:

   ```
   mkdir /opt/gcc/gcc-8.3
   make install
   ```


### make a GCC module file

in `/etc/modulefiles/gcc`, add `8.3`:

```
#%Module1.0#####################################################################
##
## modules gcc8.3
##
## modulefiles/gcc-8.3
##
proc ModulesHelp { } {
        global version modroot

        puts stderr "gcc/8.3 - sets the Environment for GCC 9.3"
}

module-whatis   "Sets the environment for using gcc-8.3.0 compilers (C, C++, Fortran)"

# for Tcl script use only
set     topdir          /opt/gcc/gcc-8.3
set     version         8.3
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
#prepend-path    LD_LIBRARY_PATH $topdir/lib64
```

Note, that last `LD_LIBRARY_PATH` bit does not seem to be needed
so it is commented out.

Now we can `module load gcc/8.3` to use these compilers.

### PGI

get PGI to recognize these
```
cd /opt/pgi/linux86-64/19.10/bin
module load gcc/8.3
makelocalrc `pwd` -gcc /opt/gcc/gcc-8.3/bin/gcc -gpp /opt/gcc/gcc-8.3/bin/g++ -g77 /opt/gcc/gcc-8.3/bin/gfortran -x -net
```

To use CUDA/nvcc, we will always need to do:
```
module load gcc/8.3
```
first.

## Solvers

### hypre w/ GPU support

```
git clone git@github.com:hypre-space/hypre.git
cd hypre/src
module load gcc/8.3
module swap mpi mpi/mpi-pgi
HYPRE_CUDA_SM=70 CXX=mpicxx CC=mpicc FC=mpifort ./configure --prefix=/path/to/Hypre/install --with-MPI --with-cuda --enable-unified-memory
make -j 4
make install
```


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


## Sending mail

Fedora uses postfix
```
dnf install postfix
dnf install mailx
```

(mailx provides the `mail` command)

See this: https://docs.fedoraproject.org/en-US/fedora/f28/system-administrators-guide/servers/Mail_Servers/index.html

> The default /etc/postfix/main.cf file does not allow Postfix to
> accept network connections from a host other than the local
> computer.

Since that is what we want (only us to send), we can just do:
```
systemctl enable postfix.service
systemctl start postfix.service
```

To look at mail logs to debug, do:
```
journalctl --no-pager -t postfix/smtp
```

## RAID management

Software RAID with mdm

### Fresh install on system with existing array

Create the mount point:
```
mkdir /raid
```

Make sure the raid is found.  You can use `lsblk` to list all of the
block devices on the system, and this will show which are parts of the
RAID, or you can examine them one-by-one with
```
mdadm --examine /dev/sdb1
```

To get details, do:
```
mdadm --detail /dev/md0
```

or
```
cat /proc/mdstat
```

To create the configuration file that allows the device to be mounted, do:
```
mdadm --detail --scan > /etc/mdadm.conf
```

Then you can mount this by adding to the fstab:
```
/dev/md0               /raid  ext4    defaults        1 2
```

Alternately, we can get the UUID of the filesystem via:
```
blkid /dev/md0
```

and then mount via UUID as:
```
UUID=a2c185fd-44f7-44a7-8410-4768e44848d6    /raid                   ext4    defaults        1 2
```

### Rebuilding

If a disk dropped out of the array, you can add it via:
```
mdadm --manage /dev/md0 --add /dev/sdb1
```

You can see the status as
```
cat /proc/mdstat
```

or via:
```
mdadm --detail /dev/md0
```

Once you add, the rebuild should start immediately, and will be seen
in the above status


### have mdadm send e-mail alerts:

https://dustymabe.com/2012/01/29/monitor-raid-arrays-and-get-e-mail-alerts-using-mdadm/

add
```
MAILADDR michael.zingale@stonybrook.edu
```
to `/etc/mdadm.conf`

test this with:
```
mdadm --monitor --scan --test -1
```

enable monitoring

https://raid.wiki.kernel.org/index.php/Detecting,_querying_and_testing
```
mdadm --monitor --daemonise --mail=michael.zingale@stonybrook.edu --delay=1800 /dev/md0
```
upon reboot, the mdadm daemon appears to run as:
```
/sbin/mdadm --monitor --scan -f --pid-file=/var/run/mdadm/mdadm.pid
```


## SMART monitoring

Disk health monitoring with smartctl
```
dnf install smartmontools
```

edit `/etc/smartmontools/smartd.conf`

comment out the first `DEVICESCAN` line and put an explicit entry for
each device:
```
/dev/sda -H -s L/../../7/04 -m michael.zingale@stonybrook.edu -M test
/dev/sdb -H -s L/../../6/04 -m michael.zingale@stonybrook.edu -M test
/dev/sdc -H -s L/../../5/04 -m michael.zingale@stonybrook.edu -M test
/dev/nvme0n1 -H	-m michael.zingale@stonybrook.edu -M test
```

Here:
  * `-H` means health check
  * `-s L/../../7/04` means run a long test every Sunday at 4am
  * `-m X` means mail `X` with any errors
  * `-M test` means send a single test email upon smartd startup -- to verify
   that monitoring is working


Note: you won't get the test e-mails unless you have the `mailx` command
installed.


## webserver

```
dnf install httpd
```

in `/etc/httpd/conf/httpd.conf`

change:

```
ServerName groot.astro.sunysb.edu:80
```

change:

DocumentRoot to "/raid/www/"

Beneath that, leave the `/var/www` block alone, but under that,
change the `/var/www/html` block to `/raid/www` to relax access
in the html directory.

create an index.html there:

<html>
<body>
<div style="width: 100%; font-size: 40px; font-weight: bold; text-align: center;">
groot.astro.sunysb.edu test page
</div>
</body>
</html>


now tell selinux to copy the original /var/www/html permissions:

chcon -R --reference=/var/www/html /raid/www

do

```
apachectl reload
systemctl restart httpd.service
systemctl enable httpd.service
```

open the firewall

```
dnf install firewall-config
```

then run firewall-config, select the "permanent" configuration from
the dropdown and check `http`.  (permanent becomes runtime in the next
boot).

The test page should appear



# Handy commands

## Debugging services

List failed services:
```
systemctl list-units --state=failed
```

What's happening with startup:
```
systemd-analyze critical-chain
```

# Libreoffice

Turn off "use background cache":

Tools->options->LibreOffice Impress-> General,

supposed to help with flickering.
