# Fedora Configuration Notes

updated for Fedora 33

## change root password

```
sudo passwd root
```

## Post Install

```
dnf update
dnf install emacs
```

## hostname

```
hostnamectl set-hostname new-name
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


(for CentOS, do: `dnf install epel-release`)

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

For CentOS, do:
```
alternatives --set python /usr/bin/python3
```

Install core packages via `dnf`, install rapidly changing/specialty ones through
pip.

```
dnf install python3-scipy ipython3 python3-matplotlib python3-sympy
dnf install python3-f2py python3-Cython python3-h5py
dnf install python3-pylint python3-pyflakes
dnf install python3-ipython-sphinx
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
pip3 install sphinx-copybutton --user
pip3 install sphinx-prompt --user
```

```
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
dnf install pdfmerge
```

Also useful for publishing:

```
dnf install gv enscript netpbm-progs
```


## Developing

```
dnf install gcc-gfortran gcc-c++ redhat-rpm-config make
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
dnf install keepassx
```


## GNOME

```
dnf install gnome-tweaks levien-inconsolata-fonts
```

terminal shortcut:  settings -> keyboard -> view and customize shortcuts

   select "custom shortcuts", and add one for `gnome-terminal` assigned to F1

Run `gnome-tweaks`:

* fonts:
  * hinting: full
  * antialiasing: subpixel
  * set monospace font to Inconsolata Medium / 11 pt

* topbar: turn on date

* window titlebars:
  * turn on maximize and minimize

* windows
  * edge-tiling: off (this prevents window from maximizing when it hits the top of the screen)
  * focus is secondary click

### Extensions

```
dnf install gnome-extensions-app
```

then run "extensions" via the software search

* extensions: turn on window list




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
dnf install adf-gillius-fonts mozilla-fira-sans-fonts*

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
dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/fedora33/x86_64/cuda-fedora33.rep
dnf module install nvidia-driver:latest-dkms
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


## HIP/ROCm

follow: https://rigtorp.se/notes/rocm/

add `/etc/yum.repos.d/ROCm.repo`:

```
[ROCm]
name=ROCm
baseurl=http://repo.radeon.com/rocm/centos8/rpm
enabled=1
gpgcheck=1
gpgkey=http://repo.radeon.com/rocm/rocm.gpg.key
```

```
dnf install rocm-device-libs hsakmt-roct hip-samples hipify-clang
```

```
dnf repoquery --location rocminfo
```

using that output:
```
rpm -Uvh --nodeps http://repo.radeon.com/rocm/centos8/rpm/rocminfo-1.4.0.1.rocm-rel-4.0-23-605b3a5.rpm
```

fix shebang for python in `/opt/rocm-4.0.0/bin/rocm_agent_enumerator` to be `/usr/bin/python`
(need to temporarily `chmod a+w /opt/rocm-4.0.0/bin/rocm_agent_enumerator`)



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


## Nameserver

If the nameserver is not working do:

```
systemctl restart systemd-resolved
```


## Handy commands

### Debugging services

List failed services:
```
systemctl list-units --state=failed
```

What's happening with startup:
```
systemd-analyze critical-chain
```

## Libreoffice

Turn off "use background cache":

Tools->options->LibreOffice Impress-> General,

supposed to help with flickering.


## wacom

Plugged in and it was recognized as "android touchpad" in the settings
panel for it.  Following hints online, I held down the first and last
button for a few seconds -- X restarted and it came up as a tablet.
Eventually the stylus options appeared in the panel as well.

I am using it in relative mode and it works great with Xournal++::

  dnf install xournalpp


## system upgrades

If a system upgrade doesn't take do:
```
dnf system-upgrade log 
```
you might need to specify a number, like:
```
dnf system-upgrade log --number 2
```

## laptop battery

```
dnf install tlp tlp-rdw
systemctl enable tlp.service
```

## firmware updates

Firmware updates are handled by gnome-software.  This frequently fails
to refresh.  Do the following:

## gnome software

```
killall gnome-software
rm -rf ~/.cache/gnome-software
```


## Zoom

Hack to get Zoom working with GNOME 41 + Wayland:

1. press ALT+F2
2. enter `lg`
3. enter `global.context.unsafe_mode=true`

see this thread: https://community.zoom.com/t5/Meetings/Wayland-screen-sharing-broken-with-GNOME-41-on-Fedora-35/m-p/22539

## Zotero

download from: https://www.zotero.org/download/

```
tar xf Zotero-5.0.96.3_linux-x86_64.tar.bz2
```

move the full directory into ~/system and do a symlink f `zotero` into
`~/bin`

also install the chrome zotero connector extension

## Cosair keyboard

```
dnf install ckb-next
```

run `ckb-next`

