PROJECT(mesh_generation) 
enable_language (Fortran) 
 
# Check version of cmake 
cmake_minimum_required(VERSION 2.8)

SET(CMAKE_VERBOSE_MAKEFILE OFF) 
SET(CMAKE_COLOR_MAKEFILE ON) 

 
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin) 
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib) 
SET(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_SOURCE_DIR}/includes) 
 
# Type of build  
message( STATUS "Build type: " ${CMAKE_BUILD_TYPE}) 

# Compiler options
message( STATUS "Fortran compiler: " ${CMAKE_Fortran_COMPILER} )
#Compiler gfortran Flags
#set(CMAKE_Fortran_FLAGS "-fbounds-check -llapack ")
set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -march=native -ffast-math -funroll-loops -std=legacy -fopenmp")
set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -Warray-bounds  -std=legacy -Wall -Wno-unused ")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ")
#set(DOUBLE "-r8")

#to change
#set(LAPACKLIB "/usr/lib/lapack/liblapack.so.3.6.0")

if (${CMAKE_BUILD_TYPE} MATCHES "Release")
  message( STATUS "Fortran compiler flags:" ${CMAKE_Fortran_FLAGS_RELEASE})
elseif (${CMAKE_BUILD_TYPE} MATCHES "Debug")
  message( STATUS "Fortran compiler flags:" ${CMAKE_Fortran_FLAGS_DEBUG})
endif()


# Libraries

#SET (TOOLS tools)
#ADD_LIBRARY(${TOOLS} STATIC src/tools.f90)

SET(PRECISION precision)
ADD_LIBRARY(${PRECISION} STATIC src/precision.f90)

SET(HDF5WRITE hdf5write)
ADD_LIBRARY(${HDF5WRITE} STATIC src/mesh_formats/hdf5.io/modulehdf5r.f90)
target_link_libraries(${HDF5WRITE} ${PRECISION})



# Executables

# main program
#SET(MAIN main)
#ADD_EXECUTABLE( ${MAIN} src/main.f90)
#target_link_libraries(${MAIN} ${TOOLS})

SET(HDF5WRITETEST hdf5writetest)
ADD_EXECUTABLE( ${HDF5WRITETEST} src/mesh_formats/hdf5.io/hdf5_test.f90)
target_link_libraries(${HDF5WRITETEST} ${HDF5WRITE} ${PRECISION})


