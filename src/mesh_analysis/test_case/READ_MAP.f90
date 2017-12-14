module READ_MAP
 !\\\\\\\\\\\\\\\\\\\\\\ THIS MODULE CONTAINS A FUNCTION FOR CONFORMAL OF CELLS AND NODES \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 
 contains
!\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ CALLING THE SUBROUTINE FOR READING MESH OUTPUT DATA  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  subroutine read_data(n1,x,y) 
  implicit none
  character ( len = 80 ) output_filename
  character ( len = 80 ) title
  integer           :: i, j, myRow,myColumn,node_num,element_xtot,element_ytot
  character(len=30) :: myFileName1
  real(8),allocatable ::n1(:),xyz(:,:),x(:),y(:),z(:),u(:),uvw(:,:),v(:),w(:),p(:)
  integer,allocatable :: element_node(:,:)


  myFileName1='raw_mesh.dat'

  open(99, file=myFileName1)
  write(*,*)'open data file'
  read(99, '(x,I3,x,I2,x,I1)') node_num, element_xtot, element_ytot

  allocate(n1(node_num))
  allocate(xyz(3,node_num))
  allocate(x(node_num))
  allocate(y(node_num))
  allocate(z(node_num))
  allocate(uvw(3,node_num))
  allocate(u(node_num))
  allocate(v(node_num))
  allocate(w(node_num))
  allocate(p(node_num))


  do i=1,node_num
    read(99,*) x(i),y(i),z(i),n1(i),u(i),v(i),w(i),p(i)
  enddo
        xyz(1,:) = x(:)
        xyz(2,:) = y(:)
        xyz(3,:) = z(:)
        uvw(1,:) = u(:)
        uvw(2,:) = v(:)
        uvw(3,:) = w(:)
 end subroutine read_data
!\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  FUNCTION FOR MAPPING CELLS OF ESSENTIAL NODES  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

function map(node_num,element_xtot,element_ytot) ! takes the total nodes, total nodes in X and Total nodes in Y

   implicit none
   real(8),allocatable :: nodexy(:,:),cell(:,:),n(:),x(:),y(:),map(:,:)
   integer::i,j,k,node_num,element_xtot,element_ytot,celltot
   
 celltot=(element_xtot-1)*(element_ytot-1) !The total number of cells in the mesh

  allocate(cell(celltot,4))
  allocate(nodexy(node_num,2))
  allocate(n(node_num))
  allocate(x(node_num))
  allocate(y(node_num))
  allocate(map(celltot,4))

call read_data(n,x,y) ! Using the read Module for obtaining the OUTPUT data

!\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  INFORMATION OF X,Y IN EACH NODE  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

do k=1,node_num
nodexy(k,1)= x(k)
nodexy(k,2)= y(k)
end do

!\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  INFORMATION OF NODE IN EACH CELL  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

do i=1,element_xtot
do j=1,element_ytot

 cell(j+(i-1)*(element_ytot-1),1)= n(j+(i-1)*element_ytot)
 cell(j+(i-1)*(element_ytot-1),2)= n((j+1)+(i-1)*element_ytot)
 cell(j+(i-1)*(element_ytot-1),3)=n(i*element_ytot+(j+1))
 cell(j+(i-1)*(element_ytot-1),4)=n(i*element_ytot+j)
end do
end do

map(:,:)=cell(:,:) !output of the function - mapped cells,nodes
print*,x
print*,y
print*,n
print*,cell
end function map


end module READ_MAP
