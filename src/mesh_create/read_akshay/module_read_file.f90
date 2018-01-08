!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> MODULE: read_file_module

!
!> @author
!> Akshay
!
! DESCRIPTION: 
!> This is a module that read the data from a file and introduce it in the variables  
!---------------------------------------------------------------------
!





module read_file_module

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!> This is a module that read the data from a file and introduce it in the variables  !

   implicit none

!> This implicit none statement forces the programmer to declare all the variables which is considered as a good style . 

contains

   

        subroutine read_file (filepuntos,x,y,y2,N)

        use precision

!>x,y and y2 are the co-ordinates ,filepuntos is a file that will read the data from a file and introduce it into a variable.

                    integer ::N
                                !> N is the in integer 

                    integer :: i

                                !> i is an integer it can take value from 1 ......N 

                   integer :: counter
                                !>counter in this code is always fixed as 0

        character(len=20)::filepuntos

!>filepuntos is the name of file in the data of set of points are stored 

      real,allocatable:: x(:)
                              !> x is the coordinates

        real,allocatable:: y(:)
                                !> y is the coordinates

            real,allocatable:: y2(:) 
                                       !> and y2 is also the coordinates
        

                        real,allocatable :: d(:), c(:), alfa(:), b(:)
 !> b,c,d and alfa are the four points which basically we will see in the main program of mesh generation

filepuntos ="puntosmalla.dat"
 !> puntosmalla.dat is a set of .datpoints which is generated from in a file so named as filepuntos

open(99, file=filepuntos)
!> This enable the file to be capable of opening.

read(99, *) N
!> This enable the file to be read from the value insertred by the user

allocate(x(N))
!> This will enable us to allocate the value of x in an array or in other words the values will be stored in a row

allocate(y(N))

!> This will enable us to allocate the value of y in an array or in other words the values will be stored in a row

allocate( y2(N))
!> This will enable us to allocate the value of y2 in an array or in other words the values will be stored in a row

allocate(d(N))
!>This will enable us to allocate the value of d in an array or in other words the values will be stored in a row

allocate(c(N))
!>This will enable us to allocate the value of c in an array or in other words the values will be stored in a row

allocate (alfa(N))
!>This will enable us to allocate the value of alfa in an array or in other words the values will be stored in a row

allocate ( b(N))
!>This will enable us to allocate the value of b in an array or in other words the values will be stored in a row


counter=0
                do i=1,N
!> A loop which allows that i can take any value between 1 to N
                        read(99, *) x(i), y(i), y2(i)
                                                        !>  This will read the value of x,y and y2 
                end do

      
   end subroutine read_file
!>This is the closing statemnt for the subroutine & it must be the same that we defined in begining . 

end module read_file_module



!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> Compile using  gfortran -c read_file.f90 


!>To integrate the module with the main program (here for test case) then to check wheather module is working perfect or not  
 
!>Compile using       gfortran test.f90 read_file.o -o read.exe 
 
!>Run using   ./test.exe  
