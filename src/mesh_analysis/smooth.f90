program smoothness
implicit none
integer,parameter :: n=3
real(8) :: gam, bet
real(8) :: optc, K, P, W
real(8), dimension(0:n**2-1) :: L
integer :: ia, ib

call grid

gam = W-P
bet = P-K
optc = gam/bet

do ib=0, n**2-n-2, n
do ia=1,n-1
K = L(ia+ib)
P = L(ia+ib+1)
W = L(ia+ib+3)

print*, ia, ib

if (gam>bet) then  
optc= 1.2		!'optc' is ratio of 'gam' and 'bet'
end if

!print*, K%x, P%y, W%x

end do
end do
print*, L

contains
subroutine grid
implicit none

real(8) :: x,y
integer :: n
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
!print*, n
end subroutine grid
end program smoothness
