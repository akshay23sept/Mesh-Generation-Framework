module mesh
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
!>Module : Mesh Generation

!>Description

!> @ Author Alvaro 

!> @ Co-author & Documentation Akshay

!> This is a module  to for mesh generation and it was use three modules to perform its working completly

use newtonmod
!> This is the permission given to the main program to have an access to your module and this module basically deals with the local stretching.
use precision

use read_file_module
!> This is a module that read the data from a file and introduce it in the variables.

implicit none
!> This implicit none statement forces the programmer to declare all the variables which is considered as a good style . 

contains 

subroutine raw_mesh ()

real::smallalfa, dalfa, L, xinicio, xfin, factor
integer::N,  M,  k, dx, decision, dimxnuevo, inicio, fin

!> N amd M are integers
!> also N is number of point in  x
!>also M is number of point in   Y

integer :: i,counter
!>i and counter are also defined as integers
integer :: j ,t
!> j and t are defines as integers
integer :: param,poli
!>these are the function used in the main program and defined as integers


character(len=50)::filepuntos
!>filepuntos is a file that will read the data from a file and introduce it into a variable.

                real,allocatable::x(:)
!> represents the value of x in the program and also it allocates it in a row/line
real,allocatable::y(:)
!> represents the value of y in the program and also it allocates it in a row/line
real,allocatable::y2(:)
!> represents the value of y2 in the program and also it allocates it in a row/line
real,allocatable::xbig(:)
!> represents the value of xbig in the program and also it allocates it in a row/line
real,allocatable::ybig(:)
!> represents the value of ybig in the program and also it allocates it in a row/line
real,allocatable::zbig(:)
!> represents the value of zbig in the program and also it allocates it in a row/line
real,allocatable::d(:)
!> represents the value of d in the program and also it allocates it in a row/line
real,allocatable::c(:)
!> represents the value of c in the program and also it allocates it in a row/line
real,allocatable::alfa(:)
!> represents the value of alfa in the program and also it allocates it in a row/line
real,allocatable::b(:)
!> represents the value of b in the program and also it allocates it in a row/line
real,allocatable:: xnuevo(:)
!> represents the value of b in the program and also it allocates it in a row/line
real,allocatable:: ynuevo(:)
!> represents the value of b in the program and also it allocates it in a row/line
real,allocatable:: y2nuevo(:)
!> represents the value of b in the program and also it allocates it in a row/line
real, allocatable :: xtotal(:)
!> represents the value of xtotal in the program and also it allocates it in a row/line
real, allocatable :: ytotal(:)
!> represents the value of ytotal in the program and also it allocates it in a row/line

real, allocatable :: y2total(:)
!> represents the value of y2total in the program and also it allocates it in a row/line

real, allocatable:: z1(:)
!> represents the value of z1 in the program and also it allocates it in a row/line
real, allocatable:: z2(:)
!> represents the value of z2 in the program and also it allocates it in a row/line
real, allocatable:: z3(:) 
!> represents the value of z3 in the program and also it allocates it in a row/line
real, allocatable:: z4(:)  
!> represents the value of z4 in the program and also it allocates it in a row/line 

character(len=20) :: nameprogr

type vector
!>The real power of derived types comes with the ability to choose between functions(or subroutines) based on type of their arguements
                        real, allocatable, dimension(:)::xbig
!>!We define the array vector to introduce in it thr result of the mesh generating, before writing it in a file and store in an array so called x big

                        real, allocatable, dimension(:)::ybig
!>We define the array vector to introduce in it thr result of the mesh generating, before writing it in a file and store it in another array called ybig

                        real, allocatable, dimension(:)::zbig
!>We define the array vector to introduce in it thr result of the mesh generating, before writing it in a file and store it in another array so called zbig


 end type vector

type(vector):: global
!>!>The real power of derived types comes with the ability to choose between functions(or subroutines) based on type of their arguements

                print*, 'Introduce the numbers of  points do you want in the vertical discretization ?'
!> Ask the user thet how many points you wants in vertical discritisation 
        read*, M
!> M is the number of point in y




  !>Calling of the subroutine to be integrated with main program,this will read the data provided by  user

!We call to the read_file subroutine to introduce in out variable the data given by the user in a file.

call read_file(filepuntos,x,y,y2,N)
 !> This is the permissiom given to the module to call the subroutine into the module and module can be accessed from main program


print*, 'Your x, y, and y2 co-ordinates are:'
!> this will print the value of x, y and y2 for the number of discritisation points that the user gives

!> A simple loop which shows that i can take any values from 1 to N 
        do i=1, N
                print*, x(i), y(i), y2(i)
