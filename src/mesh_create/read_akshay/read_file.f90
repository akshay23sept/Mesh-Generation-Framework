!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> MODULE: read_file_module

!
!> @author
!> Akshay Anand
!
!> DESCRIPTION: 
!> This is a module that read the data from a file and introduce it in the variables. This is a module that read the data from a file and introduce it in the variables    
!---------------------------------------------------------------------
!





module read_file_module

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

   implicit none

contains

   
                               !> Calling a subroutine for reading the data 
        subroutine read_file (filepuntos,x,y,y2,N)
                        integer ::N
                        !>N is number of something
                        integer ::i,counter
                        !> i is counter
                        character(len=20)::filepuntos
                        real,allocatable::x(:), y(:), y2(:) 
        

                        real,allocatable :: d(:), c(:), alfa(:), b(:)

filepuntos ="puntosmalla.dat"
        open(99, file=filepuntos)
        read(99, *) N
        allocate(x(N),y(N), y2(N))



allocate(d(N),c(N), alfa(N), b(N))
counter=0
                do i=1,N
                        read(99, *)  x(i), y(i), y2(i)
                end do
      
   end subroutine read_file

end module read_file_module

!>Compile using  // gfortran -c read_file.f90
