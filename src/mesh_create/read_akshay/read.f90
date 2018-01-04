program read

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!> This is a simple program to check wheather the module is working in desired manner or not 

use read_file_module

!> This is the permission given to the main program to have an access to your mocule also Calling my module for the "basic-check" of module which will be further "implimanted" in mesh-generation program  

implicit none

!> This implicit none statement forces the programmer to declare all the variables which is considered as a good style . 


        integer ::i,N
!> i is the integer value it can take value from 1 to ...n
                character(len=20) :: filepuntos
!> filepuntos is the name of file containing the values of points 

                        real,allocatable::x(:)
!> x is the coordinates
                        real,allocatable::y(:)
!> y is  the coordinates
                        real,allocatable::y2(:)
!> y2 is the  coordinates


  
                                real,allocatable :: d(:), c(:), alfa(:), b(:)
!> b,c,d and alfa are the four points which basically we will see in the main program of mesh generation



call read_file (filepuntos,x,y,y2,N)

!> This is the permissiom given to the module to call the subroutine into the module and module can be accessed from main program

filepuntos= "puntosmalla.dat"
!> puntosmalla.dat is a set of .datpoints which is generated from in a file so named as filepuntos

print*, 'x'
print*, 'y'
print*, 'y2'


!> This is the permission given to the code to print "x"
!> This is the permission given to the code to print "y"
!> This is the permission given to the code to print "y2"


end program read

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> Compile using  gfortran read.f90 -o read.exe  


!>To integrate the module with the main program then to check wheather module is working perfect or not  
 
!>Compile using       gfortran read.f90 read_file.o -o read.exe  
!>Run using   ./read.exe  