!> this will print the value of x, y and y2
        end do
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!                                                       Local streching:
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!local streching: as the distribution of points in 'x' direction is given by the file of the user, we give him the oportunity of increasing the number of points in a range between two points that the user choose. 
print*, 'do you want to do any local streching in a longitude interval? write 1 for yes or 2 for no'
!> This allow user to input either they want local stretching or not
!=======
!>We call the read_file subroutine to introduce in out variable the data given by the user in a file.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
read*, decision
!> This will read the decision input by user either it is 1 or 2
if (decision==1) then
!> If its 1 value goes from x(1) to x(N )
print*, 'your interval goes from ', x(1), 'to', x(N), '. Write the two values of the' 
print*, 'interval you want to make a local streching. First value:'
!> This will ask the user to enter the first point where u want local stretching
read*, xinicio
print*, 'Second value:'
!> This will ask the user to enter the second point where u want local stretching
read*, xfin
!> xfin will read the first point inserted by the user for the local stretching
elseif (decision==2) then 
!> This indicates if user does not wants strecthing then press 2
else
print*, 'wrong number, come on, it is not so difficult'
stop
end if


!To create a local streching, the user can increase the number of points in the selected interval by a factor proportional to the number of points that exist in that interval.
if (decision==1) then
!> This enable user to enter the factor by which they wants local stretching
print*, 'Introduce a factor to increase the number of points in this inteval, proportional to the amount of points of your curve'
!> ask the user to insert the factor
read*, factor
!> read the factor inserted by the user

!I round off the points that the user gives to the closest without losing part of the interval (the left next one of the first and the right nex one of the second)
!>A  simple loop to show how the increment function is going to work
do j=1,2
do i=1,N
if (j==1) then
 if (x(i)>xinicio) then
!> if x(i) is greater then (xinicio) then the first value of stretching point is equal to i-1
 if (i>1) then
 inicio=i-1
!>represents second value is equal to i-1
 exit
 else
 inicio=i
 exit
 end if
 else
 end if
                         
else
 if (x(i)>(xfin-0.001)) then
!> if x(i) is greater then (xfin-0.001) then the second value of stretching point is equal to i
 fin=i
!> represents second value is equal to i
 exit
 else
 end if
 end if
end do
end do
xinicio=x(inicio)
!> represents xinicio is equal to  x of inicio
xfin=x(fin)
!> represents xinicio is equal to  x of inicio

!print*, 'inicio es', inicio, 'y fin es', fin, 'y factor es', factor

               print*, 'inicio es', inicio
!> prints inicio es as inicio
                print*, 'y fin es', fin
!> prints y fin as fin
                print*, 'y factor es', factor
!> prints y factor es as factor

dimxnuevo = int(factor*(fin-inicio-1))
!> represents dimxnuevo can be roughly estimated as int(factor*(fin-inicio-1))
print*, 'dimxnuevo es', dimxnuevo
!> prints the value of dimxnuevo is, dimxnuevo


!Newton

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!>call of another subroutine to be integrated with main program
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!To obtain points in the interval selected, it is neccesary to aproximate the curves given by points with a Newton polynomial.

call newton(x, y, y2, N, inicio, fin, xinicio, xfin, xnuevo, ynuevo, y2nuevo, dimxnuevo)
!> This is the permissiom given to the module to call the subroutine into the module and module can be accessed from main program
print*, 'el vector xnuevo es y su dimension', size(xnuevo)
do i=1,dimxnuevo
print*, xnuevo(i), ynuevo(i)
end do

!If the user wants to make a local streching, it is neccesary to redefine the dimension of the variables, as follows:
allocate (xtotal(inicio-1+dimxnuevo+(N-fin+1)), ytotal(inicio-1+dimxnuevo+(N-fin+1)), y2total(inicio-1+dimxnuevo+(N-fin+1)))
print*, 'la dimension de xtotal es', size(xtotal)

!Now with the new points obtained with the Newton polynomial and the previous ones, we need to rebuild the vectors with the points as follow:
counter=1
                do i=1,inicio-1
                                xtotal(counter)=x(i)
                                ytotal(counter)=y(i)
                                y2total(counter)=y2(i)
                                counter=counter+1


                end do


                        do i=1,dimxnuevo
                                xtotal(counter)=xnuevo(i)
                                ytotal(counter)=ynuevo(i)
                                y2total(counter)=y2nuevo(i)
                                counter=counter+1
                        end do


                        do i=1,(N-fin+1)
                                xtotal(counter)=x(fin-1+i)
                                ytotal(counter)=y(fin-1+i)
                                y2total(counter)=y2(fin-1+i)
                                counter=counter+1
                        end do



