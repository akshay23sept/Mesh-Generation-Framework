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

!> use <All Mesh Create Modules>


!> use <All Mesh Formats Modules>
use hdf5write !> HDF5 Module
 !>VTK Module
 !>DAT/CSV/BlahBlah Module(s) 


!> use <All Mesh Analysis Modules>


print*, 'Welcome to MeshGeneration Framework'
print*, 'For usage please refer https://github.com/Turbulence-Master/MeshGeneration-Framework/'
print*, 'Complete documentation can be found at https://turbulence-master.github.io/'
print*, 'MeshGeneration-Framework is licensed under the GNU General Public License v3.0'
print*, '############################################################################################'


!> call <Mesh Create Functions>
print*, 'Choose the type of mesh' !elaborate
!write the switch case here
!include Alvaro's subroutine(nozzle) as
!include your subroutine(rectangular) as case 2

!> Call all the proper subroutine(s) 



!> call <Mesh Formats Functions>

print*, 'Choose the mesh format'
print*, 'Enter 1 for HDF5'
print*, 'Enter 2 for VTK'
print*, 'Enter 3 for CSV/DAT/BlahBlah'
read*, caseVal
if (caseVal==1) then
        print*, 'Generating Mesh in HDF5 format'
        call hdfwrite() !> Calling the subroutine to generate mesh in HDF5 format
elseif (caseVal==2) then
        print*, 'Generating Mesh in VTK format'
        !> Call all the proper subroutine(s) 
elseif (caseVal==3) then
       print*, 'Generating Mesh in DAT/CSV/BlahBlah formats'
        !> Call all the proper subroutine(s)  
else
        print*, 'Unknown value. Default det to generating mesh in HDF5 format'
        print*, 'Generating Mesh in HDF5 format'
        call hdfwrite() !> Calling the subroutine to generate mesh in HDF5 format
stop
end if

!> call <Mesh Analysis Functions>
!> Call all the proper subroutine(s) 


end program
