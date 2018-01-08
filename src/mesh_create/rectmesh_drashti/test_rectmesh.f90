
!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> TEST PROGRAM: test_rectmesh
!
!> @author
!> Drashti
!
! DESCRIPTION: 
!> PROGRAM TO TEST MODULE_RECTMESH
!

program test_rectmesh
!> This is a test program to see how the Module for creating Meshed grid of the Rectangle geometry is working
!use read_file_module
!> we use 
use module_rectmesh
!> we use the Rectangle meshing module 
implicit none
integer:: choice
!> the data type integer is assigned for choice of if loop
print*, 'Please make a choice : select 1 for Rectangle mesh '
!> asking for choice of Geometry
read*,choice
!> Reading the choice input by the user
if  (choice == 1) then
!> The test is for the choice ==1 i.e the rectmesh subroutine
call rectmesh()
!> Calling the rect_mesh subroutinr at this point
else
!> if choice != 1 , it will simply exit and you will not be able to see thw working of rectmesh 
print*,' Since you have not selected 1 , you can exit'
!> print to show that 1 was not chosen
end if
!> end if loop
end program
!> end of program
