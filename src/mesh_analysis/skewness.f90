program skewness
  use test 
  implicit none
  integer,parameter :: n=3
  real(8) :: s, maxi
  real(8), parameter :: Pi_8 = 4*atan(1._8)
  real(8) :: Alpha
  type(Point) :: P, Q, R
  type(point), dimension(0:n**2-1) :: L
  integer :: i,ii

call grid1(n,L)
maxi = Pi_8/2.
  do ii=0, n**2-n-2, n
  do i=0, n-2
      P%x = L(i+ii)%x
      P%y = L(i+ii)%y
      Q%x = L(i+ii+1)%x
      Q%y = L(i+ii+1)%y
      R%x = L(i+ii+n)%x
      R%y = L(i+ii+n)%y
      print*, i, ii
      if ((P%x-Q%x) == 0.) then  
        alpha = Pi_8 / 2.
print*, 'je suis dans la boucle if'
      else 
print*, 'je suis dans la boucle else'
        alpha = atan((Q%y-P%y)/(Q%x-P%x))
      end if
print*, 'P'
 print*, Q%x, Q%y!, Q%x, Q%y, R%x, R%y
    maxi = min( maxi, abs(alpha-atan((R%y-P%y)/(R%x-P%x))))
    s = atan((R%y-P%y)/(R%x-P%x))
  enddo
enddo
maxi = maxi*360 / (2*Pi_8)

print*, L
print*, maxi
end program skewness 
