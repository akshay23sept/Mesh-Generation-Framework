#config v2
echo "Mesh Generation Framework"
echo "Checking for dependencies"
#check dependencies
        #gfortran #hdf5lib1.8 
#install dependencies
echo "Installing dependencies"
#wget https://support.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-1.8/hdf5-1.8.20/src/hdf5-1.8.20.tar
tar -xf hdf5-1.8.20.tar
cd hdf5-1.8.20
./configure --prefix=/home/aero/workdir/MeshGeneration-Framework/myLib/hdf5 --enable-fortran
make
make ckeck
make install
make check-install
# Clean 
cd ..
rm -r hdf5-1.8.20
rm hdf5-1.8.20.tar

 

#build
echo "Building from source" 
rm -r ./bin
mkdir bin 
cd ./src

#cleaning
echo "Checking and removing previous buid(s), if any"
find . -type f -name '*.o' -delete
find . -type f -name '*.mod' -delete
find . -type f -name '*.exe' -delete

echo "Building . . . . "
mkdir temp
find . -type f -name 'module_*.f90' -exec cp -r -t ./temp/ {} +
cd temp 
#compile priority modules
gfortran -c module_precision.f90
/home/aero/workdir/MeshGeneration-Framework/myLib/hdf5/bin/h5fc -c module_hdfwrite.f90
/home/aero/workdir/MeshGeneration-Framework/myLib/hdf5/bin/h5fc -c precision.f90
#gfortran -I/home/aero/workdir/MeshGeneration-Framework/myLib/hdf5 -lHDF5 -c module_hdfwrite.f90
#hdf5-1.8.20/hdf5/bin/h5fc -c module_hdfwrite.f90
#h5fc module_hdfwrite.f90 -o hdf5write #this is really the best way

#compile all other modules
gfortran -c module_*.f90
cp ../MeshGeneration_Framework.f90 MeshGeneration_Framework.f90
gfortran *.o MeshGeneration_Framework.f90 -o MeshGeneration_Framework.f90
cp MeshGeneration_Framework.f90 ../../bin/MeshGeneration_Framework.f90

#goto src
cd ..
#clean
rm -r temp
#goto / of project
cd ..

echo "Build completed successfully"


#automatic test ----IF Possible
#echo "Performing tests(s)"
#cd ./bin
#./MeshGeneration_Framework.f90 testParam
#echo "Test was successfull !"

