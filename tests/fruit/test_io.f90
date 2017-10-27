module test_io
   use fruit
   use precision
   use class_io
   implicit none
   contains
 
   !> Test io routines
   subroutine test_get_var3d_info
      implicit none
!      use class_field, only: field_init
      integer :: result
      integer(ik) :: dim_len(3)
      character(len=512) :: dim_name(3)

      character(len = 100) :: my_message

      !-> get grid information from file
      call get_var3d_info("../tests/data/grid_x.nc",'gridx',dim_name,dim_len)
 
      my_message = 'check get_var3d_info'
      call assertEquals(101,dim_len(1), message=trim(my_message))
      call assertEquals(1,  dim_len(2), message=trim(my_message))
      call assertEquals(1,  dim_len(3), message=trim(my_message))
 
!      call read_var3d('grid_x','gridx',my_var) !,mpid, varDim, inter)
       
   end subroutine test_get_var3d_info
   
   subroutine test_read_var3d
      implicit none
!      use class_field, only: field_init
      integer :: result
      integer(ik) :: dim_len(3)
      character(len=512) :: dim_name(3)
      real(rk), allocatable :: my_array(:,:,:) 

      character(len = 100) :: my_message

      !-> get grid information from file
      call get_var3d_info("../tests/data/grid_x.nc",'gridx',dim_name,dim_len)
 
    !-> initialize type mesh
    allocate(my_array(dim_len(1),dim_len(2),dim_len(3)))
    !print*, 'Shape grid', choice, nx,ny,nz, size(grid%grid3d) 

    !-> read grid3d
    call read_var3d("../tests/data/grid_x.nc", 'gridx',my_array, varDim='1Dx')
 
    my_message = 'check read_var3d'
    call assertEquals(0._rk,my_array(1,1,1), message=trim(my_message))
    call assertEquals(6._rk,my_array(dim_len(1), dim_len(2),dim_len(3)), message=trim(my_message))
 
    deallocate(my_array)
   end subroutine test_read_var3d

end module test_io
