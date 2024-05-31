Following:

https://www.redhat.com/sysadmin/raid-drive-mdadm
https://www.thegeekdiary.com/replacing-a-failed-mirror-disk-in-a-software-raid-array-mdadm/

```
# more /proc/mdstat 
Personalities : [raid6] [raid5] [raid4] 
md0 : active raid5 sdc1[1] sdb1[0] sdd1[3]
      7813771264 blocks super 1.2 level 5, 512k chunk, algorithm 2 [3/3] [UUU]
      bitmap: 0/30 pages [0KB], 65536KB chunk
```


* Sync the caches

```
sync
```

* Mark the bad disk as failed

```
mdadm --manage /dev/md0 --fail /dev/sdb1
```

and check

```
# more /proc/mdstat 
Personalities : [raid6] [raid5] [raid4] 
md0 : active raid5 sdc1[1] sdb1[0](F) sdd1[3]
      7813771264 blocks super 1.2 level 5, 512k chunk, algorithm 2 [3/2] [_UU]
      bitmap: 0/30 pages [0KB], 65536KB chunk

unused devices: <none>
```

* remove

```
mdadm --manage /dev/md0 --remove /dev/sdb1
```

# physically swap the disk

...

# replicate partition table

```
sgdisk -R /dev/sdb /dev/sdc
sgdisk -G /dev/sdb 
```

The first command replaces `/dev/sdb` with the version on `/dev/sdc`.
The second command scrambles the GUID.

```
# parted /dev/sdb print
Model: ATA WDC WD4003FFBX-6 (scsi)
Disk /dev/sdb: 4001GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: pmbr_boot

Number  Start   End     Size    File system  Name  Flags
 1      1049kB  4001GB  4001GB                     raid
```

# add back and verify

```
# mdadm --manage /dev/md0 --add /dev/sdb1
mdadm: added /dev/sdb1
```

```
#  /sbin/mdadm --detail /dev/md0
/dev/md0:
           Version : 1.2
     Creation Time : Tue Oct 17 18:09:31 2017
        Raid Level : raid5
        Array Size : 7813771264 (7.28 TiB 8.00 TB)
     Used Dev Size : 3906885632 (3.64 TiB 4.00 TB)
      Raid Devices : 3
     Total Devices : 3
       Persistence : Superblock is persistent

     Intent Bitmap : Internal

       Update Time : Tue Jan 18 10:39:19 2022
             State : clean, degraded, recovering 
    Active Devices : 2
   Working Devices : 3
    Failed Devices : 0
     Spare Devices : 1

            Layout : left-symmetric
        Chunk Size : 512K

Consistency Policy : bitmap

    Rebuild Status : 0% complete

              Name : asl137.aslab.com:0
              UUID : f644a57c:73d31e75:802260f3:813003e3
            Events : 77443

    Number   Major   Minor   RaidDevice State
       4       8       17        0      spare rebuilding   /dev/sdb1
       1       8       33        1      active sync   /dev/sdc1
       3       8       49        2      active sync   /dev/sdd1
```


