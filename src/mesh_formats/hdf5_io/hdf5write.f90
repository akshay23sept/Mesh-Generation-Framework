program hdf5write
use HDF5
IMPLICIT NONE

CHARACTER(LEN=11), PARAMETER :: filename = "mesh.h5" ! File name of the hdf5 file generated
CHARACTER(LEN=11), PARAMETER :: cordf = "coordinates" , velf = "velocity", pref = "pressure", nodef = "nodes"    ! Dataset name in wich the data will be saved 


INTEGER(HID_T) :: file_1       ! File identifier for the file that needs to be generated
INTEGER(HID_T) :: dset_1, dset_2, dset_3, dset_4       ! Dataset identifier for different datasets that is created
INTEGER(HID_T) :: dspace_1, dspace_2, dspace_3, dspace_4      ! Dataspace identifier for the dataspace created


INTEGER(HSIZE_T), DIMENSION(2) :: dims_1 ! Dataset dimensions for the size of array that needs to be generated
INTEGER(HSIZE_T), DIMENSION(2) :: dims_2 ! Dataset dimensions
INTEGER(HSIZE_T), DIMENSION(1) :: dims_3 ! Dataset dimensions
INTEGER(HSIZE_T), DIMENSION(1) :: dims_4 ! Dataset dimensions
INTEGER     ::   rank_1, rank_2, rank_3, rank_4  ! Dataset rank that tells the dimension of the array

INTEGER     ::   error ! Error flag to initilize and to check if any error is generated while compiling file

INTEGER :: i, n

REAL, allocatable :: cord(:,:), vel(:,:), pre(:) ! defining the arrays of the data that needs to saved
INTEGER, allocatable :: node(:)
write(*,*)'opening the data file'
open(1, file="raw_data.dat", status='old', action='read')
  write(*,*)'reading the size of the array that needs to be created'
  read(1, *) n

allocate (cord(3,n))
allocate (vel(3,n))
allocate (pre(n))
allocate (node(n))
rank_1 = 2
rank_2 = 2
rank_3 = 1
rank_4 = 1

dims_1 = (/3,n/)
dims_2 = (/3,n/)
dims_3 = n
dims_4 = n
do i = 1, n
 read(1,*) cord(1,i), cord(2,i), cord(3,i)! node(i) !, vel(1,i), vel(2,i), vel(3,i), pre(i) ! reading data form the data file and assigning the values
 vel(1,i) = 0
 vel(2,i) = 0 ! allocating 0 for the data sets which can be modified for futue use
 vel(3,i) = 0
 pre(i)  = 0
 node(i) = 0
end do
 close(1) 
write(*,*)'allocating only coordinates of the nodes and node number '
CALL h5open_f(error) ! initilizing the file

CALL h5fcreate_f(filename, H5F_ACC_TRUNC_F, file_1, error) ! creating the file with default properties

CALL h5screate_simple_f(rank_1, dims_1, dspace_1, error) ! ceating dataspace which stores the information regarding the data set

CALL h5dcreate_f(file_1, cordf, H5T_NATIVE_REAL, dspace_1, dset_1, error) ! creating data set for cordinates that is required to save the data
CALL h5screate_simple_f(rank_2, dims_2, dspace_2, error)

CALL h5dcreate_f(file_1, velf, H5T_NATIVE_REAL, dspace_2, dset_2, error) ! other data sets are created for future use 

CALL h5screate_simple_f(rank_3, dims_3, dspace_3, error)

CALL h5dcreate_f(file_1, pref, H5T_NATIVE_REAL, dspace_3, dset_3, error) ! other data sets are created for future use

CALL h5screate_simple_f(rank_4, dims_4, dspace_4, error)

CALL h5dcreate_f(file_1, nodef, H5T_NATIVE_INTEGER, dspace_4, dset_4, error) ! creating data set for node numbers that needs to be saved that is required to save the data



dims_1(1:2) = (/3, n/) ! assigning the size of the data set that needs to be written
CALL h5dwrite_f(dset_1, H5T_NATIVE_REAL, cord, dims_1, error) ! writing the coordinate data to the file

dims_2(1:2) = (/3, n/) 
CALL h5dwrite_f(dset_2, H5T_NATIVE_REAL, vel, dims_2, error) ! other data sets are created for future use

dims_3(1) = n
CALL h5dwrite_f(dset_3, H5T_NATIVE_REAL, pre, dims_3, error) ! other data sets are created for future use

dims_4(1) = n 
CALL h5dwrite_f(dset_4, H5T_NATIVE_INTEGER, node, dims_4, error) ! write node number data to the file


CALL h5dclose_f(dset_1, error)! closing the data space which limits the modification of size of the data 
CALL h5dclose_f(dset_2, error)
CALL h5dclose_f(dset_3, error)
CALL h5dclose_f(dset_4, error)

CALL h5sclose_f(dspace_1, error)!! closing the dataset which limits the writing permission 
CALL h5sclose_f(dspace_2, error)
CALL h5sclose_f(dspace_3, error)
CALL h5sclose_f(dspace_4, error)

CALL h5fclose_f(file_1, error) ! closing the generated file 

CALL h5close_f(error) ! enging the fortran interface 

end program hdf5write ! end of program
