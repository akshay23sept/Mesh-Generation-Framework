program read

use read_file_module

implicit none

integer ::N,i,counter,poli
character(len=50)::filepuntos
real,allocatable::x(:), y(:), y2(:) 
real,allocatable :: d(:), c(:), alfa(:), b(:)


filepuntos='puntosmalla.dat'
call read_file (filepuntos)


print*, 'x','y','y2'

end program read



