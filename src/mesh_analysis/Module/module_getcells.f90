
!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> MODULE: module_getcells
!
!> @author
!> Drashti
!
! DESCRIPTION: 
!> MODULE ORGANIZES THE MESHED GRID INTO CELLS WITH INFORMATION OF NODES AND RESPECTIVE X,Y CO-ORDINATES
!
module module_getcells
use precision
 !> This module contains a function to get a cell with all the 4 nodes and it's x and y co-ordinates
  type point 
!> Creating a type field called point
    real(rk) :: x, y, z
!> it contains the x,y,z values
  end type point 
!> ending the type field point
type cell 
!> Creating a type field called point
    integer(ik) :: indx
!> creating indx for using as a pointer
    type(point) :: P1, P2, P3, P4
!> it contains the 4 nodes any cell
  end type cell 
!> ending the type field point
contains
!> CALLING THE SUBROUTINE FOR READING MESH OUTPUT DATA  
subroutine read_data(n1,x,y) 
!> Subroutine to read the data from the output file 
  implicit none
!> Defining the data types of each variables to be used
  character ( len = 80 ) output_filename
!> Name of the output file declaration
  character ( len = 80 ) title
  integer(ik)         :: i, j
!> Declaring the data type of counters to be used in loops
 integer(ik)          ::myRow,myColumn,node_num,element_xtot,element_ytot
!> data type of the total number of rows, columns, nodes, total x co=ordinates and y co-ordinates respectively
character(len=30) :: myFileName1
!> data type for file which will be opened for reading
  real(8),allocatable :: n1(:),xyz(:,:),x(:),y(:),z(:),u(:),uvw(:,:),v(:),w(:),p(:)
!> Allocatable  2D array for storing all the x, y, z co-ordiantes and 1D array for  nodes and pressure, 2D for velocities in x,y,z and pressure
  integer,allocatable :: element_node(:,:)
   myFileName1='raw_mesh.dat'
!> declaring the name of the file which will be read
  close(99)
  open(99, file=myFileName1, status='old')
!> open the file for reading values from
  write(*,*)'open data file'
!> we write for notifying 
  read(99, *) node_num, element_xtot, element_ytot
!> reading the number of nodes, total x elements and y elements
  allocate(xyz(3,node_num))
!> Allocating the 2 D array for saving x,y,z co-ordinates of the mesh points
  allocate(z(node_num))
!> allocating array for z co-ordinates
  allocate(uvw(3,node_num))
!> allocating 2D array for the velocities in 3 directions
  allocate(p(node_num))
!> allocating the presure array
print*, node_num, element_xtot, element_ytot
!> print the number of nodes and x and y elements
  do i=1,node_num
!>  using do loop to read all the values
    read(99,*) n1(i),x(i),y(i),z(i),u(i),v(i),w(i),p(i)
!> reading all the values which is the goal of the subroutine
    print*, x(i),y(i),z(i)
!> printing the x,y and z co-ordinates of the mesh points
  enddo
!>  ending the loop
 end subroutine read_data
!> ending the subroutine for reading data
function cells(node_num,element_xtot,element_ytot) ! takes the total nodes, total nodes in X and Total nodes in Y
!>  This is the function for creating cells with all information of useful nodes
   implicit none
!> declaring data types
   real(rk),allocatable :: nodexy(:,:),n(:),x(:),y(:)
!> genertaing 2D array for storing node x and y co-ordiantes and 1D arrays for x co-ordinates and y co-ordinates
   integer(ik)::i,j,k,node_num,element_xtot,element_ytot,celltot
!> deata type integer for counter in loops and total number nodes, total x co=ordinates and y co-ordinates respectively
   type(cell),dimension((element_xtot-1)*(element_ytot-1)) :: cells
!>  declaring the type cell with prescribed dimension for cells storage 
 celltot=(element_xtot-1)*(element_ytot-1) 
!> The total number of cells in the mesh
  allocate(nodexy(node_num,2))
!> allocating array space for nodes with x and y info
  allocate(n(node_num))
!> allocation for all the nodes
  allocate(x(node_num))
!> allocation for all the x points
  allocate(y(node_num))
!> allocation for all the y points
call read_data(n, x, y) ! Using the read Module for obtaining the OUTPUT data
!> calling the subroutine which reads data from the output file
do k=1,node_num
!> using do loop to obtain fill the 2D node array with it's x and y co-ordiantes information
nodexy(k,1)= x(k)
!> filling x co-ordinates
nodexy(k,2)= y(k)
!> filling y co-ordiantes
end do
!> end of loop 
do i=1,element_xtot-1
!> First do loop for filling cells ith Node information
do j=1,element_ytot-1
!> second do loop for filling cells with node information
  cells(j+(i-1)*(element_ytot-1))%indx = j+(i-1)*(element_ytot-1)
  cells(j+(i-1)*(element_ytot-1))%P1%x = x(j+1+(i-1)*(element_ytot))
  cells(j+(i-1)*(element_ytot-1))%P1%y = y(j+1+(i-1)*(element_ytot))
  cells(j+(i-1)*(element_ytot-1))%P1%z = 1
  cells(j+(i-1)*(element_ytot-1))%P2%x = x(j+1+i*(element_ytot))
  cells(j+(i-1)*(element_ytot-1))%P2%y = y(j+1+i*(element_ytot))
  cells(j+(i-1)*(element_ytot-1))%P2%z = 1
  cells(j+(i-1)*(element_ytot-1))%P3%x = x(j+(i-1)*(element_ytot))
  cells(j+(i-1)*(element_ytot-1))%P3%y = y(j+(i-1)*(element_ytot))
  cells(j+(i-1)*(element_ytot-1))%P3%z = 1
  cells(j+(i-1)*(element_ytot-1))%P4%x = x(j+(i)*(element_ytot))
  cells(j+(i-1)*(element_ytot-1))%P4%y = y(j+(i)*(element_ytot))
  cells(j+(i-1)*(element_ytot-1))%P4%z = 1
!> all the lines of code run in iteration to give the exact node information in each cells 
end do
!> ending the second do loop
end do
!> ending the first do loop
! print*,x
! print*,y
! print*,n
! print*,cells
end function cells
!> ending the function for obtaining cells
end module module_getcells
!> end of module that gets cells 
