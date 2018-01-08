#  This is the information about CMakeLists.txt which I can understand by going through some webpages but unfortunately I could not implement them properly because I was getting errors.
 
#As a beginner , I tried to learn the concept of CMakelist.txt also I tried to compile all the modules but there are some problem with the .dat files .
#CMakefiles can be compiled by following these steps:

  cd Build/
  cmake ..
  make
  ./main


 cmake_minimum_required(VERSION 3.5) 
# Usefull only for the first CMakeLists.txt

# Declaration of the project 
 project(MyProject) 


# Change the name on purpose 
enable_language(Fortran)

SET(CMAKE_BUILD_TYPE Release)
# add_subdirectory(src) # For the first CMakeLists.txt

file(GLOB mod_file Module/*.f90)  
# In order to create a group containing all the .f90 files in Module-folder

SET(HEADER Module)
ADD_LIBRARY(${HEADER} STATIC ${mod_file})  
# I called ${mod} instead of the list of every module in module-folder

SET(MAIN Main) 
 # From main folder
ADD_EXECUTABLE(${MAIN} Main/main.f90)
target_link_libraries(${MAIN} ${HEADER})  
# In order to use Module inside main programs

install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/${MAIN}
  DESTINATION bin
  RENAME ${CMAKE_PROJECT_NAME}-main)
