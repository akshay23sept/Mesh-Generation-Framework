program test_skewness
  use skewness_1cell
  implicit none
  character(len=20) :: myFileName1

  myFileName1 = 'raw_mesh.dat'
  
  call File_Skewness(myFileName1)

end program test_skewness
