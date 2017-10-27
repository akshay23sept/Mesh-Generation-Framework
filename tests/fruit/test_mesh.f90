module test_mesh
   use fruit
   use class_mesh
   implicit none
   contains
 
   !> Test mesh init
   subroutine test_mesh_init_x
      implicit none
!      use class_field, only: field_init
      type(mesh_grid) :: grid
      character(len = 100) :: my_message

      !-> initialize grid
      call mesh_init(grid, 'grid', 'x', 15, 1, 1)
 
      ! Check size of the field
      my_message = 'mesh size'
      call assertEquals(15,size(grid%grid1d), message=trim(my_message))
       
   end subroutine test_mesh_init_x
   
   subroutine test_mesh_init_y
      implicit none
!      use class_field, only: field_init
      type(mesh_grid) :: grid
      character(len = 100) :: my_message

      !-> initialize grid
      call mesh_init(grid, 'grid', 'y', 15, 1, 1)
 
      ! Check size of the field
      my_message = 'mesh size'
      call assertEquals(1,size(grid%grid1d), message=trim(my_message))
       
   end subroutine test_mesh_init_y
   
   subroutine test_mesh_grid_init_uniform
     implicit none
     type(mesh_grid) :: grid
     character(len = 100) :: my_message
     integer(ik) :: n, nd, ratio_max, type_strech
     real(rk) :: x0, x1, delta, error_margin, my_array(11)

     ! array to compare
     my_array = (/0.0_rk, 0.1_rk, 0.2_rk, 0.3_rk, 0.4_rk, 0.5_rk, &
                  0.6_rk, 0.7_rk, 0.8_rk, 0.9_rk, 1.0_rk/)

     n  = 11 ! number of grid points
     nd = 1  ! number of domains
     x0 = 0.0_rk ! start coord.
     x1 = 1.0_rk ! end   coord
     ratio_max = 0   ! no local streching
     type_strech = 0 ! no global streching
     delta       = 1.0_rk !NULL

     !-> initialize grid
     call mesh_init(grid, 'grid', 'x', n, 1, 1)

     !-> create homogenous grid
     call mesh_grid_init(grid, nd, n,  x0, x1, 0, 0, 1.0_rk)

     !-> Check the grid with a error margin 
     error_margin = 0.00001_rk
     my_message = 'uniform mesh'
     call assertEquals(my_array, grid%grid1d, n, error_margin,  message=trim(my_message))

   end subroutine test_mesh_grid_init_uniform

end module test_mesh
