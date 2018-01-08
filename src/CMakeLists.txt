# -----------------------------------------------------------------------------
# Libraries (only examples)
# -----------------------------------------------------------------------------

# class utils
#SET(UTILS utils)
#ADD_LIBRARY(${UTILS} STATIC utils/color_print.f90 
#                            utils/tictoc.f90       )

# class precision
SET(PREC prec)
ADD_LIBRARY(${PREC} STATIC precision.f90 )


# class hdffile
SET(HDFFILE hdffile)
<<<<<<< HEAD
ADD_LIBRARY(${HDFFILE} STATIC mesh_formats/hdf5/module_hdf5write.f90)
=======
ADD_LIBRARY(${HDFFILE} STATIC mesh_formats/hdf5/module_hdfwrite.f90)
>>>>>>> 1103e47acf8ea62db0de960aac0d865a91e255d6
target_link_libraries(${HDFFILE} ${PREC} ${HDF5lib})


# class io
#SET(IO io)
#ADD_LIBRARY(${IO} STATIC class_io/class_io.f90) 
#target_link_libraries(${IO} ${NETCDFLIB})

# class mesh
#SET(MESH mesh)
#ADD_LIBRARY(${MESH} STATIC class_mesh/class_mesh.f90)
#target_link_libraries(${MESH} ${PREC} ${IO})


# add others for your own code


# -------------------------------------------------------------------------------------------------------------------------
# Executables
# -------------------------------------------------------------------------------------------------------------------------

SET(HDFEXE hdfexe)
ADD_EXECUTABLE(${HDFEXE} mesh_formats/hdf5/hdftest.f90)
target_link_libraries(${HDFEXE} ${HDFFILE})

file(GLOB mod_file mesh_analysis/Module/*.f90)  # In order to create a group containing all the .f90 files in Module-folder
SET(HEADER Module)                               
ADD_LIBRARY(${HEADER} STATIC ${mod_file})       # I called ${mod} instead of the list of every module in module-folder
target_link_libraries(${HEADER} ${PREC})        # IMPORTANT : ADD OTHER PART FOR READ_MAP

# navier3d (Example only)
#SET(TESTNAV testnav)
#ADD_EXECUTABLE( ${TESTNAV} main/navier3d.f90)
#target_link_libraries(${TESTNAV} ${NAVIER3D} ${MPI})

