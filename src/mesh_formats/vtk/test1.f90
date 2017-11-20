program main

  implicit none

  call timestamp ( )
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'VTK_IO_PRB'
  write ( *, '(a)' ) '  FORTRAN90 version'
  write ( *, '(a)' ) '  Test the VTK_IO library.'

  call test01 ( )
!
!  Terminate.
!
  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'VTK_IO_PRB'
  write ( *, '(a)' ) '  Normal end of execution.'
  write ( *, '(a)' ) ' '
  call timestamp ( )

  stop
end
subroutine test01 ( )

  implicit none

  integer ( kind = 4 ), parameter :: element_num = 6
  integer ( kind = 4 ), parameter :: element_order = 8
  integer ( kind = 4 ), parameter :: node_num = 24

  integer ( kind = 4 ) :: element_node(element_order,element_num) = reshape ( &
    (/ &
      1,  2,  5,  6, 13, 14, 17, 18, &
      2,  3,  6,  7, 14, 15, 18, 19, &
      3,  4,  7,  8, 15, 16, 19, 20, &
      5,  6,  9, 10, 17, 18, 21, 22, &
      6,  7, 10, 11, 18, 19, 22, 23, &
      7,  8, 11, 12, 19, 20, 23, 24  &
    /), (/ element_order, element_num /) )
  integer ( kind = 4 ) i
  integer ( kind = 4 ) j
  integer ( kind = 4 ) k
  integer ( kind = 4 ) node
  character ( len = 80 ) output_filename
  integer ( kind = 4 ) output_unit
  real ( kind = 8 ) p(node_num)
  character ( len = 80 ) title
  real ( kind = 8 ) uvw(3,node_num)
  real ( kind = 8 ) x
  real ( kind = 8 ) xyz(3,node_num)
  real ( kind = 8 ) y
  real ( kind = 8 ) z

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) 'TEST01'
  write ( *, '(a)' ) '  VTK_PUVW_WRITE writes 3d fluid data, pressure and '
  write ( *, '(a)' ) '  velocity, to a VTK file.'

  output_filename = 'puvw_data.vtk'
  title = 'Sample data for VTK_PUVW_WRITE.'

  node = 0
  do k = 1, 2
    z = real ( k - 1, kind = 8 )
    do j = 1, 3
      y = real ( j - 1, kind = 8 )
      do i = 1, 4
        x = real ( i - 1, kind = 8 )
        node = node + 1
        xyz(1:3,node) = (/ x, y, z /)
        p(node_num) = 10.0D+00 * x
        uvw(1,node_num) = 2.0D+00 * x
        uvw(2,node_num) = 3.0D+00 * y
        uvw(3,node_num) = 4.0D+00 * z
      end do
    end do
  end do

  call get_unit ( output_unit )

  open ( unit = output_unit, file = output_filename, status = 'replace' )

  call vtk_puvw_write ( output_unit, title, node_num, element_num, &
    element_order, xyz, element_node, p, uvw )

  close (  unit = output_unit )

  write ( *, '(a)' ) ' '
  write ( *, '(a)' ) '  VTK_PUVW_WRITE created the file.'

  return
end


