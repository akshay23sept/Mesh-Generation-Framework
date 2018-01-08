module vtk_write 
!>module initialisation
use precision
contains 
!>to define that the module contains the following sub-programs

subroutine vtk_data_write ( output_unit, title, node_num, element_num, &
  element_order, xyz, element_node, p, uvw)
!>DAT_DATA_WRITE writes pressure and velocity data to a .DAT file.

 implicit none

  integer ( ik ):: element_num 
  !>number of elements
  integer ( ik ):: element_order 
  !>order of the elements
  integer ( ik ):: node_num
  !>number of nodes
  character ( len = 20 ):: cell_size_string
  integer ( ik ) ::element
  integer ( ik ):: element_node(element_order,element_num)
  !>the nodes that make up each element
  character ( len = 20 ):: element_num_string
  integer ( ik ) ::node
  character ( len = 20 ):: node_num_string
  integer ( ik ) ::output_unit 
  !>the unit number of each file
  real ( rk ):: p(node_num)
  character ( len = 20 ):: s_node_num
  character ( len = 20 ) ::s_element_num
  real ( rk ):: uvw(3,node_num) 
  !>the velocity at each nodes
  real ( rk ) :: xyz(3,node_num)
  !>node coordinates

  integer (ik)::i,cell,j
  real (rk) :: xcoordinates(element_order),ycoordinates(element_num)

  character(len=80) :: myFileName,title
  character(len=30) :: myFormat

  cell=(element_num-1)*(element_order-1)

  do i=1,element_order
  xcoordinates(i)=xyz(1,i*element_num)
  end do

  do j=1,element_num
  ycoordinates(j)=xyz(2,j)
  end do

  myFileName='vtkoutput.vtk'!name of the outputs file generated

 open(90,file=myFileName) !to write the output file
 write(90,"(A26)")'# vtk DataFile Version 3.0'  
 write (90,"(A9)")title
 write (90,"(A5)")'ASCII'
 write (90,"(A24)")'DATASET RECTILINEAR_GRID'
 write(90,"(A11,I2.1,A1,I2.1,A1,I1.1)")'DIMENSIONS ',element_order,' ',element_num,' ',1
 write(90,"(A14,I2.1,A6)")'X_COORDINATES ',element_order,' float'
 write (90,"(F18.15)")xcoordinates
 write(90,"(A14,I2.1,A6)")'Y_COORDINATES ', element_num,' float'
 write (90,"(F18.15)")ycoordinates
 write(90,"(A21)")'Z_COORDINATES 1 float'
 write (90,"(I1.1)")0

 close(90)

end subroutine

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine digit_to_ch ( digit, ch )
!> DIGIT_TO_CH returns the character representation of a decimal digit.

  implicit none

  character ch
!>character CH, the corresponding character.
  integer ( ik ) digit
!>DIGIT, the digit value between 0 and 9.

  if ( 0 <= digit .and. digit <= 9 ) then

    ch = achar ( digit + 48 )

  else

    ch = '*'

  end if
 
  return
end
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine get_unit ( iunit )
!>    A "free" FORTRAN unit number is an integer between 1 and 99 which
!>    is not currently associated with an I/O device.  A free FORTRAN unit
!>    number is needed in order to open a file with the OPEN command.
!>    If IUNIT = 0, then no free FORTRAN unit could be found, although
!>    all 99 units were checked (except for units 5, 6 and 9, which
!>    are commonly reserved for console I/O).
!>    Otherwise, IUNIT is an integer between 1 and 99, representing a
!>    free FORTRAN unit.  Note that GET_UNIT assumes that units 5 and 6
!>    are special, and will never return those values.

  implicit none

  integer ( ik ) i
  integer ( ik ) ios
  integer ( ik ) iunit
!> IUNIT, the free unit number.
  logical lopen

  iunit = 0

  do i = 1, 99

    if ( i /= 5 .and. i /= 6 .and. i /= 9 ) then

      inquire ( unit = i, opened = lopen, iostat = ios )

      if ( ios == 0 ) then
        if ( .not. lopen ) then
          iunit = i
          return
        end if
      end if

    end if

  end do

  return
end
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
subroutine i4_to_s_left ( i4, s )
!> I4_TO_S_LEFT converts an I4 to a left-justified string.

  implicit none

  character c
  integer ( ik ) i
  integer ( ik ) i4
!>i4 is an integer to be converted.
  integer ( ik ) idig
  integer ( ik ) ihi
  integer ( ik ) ilo
  integer ( ik ) ipos
  integer ( ik ) ival
  character ( len = * ) s

  s = ' '

  ilo = 1
  ihi = len ( s )

  if ( ihi <= 0 ) then
    return
  end if
!>Make a copy of the integer.
  ival = i4
!>Handle the negative sign.
  if ( ival < 0 ) then

    if ( ihi <= 1 ) then
      s(1:1) = '*'
      return
    end if

    ival = -ival
    s(1:1) = '-'
    ilo = 2

  end if
!>The absolute value of the integer goes into S(ILO:IHI).
  ipos = ihi
!>Find the last digit of IVAL, strip it off, and stick it into the string.
  do

    idig = mod ( ival, 10 )
    ival = ival / 10

    if ( ipos < ilo ) then
      do i = 1, ihi
        s(i:i) = '*'
      end do
      return
    end if

    call digit_to_ch ( idig, c )

    s(ipos:ipos) = c
    ipos = ipos - 1

    if ( ival == 0 ) then
      exit
    end if

  end do
!>Shift the string to the left.
  s(ilo:ilo+ihi-ipos-1) = s(ipos+1:ihi)
  s(ilo+ihi-ipos:ihi) = ' '
 
  return
end
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
subroutine timestamp ( )
!> TIMESTAMP prints the current YMDHMS date as a time stamp
  implicit none

  character ( len = 8 ) ampm
  integer ( ik ) d
  integer ( ik ) h
  integer ( ik ) m
  integer ( ik ) mm
  character ( len = 9 ), parameter, dimension(12) :: month = (/ &
    'January  ', 'February ', 'March    ', 'April    ', &
    'May      ', 'June     ', 'July     ', 'August   ', &
    'September', 'October  ', 'November ', 'December ' /)
  integer ( ik ) n
  integer ( ik ) s
  integer ( ik ) values(8)
  integer ( ik ) y

  call date_and_time ( values = values )

  y = values(1)
  m = values(2)
  d = values(3)
  h = values(5)
  n = values(6)
  s = values(7)
  mm = values(8)

  if ( h < 12 ) then
    ampm = 'AM'
  else if ( h == 12 ) then
    if ( n == 0 .and. s == 0 ) then
      ampm = 'Noon'
    else
      ampm = 'PM'
    end if
  else
    h = h - 12
    if ( h < 12 ) then
      ampm = 'PM'
    else if ( h == 12 ) then
      if ( n == 0 .and. s == 0 ) then
        ampm = 'Midnight'
      else
        ampm = 'AM'
      end if
    end if
  end if

  write ( *, '(i2,1x,a,1x,i4,2x,i2,a1,i2.2,a1,i2.2,a1,i3.3,1x,a)' ) &
    d, trim ( month(m) ), y, h, ':', n, ':', s, '.', mm, trim ( ampm )

  return
end
end module
