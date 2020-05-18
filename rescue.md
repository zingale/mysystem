Rescuing when there is a GRUB issue:

* burn the Fedora install image to a USB disk

* boot as normal

  (I got a blank screen and needed to do `esc` and then at the "boot:"
  prompt, type "linux")

* open terminal and setup for chroot:

  * following: https://docs.fedoraproject.org/en-US/Fedora/22/html/Multiboot_Guide/common_operations_appendix.html

  * mkdir /mnt/sysimage

  * blkid -- look for the root partition 

    for me it was lvm, so I needed to do:

    https://pario.no/2015/11/02/how-to-mount-lvm-partitions-from-rescue-mode/

    lvm vgscan -v
    vgchange -a y "fedora"
    lvm lvs --all

    then mount it

  * mount /dev/fedora/root /mnt/sysimage

    you should see /mnt/sysimage/etc/fedora-release if this is correct

  * find the boot partition (this will have the group folders).  For me
    it was /dev/sda1

    mount /dev/sda1 /mnt/sysimage/boot

  * mount the virtual filesystems:

    for dir in /dev /proc /sys; do mount --bind $dir /mnt/sysimage/$dir ; done

  * chroot /mnt/sysimage

Now fix grub:

  * following: https://fedoraproject.org/wiki/Common_F30_bugs#GRUB_boot_menu_is_not_populated_after_an_upgrade

  * cd to /boot/grub2

  * remake the grub.cfg:

    grub2-mkconfig -o /boot/grub2/grub.cfg

  * grub2-install /dev/sda





    
