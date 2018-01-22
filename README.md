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
dnf install gv enscript
```




## Developing

dnf install gcc-gfortran gcc-c++
xxdiff
dnf install valgrind
dnf install screen
 mpich mpich-devel mpich-autoload




dnf install stellarium gnuplot
ack gthumb
dnf install motif motif-devel levien-inconsolata-fonts
dnf install libXpm-devel
dnf install lyx-fonts gnome-tweak-tool 

dnf install inkscape levien-inconsolata-fonts

----



## GNOME

gnome:

 -- system-settings -> keyboard -> shortcuts, assign F1 to launch terminal

 -- gnome-tweak-tool:

    * extensions: turn on window list
    * fonts:
        - hinting: full
	- antialiasing: subpixel
    * topbar: turn on date
    * windows:
        - focus is secondary click
	- turn on maximize and minimize


turn off maximize when windows hit top of screen

dnf install dconf-editor

dconf-editor
set org.gnome.shell.overrides.edge-tiling to disabled


## Multimedia


### MS Core Fonts:

http://mscorefonts2.sourceforge.net/

dnf install curl cabextract xorg-x11-font-utils fontconfig
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

### Movies

dnf install mplayer mencoder gstreamer-plugins-{good,bad,ugly} gstreamer-ffmpeg gstreamer1-libav ffmpeg


----


dnf install openssl-devel ack netpbm-progs gthumb revelation

----

printer via dialog

----





----

download slack: https://slack.com/downloads/linux
dnf install slack-3.0.5-0.1.fc21.x86_64.rpm

