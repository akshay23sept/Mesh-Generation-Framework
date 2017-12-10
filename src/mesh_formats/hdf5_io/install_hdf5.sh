tar -xf hdf5-1.8.20.tar
cd hdf5-1.8.20
./configure --enable-fortran
make
make ckeck
make install
make check-install

