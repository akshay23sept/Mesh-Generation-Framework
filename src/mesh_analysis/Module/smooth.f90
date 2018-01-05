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

program smoothness
use rat
implicit none
integer,parameter :: n=3
real(8) :: alpha, beta, gam, phi, smth
type(Point) :: K, P, W 
type(point), dimension(0:n**2-1) :: L
integer :: ia, ib

call grid
alpha = W%x-P%x 
beta = P%x-K%x
gam =  W%y-P%y 
phi = P%x-K%x

do ib=0, n**2-n-2, n
do ia=1,n-2

K%x = L(ia+ib)%x
K%y = L(ia+ib)%y
P%x = L(ia+ib+1)%x
P%y = L(ia+ib+1)%y
W%x = L(ia+ib+n)%x
W%y = L(ia+ib+n)%y

print*, ia, ib


if (alpha>=(beta*1.2)) then  
smth= (alpha/beta) 	

end if

print*, smth

end do
end do
print*, L
end program smoothness
