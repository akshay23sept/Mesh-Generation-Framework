subroutine digit_to_ch ( digit, ch )

  implicit none

  character ch
  integer ( kind = 4 ) digit

  if ( 0 <= digit .and. digit <= 9 ) then

    ch = achar ( digit + 48 )

  else

    ch = '*'

  end if
 
  return
end
