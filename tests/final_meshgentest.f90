program meshing

!================================================================================================================================
!> Description : This test program is a test for proper working of all the modules and their integration with each other.
! @Author
!        @Akshay
!=================================================================================================================================


!==================================================================================================================================
use precision
use newtonmod
!> Newtonmod module for local strecthing
use read_file_module
!>Read Module to take the value from user and insert it into variables  !>this read module operates in (case1) nozzle
use mesh
!>Read Module to take the value from user and insert it into variables  !>this read module operates in (case2) rectangular

!====================================================================================================================================
implicit none 
!> This implicit none statement forces the programmer to declare all the variables which is considered as a good style .






call raw_mesh()



end program meshing
!======================================================================================================================================

 !> Compile using 
!>gfortran -c module_precision.f90
!>gfortran -c module_newton.f90  
!>gfortran -c module_read_file.f90 
!>gfortran -c module_mesh.f90
!> gfortran final_meshgentest.f90 module_precision.o module_newton.o module_read_file.o module_mesh.o -o final_meshgentest.exe


!=========================================================================================================================================
