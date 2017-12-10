echo "compiling HDF5 file with raw data"
hdf5-1.8.20/hdf5/bin/h5fc hdf5write.f90 -o data
echo "running the compiled file"
./data
