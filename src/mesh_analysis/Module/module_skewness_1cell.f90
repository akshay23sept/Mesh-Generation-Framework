module skewness_1cell
  contains 

  subroutine File_Skewness
!> Subroutine which creates sum-up file and print maximum skewness for the file raw_mesh.dat
  use  module_getcells   
!> Use the module to create the cells 
  use precision
!> Precision module
  implicit none 
  real(rk), parameter :: theta_e = 90_8      
!> angle value for skewness calculation              
  real(rk) :: Pi_8 = 4*atan(1._8)
!> Value for Pi
  real(rk) :: max_skewness                   
!> value of the maximum of the skewness
  real(rk) :: skewness 
!> value of the skewness for one angle
  real(rk) :: max_angle
!> max angle in a cell
  real(rk) :: min_angle
!> min angle in a cell
  real(rk) :: alpha, beta, gamma_                         
!> all value of the angles 
  integer(ik) :: k                                        
!> Cell number
  character(len=30) :: datafile                           
!> Data file for the result
  character(len=20), parameter :: myFileName1='raw_mesh.dat'             
!> in order to include Drashti's mapping
  integer(ik) :: node_num, element_xtot, element_ytot     
!> all mesh parameters
  type(cell), allocatable :: map1(:)                      
!> Vector containing all the cells (in order to simplify the code == no breaking column)
  integer :: i,n
!> Increments
  type(Point) :: P_1, P_2, P_3, P_4
!> All points in one cell

!!!!!!!!!!!!!!! In order to includ Drashti's mapping!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  datafile = 'results_skewness.dat'
!> Data file for the result
  open(99, file=myFileName1)                                        
  read(99, *) node_num,element_xtot,element_ytot                                                                                                
  open(98, file=datafile)                                                                        

  allocate(map1((element_xtot-1)*(element_ytot-1)))
  map1 = cells(node_num,element_xtot,element_ytot)  !Now I have the vector containing all the cells 

  max_skewness = 0
!> initialization for the max_skewness
  
  do i=1, (element_xtot-1)*(element_ytot-1)
    P_1 = map1(i)%P1
!> point in the top right of the cell number i
    P_2 = map1(i)%P2
!> point in the top left of the cell number i
    P_3 = map1(i)%P3
!> point in the bottom right of the cell number i
    P_4 = map1(i)%P4
!> point in the bottom left of the cell number i

  if (P_1%x-P_3%x > 0) then                                                                                  
      alpha = atan((P_1%y-P_3%y)/(P_1%x-P_3%x))                                                              
!> Computation of alpha                                                                                                             
  else if (P_1%x-P_3%x < 0) then                                                                             
      alpha = Pi_8 + atan((P_1%y-P_3%y)/(P_1%x-P_3%x))                                                       
!> Computation of alpha                                                                                                             
      else                                                                                                   
      alpha = Pi_8 / 2. 
!> Computation of alpha case right angle                                                                                     
  end if                                                                                                     
                                                                                                             
  alpha = abs(alpha-atan((P_4%y-P_3%y)/(P_4%x-P_3%x)))                                                       
!> Computation of alpha 
                                                                                                             
  if ((P_3%x-P_1%x) > 0.) then                                                                               
      beta = atan((P_1%y-P_3%y)/(P_1%x-P_3%x))                                                               
!> Computation of beta                                                                                                             
  else if ((P_3%x-P_1%x) < 0.) then                                                                          
      beta = -Pi_8 + atan((P_1%y-P_3%y)/(P_1%x-P_3%x))                                                       
!> Computation of beta                                                                                                             
      else                                                                                                   
      beta = -Pi_8 / 2.  
!> Computation of beta case right angle                                                                                      
  end if                                                                                                     
                                                                                                             
  beta = abs(beta-atan((P_2%y-P_1%y)/(P_2%x-P_1%x)))                                                         
!> Computation of beta  
                                                                                                           
  if ((P_2%x-P_4%x) > 0.) then                                                                               
      gamma_ = atan((P_2%y-P_4%y)/(P_2%x-P_4%x))                                                             
!> Computation of gamma_                                                                                                              
  else if ((P_2%x-P_4%x) < 0.) then                                                                          
      gamma_ = Pi_8 + atan((P_2%y-P_4%y)/(P_2%x-P_4%x))                                                      
!> Computation of gamma_                                                                                                             
      else                                                                                                   
      gamma_ = Pi_8 / 2. 
!> Computation of gamma_ case right angle                                                                                    
  end if                                                                                                     
                                                                                                             
  gamma_ = abs(gamma_-atan((P_4%y-P_3%y)/(P_3%x-P_4%x)))                                                     
!> Computation of gamma_                                                                                                             

  alpha = alpha * 180 / Pi_8
!> Conversion into degree                                                                                 
  beta = beta * 180 / Pi_8
!> Conversion into degree                                                                                   
  gamma_ = gamma_ * 180 / Pi_8
!> Conversion into degree                                                                               
                                                                                                             
  max_angle = max(alpha, beta, gamma_, 360.-alpha-beta-gamma_) 
!> max angle between the 4 angles in the cell                                               
  min_angle = min(alpha, beta, gamma_, 360.-alpha-beta-gamma_)                                                                       
!> min angle between the 4 angles in the cell
  skewness = max((max_angle-theta_e)/(180.-theta_e), (theta_e-min_angle)/theta_e)   
!> Calculation of the skweness in the case of rectagular mesh                         
  max_skewness = max(max_skewness, skewness)                 
!> Calculation of the maximum of the skewness for all the mesh                                                
                                                                                                                   
  write(98,*) i, skewness                                     
!> Write a sum-up for every cell                                               
                                                                                                             
  end do                                                                                                     
                                                                                                             
  print*, 'maximum skewness', max_skewness                                                                   
  print*, '------------------------------------------------------'                                           
  if (max_skewness == 1) then                                                                                
    print*, ' degenerate mesh: need to improve the mesh! Please '                                            
  elseif (max_skewness >= 0.9) then                                                                          
    print*, ' bad mesh: come on, do it better please! '                                                      
  elseif (max_skewness >= 0.75) then                                                                         
    print*, ' poor mesh: enough for small results not so important '                                         
  elseif (max_skewness >= 0.5) then                                                                          
    print*, ' fair mesh: fair enough! '                                                                      
  elseif (max_skewness >= 0.25) then                                                                         
    print*, ' Good mesh: it is nice for good results '                                                       
  elseif (max_skewness > 0) then                                                                             
    print*, ' Excellent mesh: good job! '                                                                    
  elseif (max_skewness == 0) then                                                                            
    print*, ' equilateral mesh: almost perfect! '                                                            
  endif                                                                                                        
  print*, '------------------------------------------------------'                                            

  end subroutine File_Skewness

end module skewness_1cell
