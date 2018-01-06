
# First download the file
wget https://support.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-1.8/hdf5-1.8.20/src/hdf5-1.8.20.tar

# untar
tar -xf hdf5-1.8.20.tar
cd hdf5-1.8.20
./configure --prefix=/home/solak/Workdir/tempdir/Workdir/fortan_project/myLib/hdf5 --enable-fortran
make
make ckeck
make install
make check-install

# Clean up
#cd ..
#rm -r hdf5-1.8.20
#rm hdf5-1.8.20.tar
