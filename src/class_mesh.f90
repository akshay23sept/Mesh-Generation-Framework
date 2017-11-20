module class_mesh
  use precision
  implicit none
  
  type mesh_grid
     !-> dimensions grid1d
     integer(ik) :: n
     !-> dimensions grid3d
     integer(ik) :: nx,ny,nz
     !-> dimensions names
     character(len=512) :: nxn="resolution_x",nyn="resolution_y",nzn="resolution_z"
     !-> grid direction
     character(len=1) :: choice
     !-> mean spatial step
     real(rk) :: pas
     !-> 1d grid array
     real(rk),allocatable :: grid1d(:)
     real(rk),allocatable :: dgrid1d(:)        !dx

     !-> NOTE: This class written with 3D grid but currently code only needs 1D
     !grids if there is no mapping, and only 2D y-coord is sufficient for
     !mapping. Please realise that grid3d has size (n,1,1) 
     !-> 3d grid array
     real(rk),allocatable :: grid3d(:,:,:)
     real(rk),allocatable :: dgrid3d(:,:,:)    !dx
     !-> grid names
     character(len=512) :: gridn='noname'
  end type mesh_grid

contains

! =======================================================================
! =======================================================================
! mesh : initialization and destruction methods
! =======================================================================
! =======================================================================

  subroutine grid1d_allocate(n,grid)
! -----------------------------------------------------------------------
! mesh : allocate or reallocate 1d grid in type mesh
! -----------------------------------------------------------------------
! Matthieu Marquillie
! 06/2011
!
    implicit none
    integer,intent(in) :: n
    real(rk),allocatable :: grid(:)

    if (.not.allocated(grid)) then
       allocate(grid(n))
    elseif(allocated(grid)) then
       deallocate(grid) ; allocate(grid(n))
    endif

  end subroutine grid1d_allocate

  subroutine grid3d_allocate(n1,n2,n3,grid)
! -----------------------------------------------------------------------
! mesh : allocate or reallocate 3d grid in type mesh
! -----------------------------------------------------------------------
! Matthieu Marquillie
! 06/2011
!
    implicit none
    integer,intent(in) :: n1,n2,n3
    real(rk),allocatable :: grid(:,:,:)

    if (.not.allocated(grid)) then
       allocate(grid(n1,n2,n3))
!       allocate(dxgrid(n1,n2,n3))
    elseif(allocated(grid)) then
       deallocate(grid)
       allocate(grid(n1,n2,n3))
!       deallocate(dxgrid)
!       allocate(dxgrid(n1,n2,n3))
    endif

  end subroutine grid3d_allocate

  subroutine mesh_init(grid,gn,choice,nx,ny,nz,n1n,n2n,n3n)
! -----------------------------------------------------------------------
! mesh : initialize type mesh
! -----------------------------------------------------------------------
! Matthieu Marquillie
! 06/2011
!
    implicit none
    integer(ik),intent(in) :: nx,ny,nz
    type(mesh_grid),intent(inout) :: grid
    character(len=*),intent(in) :: choice
    character(len=*),optional,intent(in) :: n1n,n2n,n3n
    character(len=*),intent(in) :: gn
    integer(ik) :: i,j,k
   
    grid%choice = choice 

    !-> dimensions length
    if (choice=="x") grid%n=nx
    if (choice=="y") grid%n=ny
    if (choice=="z") grid%n=nz
    grid%nx=nx ; grid%ny=ny ; grid%nz=nz 

    !-> dimensions name
    if (present(n1n)) grid%nxn=n1n
    if (present(n2n)) grid%nyn=n2n
    if (present(n3n)) grid%nzn=n3n

    !-> grid name
     grid%gridn=gn

    !-> allocate grid1d
    call grid1d_allocate(grid%n,grid%grid1d)
    call grid1d_allocate(grid%n,grid%dgrid1d)

    !-> allocate grid3d
    call grid3d_allocate(grid%nx,grid%ny,grid%nz,grid%grid3d)
    call grid3d_allocate(grid%nx,grid%ny,grid%nz,grid%dgrid3d)
 
  end subroutine mesh_init
  
  subroutine mesh_destroy(grid)
! -----------------------------------------------------------------------
! mesh : destroy type mesh
! -----------------------------------------------------------------------
! Ilkay Solak
! 06/2017
    implicit none
    type(mesh_grid),intent(inout) :: grid
    
    grid%choice = 'N/A'

    !-> dimensions length
    grid%nx=-1 ; grid%ny=-1 ; grid%nz=-1

    !-> grid name
    grid%gridn= 'N/A'

    if (allocated(grid%grid1d)) then
       deallocate(grid%grid1d)
    else
       ERROR STOP "ERROR : Type mesh not allocated -> cannot destroy 1"
    endif
    
    if (allocated(grid%grid3d)) then
       deallocate(grid%grid3d)
    else
       ERROR STOP "ERROR : Type mesh not allocated -> cannot destroy 2"
    endif
 
  end subroutine mesh_destroy
  
!  call mesh_grid_init(grid, nb_dom, a, b, alpha, deltai, BL)
! Example
! subroutine mesh_grid_init(grid, nb_dom, n, a, b, ratio_max, type_strech, delta)
  subroutine mesh_grid_init()
    implicit none
    type(mesh_grid),intent(inout) :: grid

    
    
    ! EMPTY for you to fill
    ! EMPTY for you to fill
    ! EMPTY for you to fill
    

  end subroutine mesh_grid_init



end module class_mesh
