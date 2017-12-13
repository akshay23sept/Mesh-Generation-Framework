program read
!!!!!!!!!!!! A test program to check that the generated module for reading data is running perfect or not !!!!!!!!!!!!

!//// Calling my module for the "basic-check" of module which will be further "implimanted" in mesh-gen program !////

use read_file_module


implicit none

                integer ::N,i
                character(len=20)::filepuntos
                real,allocatable::x(:), y(:), y2(:) 
                real,allocatable :: d(:), c(:), alfa(:), b(:)


filepuntos='puntosmalla.dat'
call read_file (filepuntos,x,y,y2,N)


print*, 'x','y','y2'

end program read
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!compile using //  gfortran read.f90 -o read.exe   //
! //To integrate the module with the main program then to check wheather module is working perfect or not !  //
!compile using     //  gfortran read.f90 read_file.o -o read.exe  //
!Run using  // ./read.exe  //


