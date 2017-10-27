# -----------------------------------------------------------------------------
# Libraries (only examples)
# -----------------------------------------------------------------------------

# class utils
SET(UTILS utils)
ADD_LIBRARY(${UTILS} STATIC utils/color_print.f90 
                            utils/tictoc.f90       )

# class precision
SET(PREC prec)
ADD_LIBRARY(${PREC} STATIC precision/precision.f90 )

# class io
SET(IO io)
ADD_LIBRARY(${IO} STATIC class_io/class_io.f90) 
target_link_libraries(${IO} ${NETCDFLIB})

# class mesh
SET(MESH mesh)
ADD_LIBRARY(${MESH} STATIC class_mesh/class_mesh.f90)
target_link_libraries(${MESH} ${PREC} ${IO})


# add others for your own code


# -------------------------------------------------------------------------------------------------------------------------
# Executables
# -------------------------------------------------------------------------------------------------------------------------

# navier3d (Example only)
#SET(TESTNAV testnav)
#ADD_EXECUTABLE( ${TESTNAV} main/navier3d.f90)
#target_link_libraries(${TESTNAV} ${NAVIER3D} ${MPI})

