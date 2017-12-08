module test
    type point 
    real(8) :: x,y
  end type point

  contains 
  subroutine grid1(n, List_points)
  implicit none
  integer, intent(in) :: n 
  integer :: i,j  ! increment 
  real(8), parameter :: a=2,b=2,c=1 
  real(8) :: hx, hy
  type(point), dimension(0:n**2-1) :: List_points
  
  hx = a / dble(n-1)


  do i=0, n-1
  hy = (b-c*i*hx/a) / dble(n-1)
    do j=0, n-1
      List_points(i*n+j)%x = i*hx

      List_points(i*n+j)%y = j*hy+c*i*hx/a
    enddo
  enddo
  end subroutine

end module test
