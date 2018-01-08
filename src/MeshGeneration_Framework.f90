!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> PROGRAM: Mesh Generation Framework (Main)
!
!> @author
!> Team Mesh Generation Framework 
!
!> DESCRIPTION: 
!> Mesh Generation Framework as a part of Fortran Project by IMP Turbulence 2019 Batch
!
!> Simple Compile: "gfortran *.o MeshGeneration_Framework.f90 -o MeshGeneration_Framework.exe"
!---------------------------------------------------------------------

program MeshGenerationFramework

implicit none
!======================================================================================================================================
!> use <All Mesh Create Modules>
!>Modules by Akshay, Alvaro and Drashti 

use precision
use newtonmod
!> Newtonmod module for local strecthing
use read_file_module
!>Read Module to take the value from user and insert it into variables  !>this read module operates in (case1) nozzle
use read_file1_module
!>Read Module to take the value from user and insert it into variables  !>this read module operates in (case2) rectangular
use mesh
!> A module that will integrate the all the modules and provide the desired output.
use module_rectmesh
!=========================================================================================================================================

!=========================================================================================================================================
!> use <All Mesh Formats Modules>
use hdf5write !> HDF5 Module
 !>VTK Module
 !>DAT/CSV/BlahBlah Module(s) 

!==========================================================================================================================================

!==========================================================================================================================================
!> use <All Mesh Analysis Modules>
<<<<<<< HEAD
  use skewness_1cell
  use ratio
  use smoothness_factor
=======
!> use module_as_ratio
>>>>>>> d6aa5bc2d96865f672477be66d471e631d8426d2
!>Modules by Damien, Prosun, Ahmed 
!==========================================================================================================================================
print*, 'Welcome to MeshGeneration Framework'
print*, 'For usage please refer https://github.com/Turbulence-Master/MeshGeneration-Framework/'
print*, 'Complete documentation can be found at https://turbulence-master.github.io/'
print*, 'MeshGeneration-Framework is licensed under the GNU General Public License v3.0'
print*, '############################################################################################'


!> call <Mesh Create Functions>

print*, 'Choose the type of mesh : 1 for Nozzle, 2 for Rectangle and any other input will exit ' 
read*, choice
if (choice ==1) then
call raw_mesh()
!> raw_mesh subroutine uses read_file subroutine and newton subroutine 
else (choice ==2) then
call rectmesh()
!> rectmesh subroutine uses read_file1 subroutine 
else
print*, 'Invalid input , so you will exit from the program'
=======
print*, 'Choose the type of mesh' !elaborate
subroutine raw_mesh ()
!write the switch case here
!include Alvaro's subroutine(nozzle) as
!include Drashti's subroutine(rectangular) as case 2

!> Call all the proper subroutine(s) 


!> call <Mesh Formats Functions> 
print*, 'Choose the mesh format:'
print*, 'Enter 1 for HDF5'
print*, 'Enter 2 for VTK'
print*, 'Enter 3 for CSV/DAT/BlahBlah'
read*, caseVal
if (caseVal==1) then
        print*, 'Generating Mesh in HDF5 format'
        call hdfwrite() !> Calling the subroutine to generate mesh in HDF5 format
elseif (caseVal==2) then
        print*, 'Generating Mesh in VTK format'
        !> Call all the proper subroutine(s)  by Bipin and Diana
elseif (caseVal==3) then
       print*, 'Generating Mesh in DAT/CSV/BlahBlah formats'
        !> Call all the proper subroutine(s)   by Bipin and Diana
else
        print*, 'Unknown value. Default det to generating mesh in HDF5 format'
        print*, 'Generating Mesh in HDF5 format'
        call hdfwrite() !> Calling the subroutine to generate mesh in HDF5 format
stop
end if
!> call subroutine test1
!> call <Mesh Analysis Functions>

  print*, 'Do you want to analyze the mesh? [y/n]
  read*, answer

  if (answer == y) then 
    call File_Skewness
    call test1(maxi_as)
    call smoo
    print*, 'done: find the sum up in results_skewness.dat result_ar.dat'
  elseif (answer == n) then 
    print*, 'done'
  else 
    print*, 'Unknown value... done'
  end if

!> Call all the proper subroutine(s) by Damien, Prosun, Ahmed

end program
