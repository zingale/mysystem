install packages:

```
dnf install gdal-devel mpv mpv-libs mpv-devel libXxf86vm libXxf86vm-devel curl-devel
```

clone:

```
git clone --recursive git@github.com:OpenSpace/OpenSpace.git
```

(use the development version to get the fixes here:
https://github.com/OpenSpace/OpenSpace/pull/3548)


make:

```
cmake -E make_directory build
cmake -E chdir build cmake ..
cd build
make -j 6
```



to run, first do:

```
export LD_PRELOAD=/usr/lib64/libvulkan.so.1
```