!We plot the new vectors of points.


print*, 'the dimension of your new vector is', counter-1, 'and your new vector is:'
print*, '_____x_________________y1________________y2______________coordenate'


do i=1, counter-1

print*, xtotal(i)
print*, ytotal(i)
print*, y2total(i)
print*, i
end do

!As the size of the vectors has changed, we also need to redefine the size of the array that we defined at the beginning.
N=size(xtotal)
deallocate(xbig, ybig, global%xbig, global%ybig, global%zbig)
allocate(xbig(N*M), ybig(N*M), global%xbig(N*M), global%ybig(N*M), global%zbig(N*M))
else
end if


!The next 30 lines are going to call to the subroutine that the user chooses, to generate the vertical mesh.  reading an integer number from the screen. The possible distribution of points are: Chebyshev distribution, arcsen distribution, hyperbolic tangent distribution or linear one.
print*, 'for the global stretching (vertically),'
print*, 'introduce the value 1 for a Chevyshchev distribution, 2 for an arcsen distribution,'
print*, '3 for a tanh distribution, or 4 for a linear distribution'
read*, param
if (param==1) then
 if (decision==1) then

!> Calling the subroutine chevy for the distribution of points
call chevy(xbig, ybig, zbig, xtotal, ytotal, y2total, M, N)
else
!> Calling the subroutine chevy for the distribution of points
call chevy(xbig, ybig, zbig, x, y, y2, M, N)
end if
elseif (param==2) then
if (decision==1) then

!>Calling of subroutine for arcsen disribution
call arcsen(xbig, ybig, zbig, xtotal, ytotal, y2total, M, N)
else
!> Calling the subroutine arcsen for the distribution of points
call arcsen(xbig, ybig, zbig, x, y, y2, M, N)
end if
elseif (param==3) then
if (decision==1) then

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!>Calling of subroutine for tanhip distribution
call tanhip(xbig, ybig, zbig, xtotal, ytotal, y2total, M, N)
else
!> Calling the subroutine tanhip for the distribution of points
call tanhip(xbig, ybig, zbig, x, y, y2, M, N)
end if
elseif (param==4) then
if (decision==1) then
!> Calling the subroutine linear for the distribution of points
call linear(xbig, ybig, zbig, xtotal, ytotal, y2total, M, N)
else
!> Calling the subroutine linear for the distribution of points
call linear(xbig, ybig, zbig, x, y, y2, M, N)
end if
else
print*, 'wrong number, come on, it is not so difficult'
stop
end if

!We introduce the results in the array:
global%xbig=xbig
!> introduction of final result in an array xbig
global%ybig=ybig
!> introduction of final result in an array ybig
global%zbig=zbig
!> introduction of final result in an array zbig


!We define 4 variables, full of '0', that will be necessary in the data analysis.

!allocate (z1(N*M), z2(N*M), z3(N*M), z4(N*M))
allocate (z1(N*M))
!> the variable Z1 contain the value 0
 allocate (z2(N*M))
!> the variable Z2 contain the value 0
 allocate (z3(N*M))
!> the variable Z3 contain the value 0
  allocate (z4(N*M))
!> the variable Z4 contain the value 0
z1=0
z2=0
z3=0
z4=0

!This is the file where we write the results of the mesh creating.
 write (nameprogr,*) 'pointlist.dat'
 open(1,file=nameprogr) 

write(1,*) N*M
write(1,*) N
write(1,*) M

!We print the result in the screen, and we write it in a file so that we can countinue the data treatment with it.
 t=0
print*, 'the final result is:'
!> the finnal results are ... ,..., ..., ..., x ----,y ----,z ----
print*, '_____coordenate____x_________________y________________z_________'

   do j=1,N
!> A simple do loop which shows i can take value from 1 to N
                do i=1,M
!> A simple do loop which shows i can take value from 1 to M
        t=t+1
               



print*,t
!> prints the value of t
print*, global%xbig(t)
!> prints the value of t
print*,global%ybig(t)
!> prints the value of t
print*,global%zbig(t)
!> prints the value of t



write(1,*) global%xbig(t)
write(1,*) global%ybig(t)
write(1,*) global%zbig(t)
write(1,*) z1(t)
write(1,*) z2(t)
write(1,*) z3(t)
write(1,*) z4(t)
end do 
end do

 close(1)

end subroutine
!> end of subroutine

end module
!>end of module

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> Compile using  gfortran -c module_precision.f90
!>gfortran -c module_newton.f90  
!>gfortran -c module_read_file.f90 
!>gfortran -c module_mesh.f90

