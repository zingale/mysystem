Mounting an LVM partition with the same name as an existing one

* check partitions:

  ```
  fdisk -l /dev/sde
  ```

* make mount point

  ```
  mkdir /other
  ```

* scan for LVM volumes (and identify the volume name)

  ```
  vgscan
  ```

  Most likely it is Fedora, which will clash with your system

* rename the volume, by UUID

  ```
  vgdisplay
  ```

  identify the UUID of the LVM volume (you may have to rely on disk size, etc.)

  ```
  vgrename RjMM6h-PlFJ-Qo0g-PreR-yMyS-tK3p-tL420d other_disk
  ```

  Now the volume is named `other_disk`

* rescan and activate

  ```
  lvscan
  vgchange -a y
  ```

* mount

  ```
  mount /dev/other_disk/home /other
  ```