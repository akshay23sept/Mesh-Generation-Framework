  module ratio
! this module works for ordering and obtaining the 4 points of every cell
  contains
! contains
  subroutine test1(maxi_as)
! subroutine test1 to get the 4 points (4 corners) of every cell
  use module_getcells
! READ_MAP is the MODULE CONTAINS A FUNCTION FOR CONFORMAL OF CELLS AND NODES
  implicit none
! IMPLICIT NONE
  real(8) :: p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z,p4x,p4y,p4z 
! 3 components of 4 points P(x,y,z) 'the coordinate' of every cell                   
  real(8) :: as, p1p2, p2p3, p3p4, p4p1
! the 4  lengths of the cell                                         
  integer :: N
  integer :: k,i  
! k is the Cell number, I is the vraiable of the loop                                                     
  real(8), intent(out) :: maxi_as 
! the maximum as for all cells                                               
  character(len=30) :: testfile
! Data file for the data
  type(cell), allocatable :: map1(:) 
! Vector containing all the cells
  type(point) :: P1, P2, P3, P4
! I  defined 4 points (one for each corner of the cell)
  integer :: node_num, element_xtot, element_ytot
! comes from Drashti's mapping
  testfile = 'raw_mesh.dat'
! the file I used to import the data
  open(99,file=testfile)
  READ(99,*) node_num,element_xtot,element_ytot
! import the number of cells from the data file                                      
  maxi_as = 0                                                                   
! initial aspect ratioequal to 0
  allocate(map1((element_xtot-1)*(element_ytot-1)))
! in order to write the points in the correct order
  map1 = cells(node_num,element_xtot,element_ytot)
! the vector containing all the cells
 do i=1, (element_xtot-1)*(element_ytot-1)
! Here, I will use READ_MAP module : In this module, I can call 
! read (1,*) k,p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z,p4x,p4y,p4z                   ! import the data of points from the data file

    P1 = map1(i)%P1
!   first point of every cell in the mesh
    P2 = map1(i)%P2
!   second point of every cell in the mesh
    P3 = map1(i)%P3
!   third point of every cell in the mesh
    P4 = map1(i)%P4
!   fourth point of every cell in the mesh
    
    p1x = P1%x
!   X- component of first point of every cell
    p1y = P1%y
!   Y- component of first point of every cell
    p1z = P1%z
!   Z- component of first point of every cell
    
    p2x = P2%x
!   X- component of second point of every cell
    p2y = P2%y
!   Y- component of second point of every cell
    p2z = P2%z
!   Z- component of second point of every cell

    p3x = P3%x
!   X- component of third point of every cell
    p3y = P3%y
!   Y- component of third point of every cell
    p3z = P3%z
!   Z- component of third point of every cell

    p4x = P4%x
!   X- component of fourth point of every cell
    p4y = P4%y
!   Y- component of fourth point of every cell
    p4z = P4%z
!   Z- component of fourth point of every cell
                          !//////////////////////////////////////////////////////////////////

    p1p2=(((p2x-p1x)**2)+(((p2y-p1y)**2))+(((p2z-p1z)**2)))**0.5
!   the length magnitute between p1 and p2 points                 
    p2p3=(((p3x-p2x)**2)+(((p3y-p2y)**2))+(((p3z-p2z)**2)))**0.5 
!   the length magnitute between p2 and p3 points           
    p3p4=(((p4x-p3x)**2)+(((p4y-p3y)**2))+(((p4z-p3z)**2)))**0.5 
!   the length magnitute between p3 and p4 points    
    p4p1=(((p4x-p1x)**2)+(((p4y-p1y)**2))+(((p4z-p1z)**2)))**0.5 
!   the length magnitute between p4 and p1 points     
    
                          !///////////////////////////////////////////////////////////////////
    as=(max(p1p2,p2p3,p3p4,p4p1))/(min(p1p2,p2p3,p3p4,p4p1))                    
!   the aspect ratio of every cell    
    maxi_as = max(maxi_as, as)                                                  
!   Maximum aspect ration in the mesh
    print*, P1, P2, P3, P4
!   print the 4 points(4 corners) of every cell
  end do


   close(99)
!  close the data file
  end subroutine test1
! end subroutine test1
  end module ratio

