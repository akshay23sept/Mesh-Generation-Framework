
module rat
type point 
    real(8) :: x,y
  end type point

contains
subroutine grid
implicit none

real(8) :: x,y
integer :: n=3
integer :: i,j   
real(8), parameter :: a=2,b=2,c=1
real(8) :: hx, hy, dble
real(8), dimension(0:3**2-1) :: L
  
hx = a / dble(n-1)

do i=1, n-2
hy = (b-c*i*hx/a) / dble(n-1)
do j=1, n-2
L(i*n+j) = i*hx

L(i*n+j) = j*hy+c*i*hx/a
enddo
enddo

end subroutine grid

end module rat
