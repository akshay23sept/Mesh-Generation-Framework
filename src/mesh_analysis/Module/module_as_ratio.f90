  module ratio
! this module works for ordering and obtaining the 4 points of every cell
  contains
! contains
  subroutine test1(maxi_as)
! subroutine test1 to get the 4 points (4 corners) of every cell
  use READ_MAP
! READ_MAP is the MODULE CONTAINS A FUNCTION FOR CONFORMAL OF CELLS AND NODES
  implicit none
! IMPLICIT NONE
  real(8) :: p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z,p4x,p4y,p4z 
! 3 positions of 4 points P(x,y,z) 'the coordinate' of every cell                   
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
    P2 = map1(i)%P2
    P3 = map1(i)%P3
    P4 = map1(i)%P4
    
    p1x = P1%x
    p1y = P1%y
    p1z = P1%z
    
    p2x = P2%x
    p2y = P2%y
    p2z = P2%z

    p3x = P3%x
    p3y = P3%y
    p3z = P3%z

    p4x = P4%x
    p4y = P4%y
    p4z = P4%z
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
end subroutine test1

end module ratio
