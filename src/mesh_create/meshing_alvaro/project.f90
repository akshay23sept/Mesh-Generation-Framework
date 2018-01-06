!---------------------------------------------------------------------
! Mesh Generation Framework                    
!---------------------------------------------------------------------
!
!> PROGRAM: mesh
!
!> @author
!> Alvaro & Akshay
!
! DESCRIPTION: 
!> This program creates mesh 
!
!---------------------------------------------------------------------
!



program mesh

use newtonmod

use read_file_module
implicit none
real::smallalfa, dalfa, L, xinicio, xfin, factor
integer::N, i, M, counter, j, param, poli, k, dx, decision, dimxnuevo, inicio, fin, t
character(len=50)::filepuntos
real,allocatable::x(:), y(:), y2(:) , xbig(:), ybig(:), zbig(:), d(:), c(:), alfa(:), b(:)
real,allocatable:: xnuevo(:), ynuevo(:), y2nuevo(:), xtotal(:), ytotal(:), y2total(:)
real, allocatable:: z1(:), z2(:), z3(:), z4(:)
character(len=20) :: nameprogr

!We define the array vector to introduce in it thr result of the mesh generating, before writing it in a file.
type vector
 real, allocatable, dimension(:)::xbig
  real, allocatable, dimension(:)::ybig
  real, allocatable, dimension(:)::zbig
 end type vector
  type(vector):: global
print*, 'introduce how many points do you want in the vertical discretization'
read*, M


!N is the number of points in X axis
!M is the number of points in y axis

!We call to the read_file subroutine to introduce in out variable the data given by the user in a file.
call read_file(filepuntos,x,y,y2,N)
allocate(xbig(N*M), ybig(N*M), global%xbig(N*M), global%ybig(N*M), global%zbig(N*M))

!We print the read points in the screen
print*, 'your x, y, and y2 coordenates are:'
do i=1, N
print*, x(i), y(i), y2(i)
end do

!local streching: as the distribution of points in 'x' direction is given by the file of the user, we give him the oportunity of increasing the number of points in a range between two points that the user choose. 
print*, 'do you want to do any local streching in a longitude interval? write 1 for yes or 2 for no'
read*, decision
if (decision==1) then
print*, 'your interval goes from ', x(1), 'to', x(N), '. Write the two values of the' 
print*, 'interval you want to make a local streching. First value:'
read*, xinicio
print*, 'Second value:'
read*, xfin
elseif (decision==2) then 
else
print*, 'wrong number, come on, it is not so difficult'
stop
end if


!To create a local streching, the user can increase the number of points in the selected interval by a factor proportional to the number of points that exist in that interval.
if (decision==1) then
print*, 'Introduce a factor to increase the number of points in this inteval, proportional to the amount of points of your curve'
read*, factor

!I round off the points that the user gives to the closest without losing part of the interval (the left next one of the first and the right nex one of the second)
do j=1,2
do i=1,N
if (j==1) then
 if (x(i)>xinicio) then
 if (i>1) then
 inicio=i-1
 exit
 else
 inicio=i
 exit
 end if
 else
 end if
else
 if (x(i)>(xfin-0.001)) then
 fin=i
 exit
 else
 end if
 end if
end do
end do
xinicio=x(inicio)
xfin=x(fin)
print*, 'inicio es', inicio, 'y fin es', fin, 'y factor es', factor
dimxnuevo = int(factor*(fin-inicio-1))
print*, 'dimxnuevo es', dimxnuevo

!To obtain points in the interval selected, it is neccesary to aproximate the curves given by points with a Newton polynomial.
call newton(x, y, y2, N, inicio, fin, xinicio, xfin, xnuevo, ynuevo, y2nuevo, dimxnuevo)
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
print*, xtotal(i), ytotal(i), y2total(i), i
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
call chevy(xbig, ybig, zbig, xtotal, ytotal, y2total, M, N)
else
call chevy(xbig, ybig, zbig, x, y, y2, M, N)
end if
elseif (param==2) then
if (decision==1) then
call arcsen(xbig, ybig, zbig, xtotal, ytotal, y2total, M, N)
else
call arcsen(xbig, ybig, zbig, x, y, y2, M, N)
end if
elseif (param==3) then
if (decision==1) then
call tanhip(xbig, ybig, zbig, xtotal, ytotal, y2total, M, N)
else
call tanhip(xbig, ybig, zbig, x, y, y2, M, N)
end if
elseif (param==4) then
if (decision==1) then
call linear(xbig, ybig, zbig, xtotal, ytotal, y2total, M, N)
else
call linear(xbig, ybig, zbig, x, y, y2, M, N)
end if
else
print*, 'wrong number, come on, it is not so difficult'
stop
end if

!We introduce the results in the array:
global%xbig=xbig
global%ybig=ybig
global%zbig=zbig

!We define 4 variables, full of '0', that will be necessary in the data analysis.
allocate (z1(N*M), z2(N*M), z3(N*M), z4(N*M))
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
print*, '_____coordenate____x_________________y________________z_________'
do j=1,N
do i=1,M
 t=t+1
print*, t, global%xbig(t), global%ybig(t), global%zbig(t)
write(1,*) t, global%xbig(t), global%ybig(t), global%zbig(t), z1(t), z2(t), z3(t), z4(t)
end do 
end do

 close(1)



end program

