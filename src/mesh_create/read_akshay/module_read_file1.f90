module read_file1_module

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!>MODULE: read_file_module


!> @AUTHOR
!> Akshay




!> DESCRIPTION

!> This is a module that read the data from a file and introduce it in the variables  ! (This module will integrate with Drashti's code of rectangular mesh generation)

!>  Author @ Akshay

   implicit none

!> This implicit none statement forces the programmer to declare all the variables which is considered as a good style . 

contains

   

        subroutine read_file (filepoints,x,y,N,M)


        use precision

!>x and y are the co-ordinates ,filepoints is a file that will read the data from a file and introduce it into a variable.

                    integer ::N
                                !> N is the  number of points in vertical axis

                        integer :: M
!> M is an the number of points in horizontal axis  

                    integer :: j

                                !> j is an integer it can take value from 1 ......4 

                   

        character(len=20):: filepoints

!>filepuntos is the name of file in the data of set of points are stored 

      real,allocatable:: x(:)
                              !> x is the coordinates in horozontal axis

        real,allocatable:: y(:)
                                !> y is the coordinates in vertical axis

            
        

                        

        filepoints ="input_points.dat"
!>input_points.dat is a set of .datpoints which is generated from in a file so named as filepuntos

        open(99, file=filepoints)
!> This enable the file to be capable of opening.

        allocate(x(4))
!> This will enable us to allocate the value of x in an array where x is the coordinates in horizontal axis.

        allocate(y(4))
!> This will enable us to allocate the value of y in an array where y is the coordinates in vertical axis.
 

!> A loop which allows that i can take any value between 1 to 4 as there are 4 points in a rectangle.

 do j=1,4

 read (99, *)  x(j) , y(j)

!>  This will read the value of x and y
 end do

read(99,*) M
!> This enable the file to be read the number of points in horizontal axis.

read(99,*) N
!> This enable the file to be read the number of points in vertical axis.

 


      
   end subroutine read_file
!>This is the closing statemnt for the subroutine & it must be the same that we defined in begining . 

end module read_file1_module
!> end of the module.


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> Compile using  gfortran -c read_file1.f90 


!>To integrate the module with the main program(here for test case) then to check wheather module is working perfect or not  
 
!>Compile using       gfortran test1.f90 read_file1.o -o read.exe 
 
!>Run using   ./test1.exe  

