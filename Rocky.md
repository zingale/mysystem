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
dnf install python3.12
```

## GCC

```
dnf install gcc-toolset-14
```

Then enable it via:

```
scl enable gcc-toolset-14 bash
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
