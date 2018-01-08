!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> MODULE: module_rectmesh
!
!> @author
!> Drashti
!
! DESCRIPTION: 
!> MODULE GENERATES A MESHED 2D GRID FOR RECTANGLES 
!
!---------------------------------------------------------------------

module module_rectmesh
!> This module generates a mesh for any Rectangular Geometry
use precision
!> The precision module is used to define the precision of the variables
use read_file1_module
!> the read module is used to read co-ordinates (input) of Gemoetry
implicit none
contains
!> This module contains the following
subroutine rectmesh()
!> the subroutine rectmesh workd to take input from data file till giving output in the data file (meshed grid points)
integer(ik):: i,N,j,k,l,M,o,r,N1,M1,iter
!> All the variables of integer type being used 
real(rk), allocatable :: px(:,:),py(:,:)
!> px and py are 2D arrays which store all  x and y co-ordinates respectively 
real(rk), allocatable ::p1x(:), p1y(:),p2x(:), p2y(:)
!> p1x and p1y arrays to store points are for discretisation along x , p2x and p2y arrays to store points are for discretisation along y-axis
character(len=20)::filepoints,meshoutput
!> declaring the data types for names of input and output data files
real,allocatable::x(:), y(:)
!> declaring data types for x and y co-ordinates of the input data
real(rk):: h1,h2
!> h1 and h2 are the cell height and length respectively
real(rk), allocatable:: z1(:)
!> z1 is for (0 values of) the z axis and also the u,v,w and p which are not utilised in the current program 
call read_file(filepoints,x,y,N,M)
!> Calling the module for reading x and Y co-ordantes of the Rectangle Geometry as well as number of discretisations
print*, 'the x - co-ordiantes of your Rectangle are ',x
!> To print x co-ordinates from input data
print*, 'the y - co-ordiantes of your Rectangle are ',y
!> To print x co-ordinates from input data
print*, 'input number of points you want in vertical axis',N
!> To print number of divisions for vertivcal axis from input data
print*, 'input number of points you want in horizontal axis',M
!To print x number of divisions for vertivcal axis from input data
allocate (px(0:N+1,0:M+1))
!> Allocate matrix for all points of the mesh (height x length = size of array)
allocate (py(0:N+1,0:M+1))
!> Allocate  matrix for all y points of the mesh (height x length = size of array)
allocate (p2x(0:M+1))
!> Allocate vector for all x values of 1D i.e the length
allocate (p2y(0:M+1))
!> Allocate vector for all y values of 1D i.e the length
allocate (p1x(0:N+1))
!> Allocate vector for all x values of 1D i.e the height
allocate (p1y(0:N+1))
!> Allocate vector for all x values of 1D i.e the height
N1=N+2
M1=M+2
!> increment in size to accomodate the 0th element 
allocate (z1(N1*M1))
!>  Allocate vector for all z values which will be filled by 0s only (for this program) 
z1=0
!> fill z1 with 0
h2 = (y(2)-y(1))/(N+1)
!> calculating the height of the cell of grid 
h1 = (x(4)-x(1))/(M+1)
!> calculating the length of the cell of grid
print*,h1
!> printng the length of the cell of grid
do i=0,N+1
!> running the loop to fill appropriate points in 1D mesh for height of Rectangle 
p1y(i) = y(1) + (y(2)-y(1))*i/(N+1)
!> 1D mesh along the y- axis
p1x(i) = x(1) + (x(2)-x(1))*i/(N+1)
!> !D mesh alond the x-axis
end do
!> end of do loop
do k=0,M+1
!> running the loop to fill appropriate points in 1D mesh for Lenght of Rectangle
p2y(k) = y(1) + (y(4)-y(1))*k/(M+1)
!> 1D mesh along the y- axis
p2x(k) = x(1) + (x(4)-x(1))*k/(M+1)
!> 1D mesh along the y- axis
end do
!> end of do loop
do l=0,M+1
!> do Loop for mesh on the entire Rectangle (2D)
px(:,l)= p1x(l) + l*h1
!> Filling the x co-ordinates
py(:,l) = p1y
! Filling the y co-ordinates (same as p1y as we take reference of height for meshing)
end do
!> end of do loop
meshoutput ='raw_mesh.data'
!> defining the file for writing the mesh output data 
 open(11,file=meshoutput) 
!> Opening the file 
 print*, ' ---------------------------- OUTPUT : MESH POINTS ------------------------------------'
iter=0
!> Iteration for loop to prit thr Arrays
do r=0, N+1
!> First do loop writing/printing 2D arrays
do o=0, M+1
!> Second do loop writing/printing 2D arrays
iter=iter+1
!> incrementing the iterations
print*, 'Node',iter,  'px', px(o,r), '  py',py(o,r), 'pz' ,z1(iter), 'u',z1(iter), 'v',z1(iter), 'w',z1(iter)
!> Printing output
write (11,*) M1*N1, M1, N1
write(11,*) iter,   px(o,r), py(o,r), z1(iter), z1(iter), z1(iter), z1(iter)
!> Writing output into the designated file
end do
!> end second do loop 
end do
!> end first do loop
 close(11)
!> close the file 
end subroutine
!> end of subroutine
end module module_rectmesh
!> end of the module
