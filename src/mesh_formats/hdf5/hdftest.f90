!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> PROGRAM: hdftest
!
!> @author
!> Mohan and Aakash
!
! DESCRIPTION: 
!>This program is used to test the hdf5write module
!
!---------------------------------------------------------------------
!
program hdftest
!> test program to check the module of hdf5 
use hdf5write 
!> using the module hdf5write which is created
IMPLICIT NONE

call hdfwrite()
!> calling the subroutine created in the module to generate the hdf5 file
end program hdftest
