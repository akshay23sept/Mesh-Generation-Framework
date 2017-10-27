# MeshGeneration-Framework #
Mesh Generation Framework as a part of Fortran Project by IMP Turbulence 2019 Batch

**Mesh with a special streching on wall normal direction**

![alt text](http://imp-turbulence.ec-lille.fr/Webpage/Laval/Turbulence/grid_A_Re600.png)

### Compilation ###

- Go to build directory : 
    cd build 
    rm -f CMakeCache.txt

- Create Makefile with one of these command choosing compiler (gfortran, ifort, ...) 
  and build type (Debug, Release, ...).
  
  - To compile with compiler Release flags only  
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

### Contributing ###

-  _Make sure you comment each and every block/object/class and every damn variable_			
-  _PLEASE DO NOT USE SPACES, USE HYPHENS(-) or UNDERSCORES(_) FOR FILENAMES_

### License ###
