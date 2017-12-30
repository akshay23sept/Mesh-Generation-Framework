module test_hdf5  
  use HDF5
  use fruit
  use precision
  implicit none

  contains

  subroutine check_hdf5_link() 
    implicit none
    character(len=11), parameter :: filename = "mesh.h5" ! File name of the hdf5 file generated
    integer(HID_T) :: idfile       ! File identifier for the file that needs to be generated
    integer(ik) ::   error ! Error flag to initilize and to check if any error is generated while compiling file
   
    call h5open_f(error) ! initilizing the file
   
    ! Check if the error zero
    call  assert_equals(0, error)

    call h5fcreate_f(filename, H5F_ACC_TRUNC_F, idfile, error) ! creating the file with default properties
   
    ! Check if the error zero
    call  assert_equals(0, error)
    
    call  h5fclose_f(idfile, error) ! closing the generated file 
   
    ! Check if the error zero
    call  assert_equals(0, error)
    
    call h5close_f(error) ! enging the fortran interface 
   
    ! Check if the error zero
    call  assert_equals(0, error)
  end subroutine check_hdf5_link

end module test_hdf5
