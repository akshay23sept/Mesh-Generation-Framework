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

program skewness_1cell
  use  READ_MAP 
  use precision

!  contains 
 ! subroutine skewness_one_cell(s)
  implicit none 
  real(rk) :: Pi_8 = 4*atan(1._8)
  real(rk) :: s, max_skewness                              ! value of the skewness
  real(rk) :: max_angle                                    ! max angle in a cell
  real(rk) :: alpha, beta                                  ! value of the angles 
  integer(ik) :: k                                         ! Cell number
  character(len=20) :: datafile                            ! Data file for my test
  character(len=20) :: myFileName1                         ! in order to include Drashti's mapping
  integer(ik) :: node_num, element_xtot, element_ytot      ! in order to include Drashti's mapping
  real(8), allocatable :: map1(:,:)                        ! Vector containing all the cells (in order to simplify the code == no breaking column)
  integer :: i,n
!!!!!!!!!!!!!!!!!!! Define a type point !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  type Point
    real(8) :: x,y,z
  end type Point

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  type(Point) :: P_1, P_2, P_3, P_4

!!!!!!!!!!!!!!! In order to includ Drashti's mapping !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  myFileName1='raw_mesh.dat'

  open(99, file=myFileName1)
  write(*,*)'open data file'
  read(99, *) node_num,element_xtot,element_ytot
  
  map1 = map(node_num,element_xtot,element_ytot)  ! Now I have the vector containing all the cells 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!! For my test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  datafile = 'data.dat' !'data_point_cell.dat'
  
  open(1, file = datafile, status = 'old') 
  read(1, *) k, P_1%x, P_1%y, P_1%z, P_2%x, P_2%y, P_2%z, P_3%x, P_3%y, P_3%z, P_4%x, P_4%y, P_4%z
  
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  max_skewness = 0

  do i=1, node_num-1

  if (P_1%x-P_3%x > 0) then 
      alpha = atan((P_1%y-P_3%y)/(P_1%x-P_3%x))

  else if (P_1%x-P_3%x < 0) then
      alpha = Pi_8 + atan((P_1%y-P_3%y)/(P_1%x-P_3%x))

      else 
      alpha = Pi_8 / 2.
  end if

  alpha = abs(alpha-atan((P_4%y-P_3%y)/(P_4%x-P_3%x)))

  if ((P_3%x-P_1%x) > 0.) then  
      beta = atan((P_1%y-P_3%y)/(P_1%x-P_3%x))

  else if ((P_3%x-P_1%x) < 0.) then
      beta = -Pi_8 + atan((P_1%y-P_3%y)/(P_1%x-P_3%x))

      else 
      beta = -Pi_8 / 2.
  end if
  
  beta = abs(beta-atan((P_2%y-P_1%y)/(P_2%x-P_1%x)))
  
  alpha = alpha * 180 / Pi_8
  beta = beta * 180 / Pi_8

  max_angle = max(alpha, beta) 
  max_skewness = max(max_skewness, max_angle)

  end do 

!  print*, 'Alpha'
!  print*, alpha
!  print*, 'Beta'
!  print*, beta 
  print*, max_skewness
!  end subroutine skewness_one_cell

end program skewness_1cell
