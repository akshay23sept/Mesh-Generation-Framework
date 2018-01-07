program vtk_read

!>This program creates files in VTK format in ASCII

use vtk_write
use precision
  implicit none

  call timestamp ( ) !>Calling the time stamp subroutine
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'VTK_IO_PRB'
  write ( *, '(a)' ) '  FORTRAN90 version'
  write ( *, '(a)' ) '  Test the VTK_IO library.'

  call test01 ( ) !>Calling the subroutine that writes pressure and velocity for 3D fluid flow calculation
!
! > Terminate.
!
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'VTK_IO_PRB'
  write ( *, '(a)' ) '  Normal end of execution.'
  write ( *, '(a)' ) ' '
  call timestamp ( ) !>timestamp to mention the time of execution

  stop

contains
subroutine test01 ( )

!>To tests the VTK_PUVW_WRITE subroutine that writes pressure and velocity for a 3D fluid flow calculation.

  implicit none

  character ( len = 80 ) output_filename !>Output, correspond to a title for the data.
  character ( len = 80 ) title

  real    (rk)          :: myLine
  integer  (ik)         :: i, j, myRow,myColumn,node_num,element_num,element_order,output_unit
  character(len=30) :: myFileName1
  real(rk),allocatable ::n(:),xyz(:,:),x(:),y(:),z(:),u(:),uvw(:,:),v(:),w(:),p(:)
  integer(ik),allocatable :: element_node(:,:)

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'TEST01'
  write ( *, '(a)' ) '  VTK_PUVW_WRITE writes 3d fluid data, pressure and '
  write ( *, '(a)' ) '  velocity, to a VTK file.'

  myFileName1='raw_mesh.dat' !>Create the points mesh file

  open(98, file=myFileName1)
  write(*,*)'open data file'
  read(98, *) node_num,element_num,element_order

  allocate(n(node_num))     !>Allocate the correspondent number at: Total number of nodes for the mesh
  allocate(xyz(3,node_num)) !> Allocate the correspondent velocity values
  allocate(x(node_num))     !> Allocate the correspondent values in X direction
  allocate(y(node_num))     !> Allocate the correspondent values in y direction
  allocate(z(node_num))     !> Allocate the correspondent values in z direction
  allocate(uvw(3,node_num)) 
  allocate(u(node_num)) !> Allocate the correspondent values in u direction
  allocate(v(node_num)) !> Allocate the correspondent values in v direction
  allocate(w(node_num)) !> Allocate the correspondent values in w direction
  allocate(p(node_num)) !> Allocate the correspondent values of Pression
  allocate(element_node(element_num,element_order)) !>Organize the information from the element number and its order

  do i=1,node_num
    read(98,*) x(i),y(i),z(i),n(i),u(i),v(i),w(i),p(i)
  enddo

print*,element_num
print*,element_order

  element_node=reshape(n(:),(/element_num,element_order/))

  close(98)



  output_filename = 'vtkoutput.vtk'
  title ='vtkoutput'

        xyz(1,:) = x(:)
        xyz(2,:) = y(:)
        xyz(3,:) = z(:)
!> Allocating x,y,z to xyz

        uvw(1,:) = u(:)
        uvw(2,:) = v(:)
        uvw(3,:) = w(:)
!> Allocating u,v,w to uvw


  call get_unit ( output_unit ) !>Call subroutine to avoid 5, 6 and 9 as the unit number
!>    A "free" FORTRAN unit number is an integer between 1 and 99 which
!>    is not currently associated with an I/O device.  A free FORTRAN unit
!>    number is needed in order to open a file with the OPEN command.
!>    If IUNIT = 0, then no free FORTRAN unit could be found, although
!>    all 99 units were checked (except for units 5, 6 and 9, which
!>    are commonly reserved for console I/O).
!>    Otherwise, IUNIT is an integer between 1 and 99, representing a
!>    free FORTRAN unit.  Note that GET_UNIT assumes that units 5, 6 and 9
!>    are special, and will never return those values.
!>    //output_unit is independent number for file creation


  call vtk_data_write ( output_unit, title, node_num, element_num, &
    element_order, xyz, element_node, p, uvw)  !>VTK_data_write writes pressure and velocity data to a VTK file.

  close (  unit = output_unit )

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) '  VTK_PUVW_WRITE created the file.'

  return
end
end
