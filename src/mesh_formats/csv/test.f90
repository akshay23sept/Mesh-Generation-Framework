program test
use csv_write
use csv_read
use precision
 implicit none

!>This main program creates csv format files

  call timestamp ( ) !>Calling the time stamp subroutine
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'dat_IO_PRB'
  write ( *, '(a)' ) '  FORTRAN90 version'
  write ( *, '(a)' ) '  Test the VTK_IO library.'
	
  call test01 ( ) !>Calling the subroutine that writes pressure and velocity for 3D fluid flow calculation
!
!  Terminate.
!
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'dat_IO_PRB'
  write ( *, '(a)' ) '  Normal end of execution.'
  write ( *, '(a)' ) ' '
  call timestamp ( ) !timestamp to mention the time of execution

  stop
end program test
