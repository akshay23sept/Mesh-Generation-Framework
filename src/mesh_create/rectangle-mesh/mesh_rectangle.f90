program simple_mesh

implicit none

integer :: i,N,j,k,l,M,o,r,N1,M1,iter
real, allocatable :: px(:,:),py(:,:), p1x(:), p1y(:),p2x(:), p2y(:)
character(len=20)::filepoints,meshoutput
real,allocatable::x(:), y(:)
real :: h1,h2
real, allocatable:: z1(:)
filepoints ="input_points.dat"
        open(99, file=filepoints)
        allocate(x(4),y(4))

 do j=1,4
 read(99, *)  x(j), y(j)
 end do
read(99,*) M
read(99,*) N

print*, 'the x - co-ordiantes of your Rectangle are ',x
print*, 'the y - co-ordiantes of your Rectangle are ',y

print*, 'input number of points you want in vertical axis',N

print*, 'input number of points you want in horizontal axis',M



allocate (px(0:N+1,0:M+1))
allocate (py(0:N+1,0:M+1))
allocate (p2x(0:M+1))
allocate (p2y(0:M+1))
allocate (p1x(0:N+1))
allocate (p1y(0:N+1))
N1=N+2
M1=M+2
allocate (z1(N1*M1))
z1=0

h2 = (y(2)-y(1))/(N+1)
h1 = (x(4)-x(1))/(M+1)
print*,h1

do i=0,N+1
p1y(i) = y(1) + (y(2)-y(1))*i/(N+1)
p1x(i) = x(1) + (x(2)-x(1))*i/(N+1)
end do

do k=0,M+1
p2y(k) = y(1) + (y(4)-y(1))*k/(M+1)
p2x(k) = x(1) + (x(4)-x(1))*k/(M+1)
end do

!print*, 'x co-ordinates points in 3rd side (P1)',p1x
!print*, 'y co-ordinates points in 3rd side (P1)',p1y

do l=0,M+1
px(:,l)= p1x(l) + l*h1
py(:,l) = p1y
end do

!print*, 'p x =', px
!print*, 'p y =', py

meshoutput ='raw_mesh.data'
 open(11,file=meshoutput) 
 print*, ' ---------------------------- OUTPUT : MESH POINTS ------------------------------------'
iter=0
do r=0, N+1
do o=0, M+1
iter=iter+1
print*, 'Node',iter,  'px', px(o,r), '  py',py(o,r), 'pz' ,z1(iter), 'u',z1(iter), 'v',z1(iter), 'w',z1(iter)
write(11,*) iter,   px(o,r), py(o,r), z1(iter), z1(iter), z1(iter), z1(iter)
end do
end do
 close(11)
! the get cells should work perfectly with this output 
end program simple_mesh
