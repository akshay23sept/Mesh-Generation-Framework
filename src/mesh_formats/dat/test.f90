program test
use dat_write
use dat_read
use precision
  implicit none

  call timestamp ( ) !>Calling the time stamp subroutine
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'dat_IO_PRB'
  write ( *, '(a)' ) '  FORTRAN90 version'
  write ( *, '(a)' ) '  Test the VTK_IO library.'
	
  call test01 ( )    !>Calling the subroutine that writes pressure and velocity for 3D fluid flow calculation
!
!  Terminate.
!
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'dat_IO_PRB'
  write ( *, '(a)' ) '  Normal end of execution.'
  write ( *, '(a)' ) ' '
  call timestamp ( ) !timestamp to mention the time of execution

  stop
end program