subroutine vtk_puvw_write ( output_unit, title, node_num, element_num, &
  element_order, xyz, element_node, p, uvw )

 implicit none

  integer ( kind = 4 ) element_num
  integer ( kind = 4 ) element_order
  integer ( kind = 4 ) node_num

  character ( len = 20 ) cell_size_string
  integer ( kind = 4 ) element
  integer ( kind = 4 ) element_node(element_order,element_num)
  character ( len = 20 ) element_num_string
  integer ( kind = 4 ) node
  character ( len = 20 ) node_num_string
  integer ( kind = 4 ) output_unit
  real ( kind = 8 ) p(node_num)
  character ( len = 20 ) s_node_num
  character ( len = 20 ) s_element_num
  character ( len = * ) title
  real ( kind = 8 ) uvw(3,node_num)
  real ( kind = 8 ) xyz(3,node_num)

  call i4_to_s_left ( node_num, node_num_string )
  call i4_to_s_left ( element_num, element_num_string )
  call i4_to_s_left ( element_num * ( element_order + 1 ), cell_size_string )

  write ( output_unit, '(a)' ) '# vtk DataFile Version 2.0'
  write ( output_unit, '(a)' ) title
  write ( output_unit, '(a)' ) 'ASCII'
  write ( output_unit, '(a)' ) 'DATASET UNSTRUCTURED_GRID'
  write ( output_unit, '(a)' ) 'POINTS ' // trim ( s_node_num ) // ' double'

  do node = 1, node_num
    write ( output_unit, '(2x,g14.6,2x,g14.6,2x,g14.6)' ) xyz(1:3,node)
  end do
  write ( output_unit, '(a)' ) ' '
  write ( output_unit, '(a)' ) 'CELLS ' // trim ( element_num_string ) &
    // ' ' // trim ( cell_size_string )
  do element = 1, element_num
    write ( output_unit, '(2x,i4,10(2x,i4))' ) &
      element_order, element_node(1:element_order,element) - 1
  end do

  write ( output_unit, '(a)' ) ' '
  write ( output_unit, '(a)' ) 'CELL_TYPES ' // trim ( element_num_string )

  if ( element_order == 4 ) then
    do element = 1, element_num
      write ( output_unit, '(a)' ) '10'
    end do
  else if ( element_order == 10 ) then
    do element = 1, element_num
      write ( output_unit, '(a)' ) '24'
    end do
  end if

  write ( output_unit, '(a)' ) ' '
  write ( output_unit, '(a)' ) 'POINT_DATA ' // trim ( node_num_string )
  write ( output_unit, '(a)' ) 'SCALARS pressure double'
  write ( output_unit, '(a)' ) 'LOOKUP_TABLE default'
  do node = 1, node_num
    write ( output_unit, '(2x,g14.6)' ) p(node)
  end do
  write ( output_unit, '(a)' ) 'VECTORS velocity double'
  do node = 1, node_num
    write ( output_unit, '(3(2x,g14.6))' ) uvw(1:3,node)
  end do

  return
end

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
subroutine get_unit ( iunit )


  implicit none

  integer ( kind = 4 ) i
  integer ( kind = 4 ) ios
  integer ( kind = 4 ) iunit
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
subroutine i4_to_s_left ( i4, s )


  implicit none

  character c
  integer ( kind = 4 ) i
  integer ( kind = 4 ) i4
  integer ( kind = 4 ) idig
  integer ( kind = 4 ) ihi
  integer ( kind = 4 ) ilo
  integer ( kind = 4 ) ipos
  integer ( kind = 4 ) ival
  character ( len = * ) s

  s = ' '

  ilo = 1
  ihi = len ( s )

  if ( ihi <= 0 ) then
    return
  end if

  ival = i4

  if ( ival < 0 ) then

    if ( ihi <= 1 ) then
      s(1:1) = '*'
      return
    end if

    ival = -ival
    s(1:1) = '-'
    ilo = 2

  end if

  ipos = ihi

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

  s(ilo:ilo+ihi-ipos-1) = s(ipos+1:ihi)
  s(ilo+ihi-ipos:ihi) = ' '
 
  return
end
subroutine timestamp ( )

  implicit none

  character ( len = 8 ) ampm
  integer ( kind = 4 ) d
  integer ( kind = 4 ) h
  integer ( kind = 4 ) m
  integer ( kind = 4 ) mm
  character ( len = 9 ), parameter, dimension(12) :: month = (/ &
    'January  ', 'February ', 'March    ', 'April    ', &
    'May      ', 'June     ', 'July     ', 'August   ', &
    'September', 'October  ', 'November ', 'December ' /)
  integer ( kind = 4 ) n
  integer ( kind = 4 ) s
  integer ( kind = 4 ) values(8)
  integer ( kind = 4 ) y

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




