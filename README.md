# Fedora Configuration Notes

## Fedora 27


### Post Install

dnf update
dnf install emacs


### Securing

SSH
---

start sshd:
```
systemctl enable sshd
systemctl start sshd
```

securing against root login:

* edit /etc/ssh/sshd_config

* change:
  ```
  #PermitRootLogin        yes
  ```
  to
  ```
  PermitRootLogin no
  ```

fail2ban
--------

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



dnf install stellarium gnuplot python3-matplotlib python3-f2py gv enscript
dnf install gcc-gfortran gcc-c++
dnf install motif motif-devel levien-inconsolata-fonts mpich mpich-devel mpich-autoload
dnf install libXpm-devel
dnf install lyx-fonts gnome-tweak-tool python3-Cython
dnf install python3-scipy openssl-devel ack gthumb
dnf install ipython3
dnf install texlive texlive-collection-latex texlive-collection-fontsrecommended texlive-collection-latexextra
dnf install inkscape xxdiff levien-inconsolata-fonts

----



----

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

----

MS Core Fonts:

http://mscorefonts2.sourceforge.net/

dnf install curl cabextract xorg-x11-font-utils fontconfig
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm


----

dnf install mplayer mencoder gstreamer-plugins-{good,bad,ugly} gstreamer-ffmpeg gstreamer1-libav ffmpeg

----

turn off maximize when windows hit top of screen

dnf install dconf-editor

dconf-editor
set org.gnome.shell.overrides.edge-tiling to disabled

----

dnf install texlive-epstopdf*
dnf install python3-sympy openssl-devel ack netpbm-progs gthumb revelation

----

printer via dialog

----

dnf install python3-h5py

pip3 install pytest --user

---

pip3 install jupyter --user
pip3 install nbsphinx --user
pip3 install numpydoc --user
pip3 install sphinx_rtd_theme --user


dnf install pandoc

----

download slack: https://slack.com/downloads/linux
dnf install slack-3.0.5-0.1.fc21.x86_64.rpm

----

dnf install 'tex(raleway.sty)'
dnf install 'tex(ly1enc.def)'
dnf install 'tex(inconsolata.sty)'
dnf install 'tex(cantarell.sty)'
dnf install texlive-revtex

----

dnf install screen

dnf install valgrind

----

dnf install python3-pylint python3-pyflakes
