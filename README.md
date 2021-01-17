# MeshGeneration-Framework #
Mesh Generation Framework as a part of Fortran Project by IMP Turbulence 2019 Batch

**Mesh with a special streching on wall normal direction**
![alt text] (https://github.com/akshay23sept/akshay23sept.github.io/blob/master/website/example.jpg)

### Compilation ###

- Go to build directory : 
    cd build 
    rm -f CMakeCache.txt

- Create Makefile with one of these command choosing compiler (gfortran, ifort, ...) 
  and build type (Debug, Release, ...).
  
  - To compile with compiler Release flags only  
  `FC=gfortran cmake -D PLATFROM_NAME=lmlm6-75 CMAKE_BUILD_TYPE=Debug  ..`
  `FC=mpif90.openmpi cmake -D PLATFROM_NAME=lmlm6-75 CMAKE_BUILD_TYPE=Debug  ..`

  - To compile with compiler Debug flags only  
  `FC=mpif90 cmake -D CMAKE_BUILD_TYPE=Debug -D PLATFROM_NAME=lmlm6-75 -DDEFINE_DEBUG=OFF  ..`

  - To compile with DEBUG preprocessor option, saves, prints more  
  `FC=mpif90 cmake -D CMAKE_BUILD_TYPE=Debug -D PLATFROM_NAME=lmlm6-75 -DDEFINE_DEBUG=ON  ..`

- Compile  
`make`

- Run tests, you should be on the build folder

  - Run the tests without Fruit outputs  
  `make test`
  
  - Run the tests with Fruit outputs  
  `make test ARGS="-V"`

- Clean  
`make distclean`

### How to use ### 

- Add shared libraries in your current terminal
  `LIBSloc="/home/solak/Workdir/tempdir/Workdir/fortan_project/myLib/hdf5"`
  `export LD_LIBRARY_PATH="${LIBSloc}/lib"`

### Contributing ###

-  _Make sure you comment each and every block/object/class and every damn variable_			
-  _PLEASE DO NOT USE SPACES, USE HYPHENS(-) or UNDERSCORES(_) FOR FILENAMES_

### License ###
