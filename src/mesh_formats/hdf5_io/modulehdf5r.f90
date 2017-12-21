module hdfwrite
IMPLICIT NONE
contains
subroutine hdf5wrt
print*,'creating hdf5 file'
call system("gfortran -c precision.f90")
call system("hdf5/bin/h5fc precision.o hdf5write.f90 -o data")
call system("./data")
end subroutine hdf5wrt
end module hdfwrite
