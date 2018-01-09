!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> MODULE: Smoothness
!
!> @author
!> Roy Prosun
!
!> DESCRIPTION: 
!>  To Reckon the Smoothness of a given mesh
!
!---------------------------------------------------------------------
!

module smoothness_factor
use  module_getcells
use precision

  contains 
 subroutine smoo
!--------------- Declaration of variables-------------------!
implicit none 
real(rk) :: smthf, max_smooth                                  	
!> value of smoothness of the mentioned grid and its max value
integer(ik) :: k                                         	
!> number of cell
character(len=20) :: datafile                            	
!> test data file
character(len=20) :: myFileName1                         	
!> To consider Drashti's mapping module
integer(ik) :: node_num, element_xtot, element_ytot     	
!> To consider Drashti's mapping module
real(8), allocatable :: map1 (:,:,:)                        	
!> Vectors in all cells
integer :: i
integer,parameter :: n=3 
!-----------------------Define a type point ----------------------------!

!type Point
!real(rk) :: x, y, z			! ALREADY DEFINED AT MODULE 
!end type Point

!------------------------------------------------------------------------!

type(Point) :: P_1, P_2, P_3, P_4

!---------------------In order to includ Drashti's mapping -----------------!
myFileName1='raw_mesh.dat'
open(99, file=myFileName1)
write(*,*)'open data file'
read(99, *) node_num,element_xtot,element_ytot
  
map1 = map1(node_num,element_xtot,element_ytot)  		!it is indicating that all the cells contained required vectors


!---------------------In order to executing my Test -----------------------!
datafile = 'data.dat' 		!'data_point_cell.dat'
open(1, file = datafile, status = 'old') 
read(1, *) k, P_1%x, P_1%y, P_1%z, P_2%x, P_2%y, P_2%z, P_3%x, P_3%y, P_3%z, P_4%x, P_4%y, P_4%z
  
!--------------------------------------------------------------------------!

max_smooth = 1.2

do i=1, node_num-1

if ((P_3%x-P_2%x) >= (1.2*(P_2%x-P_1%x))) then 		!formulation which predict smoothness of a given mesh
      smthf = ((P_3%y-P_2%y)/(P_2%x-P_1%x))

else if ((P_4%x-P_3%x) >= (1.2*(P_3%x-P_2%x))) then
       smthf = ((P_4%y-P_3%y)/(P_3%x-P_2%x))
else 
	smthf = 1.2
end if

end do 

print*, smthf
  end subroutine smoo
end module smoothness_factor
