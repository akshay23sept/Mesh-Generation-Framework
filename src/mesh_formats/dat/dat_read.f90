!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> MODULE: Name of Module/Program
!
!> @author
!> ADD AUTHOR NAME
!
! DESCRIPTION: 
!> Description of Module/Program
!
!---------------------------------------------------------------------
!




program dat_read
use dat_write
use precision
  implicit none

  call timestamp ( )
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'dat_IO_PRB'
  write ( *, '(a)' ) '  FORTRAN90 version'
  write ( *, '(a)' ) '  Test the VTK_IO library.'
	
  call test01 ( )
!
!  Terminate.
!
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'dat_IO_PRB'
  write ( *, '(a)' ) '  Normal end of execution.'
  write ( *, '(a)' ) ' '
  call timestamp ( ) !timestamp to mention the time of execution

  stop

contains
subroutine test01 ( )

  implicit none

  character ( len = 80 ) output_filename
  character ( len = 80 ) title

  real (rk)             :: myLine
  integer  (ik)         :: i, j, myRow,myColumn,node_num,element_num,element_order,output_unit
  character(len=30) :: myFileName1
  real(rk),allocatable ::n(:),xyz(:,:),x(:),y(:),z(:),u(:),uvw(:,:),v(:),w(:),p(:)
  integer(ik),allocatable :: element_node(:,:)

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'TEST01'
  write ( *, '(a)' ) '  .dat_WRITE writes 3d fluid data, pressure and '
  write ( *, '(a)' ) '  velocity, to a .dat file.'

  myFileName1='raw_mesh.dat'

  open(99, file=myFileName1)
  write(*,*)'open data file'
  read(99, *) node_num,element_num,element_order

  allocate(n(node_num))
  allocate(xyz(3,node_num))
  allocate(x(node_num))
  allocate(y(node_num))
  allocate(z(node_num))
  allocate(uvw(3,node_num))
  allocate(u(node_num))
  allocate(v(node_num))
  allocate(w(node_num))
  allocate(p(node_num))
  allocate(element_node(element_num,element_order))

  do i=1,node_num
    read(99,*) x(i),y(i),z(i),n(i),u(i),v(i),w(i),p(i)
  enddo

print*,element_num
print*,element_order

  element_node=reshape(n(:),(/element_num,element_order/))

  close(99)



  output_filename = 'puvw_data.vtk'
  title = 'data output for .dat_WRITE'


        xyz(1,:) = x(:)
        xyz(2,:) = y(:)
        xyz(3,:) = z(:)
        uvw(1,:) = u(:)
        uvw(2,:) = v(:)
        uvw(3,:) = w(:)


  call get_unit ( output_unit )!to avoid 5,6,and9 as the unit number //output_unit is independent number for file creation

  open ( unit = output_unit, file = output_filename, status = 'replace' )

  call dat_data_write ( output_unit, title, node_num, element_num, &
    element_order, xyz, element_node, p, uvw)! 

  close (  unit = output_unit )

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) '  .dat_WRITE created the file.'

  return
end
end
