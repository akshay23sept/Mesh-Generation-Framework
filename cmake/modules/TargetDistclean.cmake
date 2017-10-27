# add custom target distclean
# cleans and removes cmake generated files etc.
# Jan Woetzel 04/2003
#

IF (UNIX)
  ADD_CUSTOM_TARGET (distclean @echo cleaning for source distribution)
  SET(DISTCLEANED
   cmake.depends
   cmake.check_depends
   CMakeCache.txt
   cmake.check_cache
   Makefile
   CMakeFiles
   cmake_install.cmake
   CTestTestfile.cmake
   src
   *~
   ${EXECUTABLE_OUTPUT_PATH}
   ${LIBRARY_OUTPUT_PATH}
   ${CMAKE_Fortran_MODULE_DIRECTORY}
  )
  
  ADD_CUSTOM_COMMAND(
    DEPENDS clean
    COMMENT "distribution clean"
    COMMAND rm
    ARGS    -Rf CMakeTmp ${DISTCLEANED}
    TARGET  distclean
  )
ENDIF(UNIX)
