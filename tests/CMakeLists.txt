
# -----------------------------------------------------------------------------
# Libraries
# -----------------------------------------------------------------------------

# class fruit
SET(FRUIT fruit)
ADD_LIBRARY(${FRUIT} STATIC fruit/fruit_util.f90
                            fruit/fruit.f90)

#------------------------------------------------------------------------------
# UNIT TESTS for class_field 
#------------------------------------------------------------------------------
SET(IO io)

SET(TIO testio)
ADD_LIBRARY(${TIO} STATIC test_io.f90)
target_link_libraries(${TIO} ${FRUIT} ${IO})

#------------------------------------------------------------------------------
# UNIT TESTS for class_mesh
#------------------------------------------------------------------------------
SET(MESH mesh)

SET(TMESH testmesh)
ADD_LIBRARY(${TMESH} STATIC test_mesh.f90)
target_link_libraries(${TMESH} ${FRUIT} ${MESH})

#------------------------------------------------------------------------------
# EXE UNIT TESTS fruit driver 
#------------------------------------------------------------------------------

SET(TUDRIVEREXE driverunittest)
ADD_EXECUTABLE(${TUDRIVEREXE} driver_unit_test.f90)
target_link_libraries(${TUDRIVEREXE} ${TMESH} ${TDER} ${TCOMPACT} ${TFIELD} ${TIO} ${TNAVIER3D} ${EXACT})

ADD_TEST(NAME "UnitTests" 
    WORKING_DIRECTORY ${EXECUTABLE_OUTPUT_PATH}
    COMMAND ${TUDRIVEREXE})

