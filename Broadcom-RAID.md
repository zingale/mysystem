# Working with the Broadcom RAID

show status:

```
 /opt/MegaRAID/storcli/storcli64 /c0 show
```


For more information:

```
/opt/MegaRAID/storcli/storcli64 /c0 /eall /sall show
```

This will show something like:

```
------------------------------------------------------------------------------
EID:Slt DID State  DG      Size Intf Med SED PI SeSz Model            Sp Type 
------------------------------------------------------------------------------
252:0    28 Onln    0 16.370 TB SAS  HDD N   N  512B MG09SCA18TE      U  -    
252:1    29 UBUnsp  -      0 KB SAS  HDD N   N  512B MG09SCA18TE      U  -    
252:2    30 Onln    0 16.370 TB SAS  HDD N   N  512B MG09SCA18TE      U  -    
252:3    31 Onln    0 16.370 TB SAS  HDD N   N  512B MG09SCA18TE      U  -    
252:4    25 Onln    0 16.370 TB SAS  HDD N   N  512B MG09SCA18TE      U  -    
252:5    24 Onln    0 16.370 TB SAS  HDD N   N  512B MG09SCA18TE      U  -    
252:6    26 Onln    0 16.370 TB SAS  HDD N   N  512B MG09SCA18TE      U  -    
252:7    27 Onln    0 16.370 TB SAS  HDD N   N  512B MG09SCA18TE      U  -    
------------------------------------------------------------------------------
```

The ones that show state "Onln" are part of the RAID.

To see info about a specific disk:

```
/opt/MegaRAID/storcli/storcli64 /c0 /e 252 /s 1 show all
```

Check redundancy:

```
/opt/MegaRAID/storcli/storcli64 /c0 /vall show
```


