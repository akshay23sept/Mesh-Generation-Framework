subroutine vtk_puvw_write ( output_unit, title, node_num, element_num, &
  element_order, xyz, element_node, p, uvw)! 

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
