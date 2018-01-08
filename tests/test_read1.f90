program read

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!>INTRODUCTION

!> This is a simple program to check wheather the module is working in desired manner or not (test for check of my module which is to be utilised in Drashti's code) 

!> @ Author Akshay

use read_file_module

!> This is the permission given to the main program to have an access to your mocule also Calling my module for the "basic-check" of module which will be further "implimanted" in mesh-generation program  

implicit none

!> This implicit none statement forces the programmer to declare all the variables which is considered as a good style . 


  integer ::N
                                !> N is the  number of points in vertical axis

                        integer :: M
!> M is an the number of points in horizontal axis  

                    integer :: j

                                !> j is an integer it can take value from 1 ......4 


                character(len=20) :: filepoints

!> filepuntos is the name of file containing the values of points 

                        real,allocatable::x(:)
!> x is the coordinates
                        real,allocatable::y(:)
!> y is  the coordinates



  
                              
        call read_file (filepoints,x,y)

!> This is the permissiom given to the module to call the subroutine into the module and module can be accessed from main program

filepoints= "input_points.dat"
!> input_points.dat is a set of .datpoints which is generated from in a file so named as filepuntos

print*, 'x'
!> This is the permission given to the code to print "x"
print*, 'y'
!> This is the permission given to the code to print "y"






end program read
!>end of main program.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> Compile using  gfortran test1.f90 -o read.exe  


!>To integrate the module with the main program then to check wheather module is working perfect or not  
 
!>Compile using       gfortran test1.f90 read_file.o -o read.exe  
!>Run using   ./read.exe  



