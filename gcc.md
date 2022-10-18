### GCC 7

The above will get the PGI compilers working with MPI, but not with
CUDA, since CUDA 10.0 does not support GCC 8.x.  To fix this we need
to install GCC 7.x and link PGI with them and have them be the
compilers to use with PGI/CUDA.

1. get the source

   ```
   wget http://www.netgull.com/gcc/releases/gcc-8.3.0/gcc-8.3.0.tar.gz
   ```

2. untar:

   ```
   tar xf gcc-8.3.0.tar.gz
   ```

3. get the needed packages

   ```
   cd gcc-8.3.0/
   ./contrib/download_prerequisites
   ```

4. make it

   in top dir (above gcc-8.3.0)

   ```
   mkdir objdir
   cd objdir
   ../gcc-8.3.0/configure --prefix=/opt/gcc/gcc-8.3 --enable-languages=c,c++,fortran --disable-multilib --disable-libsanitizer

   make -j 16
   ```

5. as root:

   ```
   mkdir /opt/gcc/gcc-8.3
   make install
   ```


### make a GCC module file

in `/etc/modulefiles/gcc`, add `8.3`:

```
#%Module1.0#####################################################################
##
## modules gcc8.3
##
## modulefiles/gcc-8.3
##
proc ModulesHelp { } {
        global version modroot

        puts stderr "gcc/8.3 - sets the Environment for GCC 9.3"
}

module-whatis   "Sets the environment for using gcc-8.3.0 compilers (C, C++, Fortran)"

# for Tcl script use only
set     topdir          /opt/gcc/gcc-8.3
set     version         8.3
#set     sys             linux86

setenv          CC              $topdir/bin/gcc
setenv          GCC             $topdir/bin/gcc
setenv          CXX             $topdir/bin/g++
setenv          FC              $topdir/bin/gfortran
setenv          F77             $topdir/bin/gfortran
setenv          F90             $topdir/bin/gfortran
prepend-path    PATH            $topdir/include
prepend-path    PATH            $topdir/bin
prepend-path    MANPATH         $topdir/man
prepend-path    LD_LIBRARY_PATH $topdir/lib64
```

now we can `module load gcc/8.3` to use these compilers.
