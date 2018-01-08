module skewness_1cell
  contains 

  subroutine File_Skewness
  use  READ_MAP    
  use precision

  implicit none 
  real(rk), parameter :: theta_e = 90_8                    
  real(rk) :: Pi_8 = 4*atan(1._8)
  real(rk) :: s, max_skewness,skewness                    ! value of the skewness
  real(rk) :: max_angle, min_angle                        ! max,min angle in a cell
  real(rk) :: alpha, beta, gamma_                         ! value of the angles 
  integer(ik) :: k                                        ! Cell number
  character(len=30) :: datafile                           ! Data file for the result
  character(len=20), parameter :: myFileName1='raw_mesh.dat'             ! in order to include Drashti's mapping
  integer(ik) :: node_num, element_xtot, element_ytot     ! in order to include Drashti's mapping
  type(cell), allocatable :: map1(:)                      ! Vector containing all the cells (in order to simplify the code == no breaking column)
  integer :: i,n
  type(Point) :: P_1, P_2, P_3, P_4

!!!!!!!!!!!!!!! In order to includ Drashti's mapping!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  datafile = 'results_skewness.dat'

  open(99, file=myFileName1)                                                                     
                                                                   
  read(99, *) node_num,element_xtot,element_ytot                                                 
                                                                                                
  open(98, file=datafile)                                                                        

  allocate(map1((element_xtot-1)*(element_ytot-1)))
  map1 = cells(node_num,element_xtot,element_ytot)  Now I have the vector containing all the cells 

  max_skewness = 0
  
  do i=1, (element_xtot-1)*(element_ytot-1)
    P_1 = map1(i)%P1
    P_2 = map1(i)%P2
    P_3 = map1(i)%P3
    P_4 = map1(i)%P4
 
  if (P_1%x-P_3%x > 0) then                                                                                  
      alpha = atan((P_1%y-P_3%y)(P_1%x-P_3%x))                                                              
                                                                                                             
  else if (P_1%x-P_3%x < 0) then                                                                             
      alpha = Pi_8 + atan((P_1%y-P_3%y)(P_1%x-P_3%x))                                                       
                                                                                                             
      else                                                                                                   
      alpha = Pi_8  2.                                                                                      
  end if                                                                                                     
                                                                                                             
  alpha = abs(alpha-atan((P_4%y-P_3%y)(P_4%x-P_3%x)))                                                       
                                                                                                             
  if ((P_3%x-P_1%x) > 0.) then                                                                               
      beta = atan((P_1%y-P_3%y)(P_1%x-P_3%x))                                                               
                                                                                                             
  else if ((P_3%x-P_1%x) < 0.) then                                                                          
      beta = -Pi_8 + atan((P_1%y-P_3%y)(P_1%x-P_3%x))                                                       
                                                                                                             
      else                                                                                                   
      beta = -Pi_8  2.                                                                                      
  end if                                                                                                     
                                                                                                             
  beta = abs(beta-atan((P_2%y-P_1%y)(P_2%x-P_1%x)))                                                         
                                                                                                             
  if ((P_2%x-P_4%x) > 0.) then                                                                               
      gamma_ = atan((P_2%y-P_4%y)(P_2%x-P_4%x))                                                             
                                                                                                             
  else if ((P_2%x-P_4%x) < 0.) then                                                                          
      gamma_ = Pi_8 + atan((P_2%y-P_4%y)(P_2%x-P_4%x))                                                      
                                                                                                             
      else                                                                                                   
      gamma_ = Pi_8  2.                                                                                     
  end if                                                                                                     
                                                                                                             
  gamma_ = abs(gamma_-atan((P_4%y-P_3%y)(P_3%x-P_4%x)))                                                     
                                                                                                             
  alpha = alpha * 180  Pi_8                                                                                 
  beta = beta * 180  Pi_8                                                                                   
  gamma_ = gamma_ * 180  Pi_8                                                                               
                                                                                                             
  max_angle = max(alpha, beta, gamma_, 360.-alpha-beta-gamma_)                                                
  min_angle = min(alpha, beta, gamma_, 360.-alpha-beta-gamma_)                                                                       
  skewness = max((max_angle-theta_e)(180.-theta_e), (theta_e-min_angle)theta_e)                            
  max_skewness = max(max_skewness, skewness)                                                                 
                                                                                                                   
  write(98,*) i, skewness                                                                                    
                                                                                                             
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
