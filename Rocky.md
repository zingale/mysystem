# Rocky Linux 9

dnf config-manager --set-enabled crb
dnf install epel-release

dnf install emacs

dnf install ipython3

dnf install texlive texlive-latex texlive-collection-*
dnf install texlive-revtex4

dnf install mpich mpich-devel mpich-autoload

dnf install gnuplot

## python

```
dnf install python3.13 python3.13-pip
```

to register this kernel with Jupyter do:

```
pip3.13 install ipykernel
python3.13 -m ipykernel install --user --name mypython313 --display-name "Python 3.13 (Custom)"
```

then make sure it shows up:

```
pip3.13 install jupyter
jupyter kernelspec list
```


## GCC

```
dnf install gcc-toolset-15
gcc-toolset-15-gcc-plugin-annobin
```

Then enable it via:

```
scl enable gcc-toolset-15 bash
```

## changing IP and hostname

use `nmtui` and then

```
systemctl restart NetworkManager
```

## Setting up RAID

Identify the drives:

```
lsblk
```

In my case, GPT was already setup but I needed to partition them with fdisk:

```
fdisk /dev/sda
n
1
```
accept all defaults, then do the same with `/dev/sdb`

Then

```
mdadm --examine /dev/sda1 /dev/sdb1
```

Now create the RAID:

```
mdadm --create /dev/md0 --level=mirror --raid-devices=2 /dev/sda1 /dev/sdb1
mdadm --detail /dev/md0
mkfs.ext4 /dev/md0
```

create the mountpoint:

```
mkdir /raid
```

Add to `/etc/fstab`:
```
/dev/md0               /raid                       ext4    defaults        1 2
```

Then
```
mount /raid
```
