!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> MODULE: newtonmod
!
!> @author
!> Alvaro
!
! DESCRIPTION: 
!> This module helps to be able to establish more points in the local streching.
!
!---------------------------------------------------------------------
!



module newtonmod
use precision
contains 

!Subroutine of Newton to be able to establish more points in the local streching.
!This local streching is made by a Chebyshev distribution always.
subroutine newton(x, y, y2, N, inicio, fin, xinicio, xfin, xnuevo, ynuevo, y2nuevo, dimxnuevo)
implicit none
real::x(:), y(:), y2(:), xdist, dalfa, L, smallalfa, LL, xx, pol, factor
real, allocatable:: d(:), c(:), alfa(:), b(:)
integer, intent(in)::N, dimxnuevo, inicio, fin
real, intent(in):: xinicio, xfin
real, allocatable, intent(out):: xnuevo(:), ynuevo(:), y2nuevo(:)
integer:: i, j, counter, k, dx, katras, kalante, casos
allocate(d(N), alfa(N), b(N), xnuevo(dimxnuevo), ynuevo(dimxnuevo), y2nuevo(dimxnuevo))
do casos=1,2
if (casos==1) then 

b=y
else
b=y2
end if
d=b
 alfa(1)=b(1)
  counter=0
  do k=1, 1000
  counter=counter+1
  if (counter==N) exit
  allocate (c(size(d)-1))
  dx=N-size(c)
  do i=1, size(c)
  c(i)=(d(i+1)-d(i))/(x(i+dx)-x(i))
  if (i==1) then
  alfa(N-size(c)+1)=c(i)
  end if
  end do
  deallocate(d)
  
  counter=counter+1
  if (counter==N) exit
  allocate (d(size(c)-1))
  dx=N-size(d)
  do j=1,size(d)
  d(j)=(c(j+1)-c(j))/(x(j+dx)-x(j))
  if (j==1) then
  alfa(N-size(d)+1)=d(j)
  end if
  end do
  deallocate (c)
  end do
  do i=1,N 
  end do
  LL=x(fin)-x(inicio)
  !print*, 'LL es', LL
  katras=dimxnuevo
  kalante=1
  xx=xinicio 
  dalfa=(3.14159265/2.0)/real((dimxnuevo-1))
  smallalfa=0.0

  do k=1,dimxnuevo
  if (((k/2)*2.0)<k) then
  xx=x(inicio)+(xx-x(inicio))/2.0
  else
  xx=x(fin)-(xx-x(inicio))/2.0
  end if

  factor=1.0 
  pol=alfa(1)
  do j=1,(N-1)
  factor=factor*((xx)-x(j))  
  pol=pol+alfa(j+1)*factor
  end do
  if (((k/2)*2.0)<k) then
  xnuevo(kalante)=xx
  if (casos==1) then
  ynuevo(kalante)=pol
  else
  y2nuevo(kalante)=pol
  end if 
  kalante=kalante+1
  else
  xnuevo(katras)=xx
  if (casos==1) then
  ynuevo(katras)=pol
  else
  y2nuevo(katras)=pol
  end if
  katras=katras-1
  end if
  smallalfa=smallalfa+dalfa
  xx=xinicio+LL*sin(smallalfa)
  end do
  end do
  end subroutine newton

!Chebyshev distribution
subroutine chevy(xbig, ybig, zbig, x, y, y2, M, N)
implicit none
real::x(:), y(:), y2(:) !, xbig, ybig, zbig

real, allocatable, intent(out):: xbig(:), ybig(:), zbig(:)
integer, intent(in)::M, N
real:: dalfa, L, smallalfa
integer:: i, j, counter
allocate(xbig(N*M),ybig(N*M),zbig(N*M))

dalfa=(3.14159265)/real((M-1))
counter=0
do j=1, N  
smallalfa=0.0
L=y2(j)-y(j) 
do i=1,M
counter=counter+1
xbig(counter)=x(j)
ybig(counter)=y(j)+L/2.0-L*cos(smallalfa)/2.0
zbig(counter)=1.0
smallalfa=smallalfa+dalfa
end do
end do
end subroutine chevy

!The arcsen distribution uses the interval of x(-0.975, 0.975) to create the points.
subroutine arcsen(xbig, ybig, zbig, x, y, y2, M, N) 
implicit none
real::x(:), y(:), y2(:)
real, allocatable, intent(out):: xbig(:), ybig(:), zbig(:)
integer, intent(in)::M, N
real:: dx, L, smallx
integer:: i, j, counter
allocate(xbig(N*M),ybig(N*M),zbig(N*M))
dx=1.95/real((M-1))
counter=0
do j=1, N 
smallx=-0.975
L=y2(j)-y(j) 
do i=1,M
counter=counter+1
xbig(counter)=x(j)
ybig(counter)=y(j)+L/2.0+(L/2.0)*asin(smallx)/asin(0.975)
zbig(counter)=1.0
smallx=smallx+dx
end do
end do
end subroutine arcsen

!The hyperbolic tangent distribution uses the interval of x(-2,2) to create the points.
subroutine tanhip(xbig, ybig, zbig, x, y, y2, M, N) 
implicit none
real::x(:), y(:), y2(:)
real, allocatable, intent(out):: xbig(:), ybig(:), zbig(:)
integer, intent(in)::M, N
real:: dx, L, smallx
integer:: i, j, counter
allocate(xbig(N*M),ybig(N*M),zbig(N*M))
dx=4.0/real((M-1))
counter=0
do j=1, N  
smallx=-2.0
L=y2(j)-y(j) 
do i=1,M
counter=counter+1
                xbig(counter)=x(j)
                        ybig(counter)=y(j)+L/2.0+(L/2.0)*tanh(smallx)/tanh(2.0)
                                zbig(counter)=1.0
smallx=smallx+dx
        end do
                end do

end subroutine tanhip

subroutine linear(xbig, ybig, zbig, x, y, y2, M, N)
implicit none
real::x(:), y(:), y2(:)
real, allocatable, intent(out):: xbig(:), ybig(:), zbig(:)
integer, intent(in)::M, N
real:: dx, L, smallx
integer:: i, j, counter
allocate(xbig(N*M),ybig(N*M),zbig(N*M))
dx=1.0/real((M-1))
counter=0
do j=1, N  
smallx=0.0
L=y2(j)-y(j) 
do i=1,M
counter=counter+1
xbig(counter)=x(j)
ybig(counter)=y(j)+L*smallx
zbig(counter)=1.0
smallx=smallx+dx
end do
end do
end subroutine linear



end module
