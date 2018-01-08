program astest
use ratio                                  ! ratio is the aspect ratio module 
implicit none

real(8):: maxi_as !, as
call test1 (maxi_as)

print*, 'the maximum aspect ratio=', maxi_as            ! the maximum as 'Aspect ratio' of one cell of the mesh
!print*, 'aspect ratio=', maxi_as
end program astest




         ! I need to fix the run out error
