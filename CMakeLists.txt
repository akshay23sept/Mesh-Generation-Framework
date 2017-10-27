# -------------------------------------------------------------------------------------------------------------------------
# General options
# -------------------------------------------------------------------------------------------------------------------------

CMAKE_MINIMUM_REQUIRED(VERSION 2.8.5)
PROJECT(DDNS C Fortran)
enable_language (C Fortran)

# Set the DDNS version
SET(VERSION 1.2.3)

# Add our local modlues to the module path
SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/Modules/")

# to see command lines
#SET(CMAKE_VERBOSE_MAKEFILE ON)

# to add Color on CMake Process
SET(CMAKE_COLOR_MAKEFILE ON)


# Define some directories
SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
SET(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)
SET(CMAKE_Fortran_MODULE_DIRECTORY ${PROJECT_SOURCE_DIR}/includes)
# Type of build
message( STATUS "Project Source: " ${PROJECT_SOURCE_DIR})
message( STATUS "Build type: " ${CMAKE_BUILD_TYPE})

add_definitions(-DPLATFROM_NAME=${PLATFROM_NAME})

message( STATUS "Build for platfrom: " ${PLATFROM_NAME})
# -------------------------------------------------------------------------------------------------------------------------
# Compiler options
# -------------------------------------------------------------------------------------------------------------------------
message( STATUS "Fortran compiler: " ${CMAKE_Fortran_COMPILER} )
message( STATUS "Fortran compiler: " ${CMAKE_C_COMPILER} )

# Enables/disables compiling with preproccessor option DEBUG (add more if needed)
OPTION(DEFINE_DEBUG "Preproccessor for Debugging mode" OFF) # Enabled by default
IF(DEFINE_DEBUG)
  ADD_DEFINITIONS(-DDEBUG)
ENDIF(DEFINE_DEBUG)

#------------------------------------------------------------------------------
# MACHINE LMLM6-75
#------------------------------------------------------------------------------
if(PLATFROM_NAME MATCHES "lmlm6-75")

  message( STATUS "Build for platfrom: " ${PLATFROM_NAME})
  
  # Location for NETCDF libraries
  set(LIBSloc "/home/solak/programs/LIBS")
  set(NETCDFloc  "${LIBSloc}/netcdf-c-4.4.1.1")
  set(NETCDFFloc "${LIBSloc}/netcdf-fortran-4.4.4")
  
  #/usr/lib/lapack/liblapack.a

  #set(LAPACKLIB "-L/usr/lib/liblapack.a")
  set(LAPACKLIB "-Wl,--start-group /usr/lib/libblas/libblas.a /usr/lib/lapack/liblapack.a  -Wl,--end-group")

  # Location of PETSc libraries (example)
  #set(PETSCloc "${LIBSloc}/petsc-3.7.5")
  #set(PETSCopt "-lpetsc -lHYPRE -ldmumps -lsuperlu_dist -lmumps_common -lparmetis -lmetis -lpord -lscalapack -lfftw3 -lfftw3_mpi")

  # gfortran compiler (LINUX)
  set(CMAKE_Fortran_FLAGS "-std=f2008 -cpp")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -ffast-math -funroll-loops")
  #  set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -Warray-bounds -fbounds-check -std=legacy -Wall -Wno-unused -Warray-temporaries -pedantic-errors")
  set(CMAKE_Fortran_FLAGS_DEBUG "-Og -g -Wmaybe-uninitialized -Wunused-dummy-argument -Wconversion -fbacktrace -ffree-line-length-0 -fcheck=all")  #-fimplicit-none -ffpe-trap=zero,overflow,underflow") # -finit-real=nan")
  set(DOUBLE "-fdefault-real-8")
  # set any extra envionment variables here
  set(LIBSloc "/home/solak/programs/LIBS")
  set(my_PATH "${LIBSloc}/hdf5-1.8.13/lib:${LIBSloc}/petsc-3.7.5/lib:${LIBSloc}/netcdf-c-4.4.1.1/lib:${LIBSloc}/netcdf-fortran-4.4.4/lib:$LD_LIBRARY_PATH")
  message( STATUS "PATH PATH:" ${my_PATH})

  #set (LIBSloc "/home/solak/programs/LIBS")
  # set (myRlink "${LIBSloc}/hdf5-1.8.13/lib:${LIBSloc}/petsc-3.7.5/lib:${LIBSloc}/netcdf-c-4.4.1.1/lib:${LIBSloc}/netcdf-fortran-4.4.4/lib:$LD_LIBRARY_PATH")
  

  #set(CMAKE_INSTALL_RPATH ${myRlink})
  set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
  
#------------------------------------------------------------------------------
# MACHINE E505
#------------------------------------------------------------------------------
elseif(PLATFROM_NAME MATCHES "E505")

# Put your config. here

endif()



set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ")

# Set libraries
set(NETCDFopt  "-lnetcdf")
set(NETCDFFopt "-lnetcdff")
set(NETCDFLIB "-L${NETCDFloc}/lib ${NETCDFopt} -L${NETCDFFloc}/lib ${NETCDFFopt}")
set(PETSCLIB  "-L${PETSCloc}/lib ${PETSCopt}")
##################################################################

set(X11LIB "-lX11")
include_directories(${PETSCloc}/include ${NETCDFFloc}/include)

if (${CMAKE_BUILD_TYPE} MATCHES "Release")
message( STATUS "Fortran compiler flags:" ${CMAKE_Fortran_FLAGS_RELEASE})
elseif (${CMAKE_BUILD_TYPE} MATCHES "Debug")
message( STATUS "Fortran compiler flags:" ${CMAKE_Fortran_FLAGS_DEBUG})
endif()

message( STATUS "Netcdf library flags:" ${NETCDFLIB})
message( STATUS "Petsc library flags:" ${PETSCLIB})

# ------------------------------------------------------------------------------
# Custom targets
# ------------------------------------------------------------------------------
INCLUDE( cmake/modules/TargetDistclean.cmake OPTIONAL)

## Add a distclean target to the Makefile
#ADD_CUSTOM_TARGET(distclean 
#    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_MODULE_PATH}/distclean.cmake
#)

enable_testing()

add_subdirectory(src)
add_subdirectory(tests)
  
#SET (CTEST_ENVIRONMENT
#  "DISPLAY=:50"
#  "LD_LIBRARY_PATH=${my_PATH}"
#  )
