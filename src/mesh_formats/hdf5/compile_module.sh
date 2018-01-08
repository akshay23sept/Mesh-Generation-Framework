#bash
/home/solak/Workdir/tempdir/Workdir/fortan_project/myLib/hdf5/bin/h5fc -c module_hdfwrite.f90
/home/solak/Workdir/tempdir/Workdir/fortan_project/myLib/hdf5/bin/h5fc -c precision.f90
/home/solak/Workdir/tempdir/Workdir/fortan_project/myLib/hdf5/bin/h5fc module_hdfwrite.o precision.o hdftest.f90 -o hfmesh.exe
./hfmesh.exe
