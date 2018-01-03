!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> MODULE: hdfwrite
!
!> @author
!> Mohan and Aakash
!
! DESCRIPTION: 
!> This module is used as as the the module for running requires a different command to compile the program
!
!---------------------------------------------------------------------
!
module hdfwrite
IMPLICIT NONE
contains
subroutine hdf5wrt
print*,'creating hdf5 file'
call system("gfortran -c precision.f90")! to compile the precision.f90 to compile the module of data type precision
call system("hdf5/bin/h5fc precision.o hdf5write.f90 -o data") ! to compile the main program
call system("./data")! running the output file to generate hdf5 file
end subroutine hdf5wrt
end module hdfwrite
