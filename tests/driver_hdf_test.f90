program functional_tests
  use fruit
  use test_hdf5 
  implicit none
 
  print*, 'INIT FRUIT DRIVER'
  call init_fruit
 
  call check_hdf5_link() 

  call fruit_summary
  print*, 'END OF FRUIT DRIVER'
end program functional_tests

