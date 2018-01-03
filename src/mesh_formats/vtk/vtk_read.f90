program vtk_read
use vtk_write
use precision
  implicit none

!>This program creates files in VTK format in ASCII

  call timestamp ( ) !>Calling the time stamp subroutine
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'VTK_IO_PRB'
  write ( *, '(a)' ) '  FORTRAN90 version'
  write ( *, '(a)' ) '  Test the VTK_IO library.'

  call test01 ( )    !>Calling the subroutine that writes pressure and velocity for 3D fluid dlow calculation
!
!  Terminate.
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
  real  (rk)            :: myLine
  integer (ik)           :: i, j, myRow,myColumn,node_num,element_num,element_order,output_unit
  character(len=30) :: myFileName1
  real (rk),allocatable ::n(:),xyz(:,:),x(:),y(:),z(:),u(:),uvw(:,:),v(:),w(:),p(:)
  integer (ik),allocatable :: element_node(:,:)

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'TEST01'
  write ( *, '(a)' ) '  VTK_PUVW_WRITE writes 3d fluid data, pressure and '
  write ( *, '(a)' ) '  velocity, to a VTK file.'

  myFileName1='raw_mesh.dat' !>Create the points mesh file

  open(99, file=myFileName1)
  write(*,*)'open data file'
  read(99, *) node_num,element_num,element_order

  allocate(n(node_num)) !>Total number of nodes for the mesh
  allocate(xyz(3,node_num)) !>Velocity values
  allocate(x(node_num)) !>Values in X direction
  allocate(y(node_num)) !>Values in y direction
  allocate(z(node_num))!>Values in z direction
  allocate(uvw(3,node_num)) 
  allocate(u(node_num)) !>Velocity component in u
  allocate(v(node_num)) !>Velocity component in v
  allocate(w(node_num)) !>Velocity component in w
  allocate(p(node_num)) !>Pression component
  allocate(element_node(element_num,element_order))

  do i=1,node_num
    read(99,*) x(i),y(i),z(i),n(i),u(i),v(i),w(i),p(i)
  enddo

print*,element_num
print*,element_order

  element_node=reshape(n(:),(/element_num,element_order/)) !>Organize the information from the element number and its order

  close(99)


  output_filename = 'puvw_data.vtk'
  title = 'Sample data for VTK_PUVW_WRITE.'


        xyz(1,:) = x(:)
        xyz(2,:) = y(:)
        xyz(3,:) = z(:)
        uvw(1,:) = u(:)
        uvw(2,:) = v(:)
        uvw(3,:) = w(:)


  call get_unit ( output_unit )!>Call subroutine to avoid 5, 6 and 9 as the unit number//output_unit is independent number for file creation

  open ( unit = output_unit, file = output_filename, status = 'replace' )

  call vtk_puvw_write ( output_unit, title, node_num, element_num, &
    element_order, xyz, element_node, p, uvw) 

  close (  unit = output_unit )

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) '  VTK_PUVW_WRITE created the file.'

  return
end
end


