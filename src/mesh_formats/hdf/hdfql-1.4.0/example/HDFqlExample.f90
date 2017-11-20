! Copyright (C) 2016-2017
! This file is part of the Hierarchical Data Format query language (HDFql)
! For more information about HDFql, please visit the website http://www.hdfql.com

! $Rev: 131 $



!===========================================================
! The following program provides an example on how to use HDFql in Fortran. The output of executing it would be similar to this:
!
! HDFql version: 1.4.0
! File in use: example_fortran.h5
! Attribute value: 12.400000
! Variable:
! 1
! 2
! 3
! 4
! 5
! 6
! Cursor:
! 1
! 2
! 3
! 4
! 5
! 6
! Dataset size: 24
!
!===========================================================

PROGRAM HDFqlExample

    ! use HDFql module (make sure it can be found by the Fortran compiler)
    USE HDFql

    ! declare variables
    TYPE(HDFQL_CURSOR) :: my_cursor
    CHARACTER :: string_number
    INTEGER, DIMENSION(3, 2) :: values
    INTEGER :: state
    INTEGER :: x
    INTEGER :: y

    ! display HDFql version in use
    WRITE(*, *) "HDFql version: ", HDFQL_VERSION

    ! create an HDF file named "example_fortran.h5" and use (i.e. open) it
    state = hdfql_execute("CREATE FILE example_fortran.h5" // CHAR(0))
    state = hdfql_execute("USE FILE example_fortran.h5" // CHAR(0))

    ! populate HDFql default cursor with name of the HDF file in use and display it
    state = hdfql_execute("SHOW USE FILE" // CHAR(0))
    state = hdfql_cursor_first()
    WRITE(*, *) "File in use: ", hdfql_cursor_get_char()

    ! create an attribute named "example_attribute" of type float with a value of 12.4
    state = hdfql_execute("CREATE ATTRIBUTE example_attribute AS FLOAT DEFAULT 12.4" // CHAR(0))

    ! select (i.e. read) attribute "example_attribute" and display its value
    state = hdfql_execute("SELECT FROM example_attribute" // CHAR(0))
    state = hdfql_cursor_first()
    WRITE(*, *) "Attribute value: ", hdfql_cursor_get_float()

    ! create a dataset named "example_dataset" of type int of two dimensions (size 3x2)
    state = hdfql_execute("CREATE DATASET example_dataset AS INT(3, 2)" // CHAR(0));

    ! populate variable "values" with certain values
    DO x = 1, 2
        DO y = 1, 3
            values(y, x) = x * 3 + y - 3
        END DO
    END DO

    ! register variable "values" for subsequent use (by HDFql)
    state = hdfql_variable_register(LOC(values))
    WRITE(string_number, "(I0)") state

    ! insert (i.e. write) content of variable "values" into dataset "example_dataset"
    state = hdfql_execute("INSERT INTO example_dataset VALUES FROM MEMORY " // string_number // CHAR(0))

    ! populate variable "values" with zeros (i.e. reset variable)
    DO x = 1, 2
        DO y = 1, 3
            values(y, x) = 0
        END DO
    END DO

	! select (i.e. read) dataset "example_dataset" into variable "values"
    state = hdfql_execute("SELECT FROM example_dataset INTO MEMORY " // string_number // CHAR(0))

    ! unregister variable "values" as it is no longer used/needed (by HDFql)
    state = hdfql_variable_unregister(LOC(values))

    ! display content of variable "values"
    WRITE(*, *) "Variable:"
    DO x = 1, 2
        DO y = 1, 3
            WRITE(*, *) values(y, x)
        END DO
    END DO

    ! another way to select (i.e. read) dataset "example_dataset" using HDFql default cursor
    state = hdfql_execute("SELECT FROM example_dataset" // CHAR(0))

    ! display content of HDFql default cursor
    WRITE(*, *) "Cursor:"
    DO WHILE(hdfql_cursor_next() .EQ. HDFQL_SUCCESS)
        WRITE(*, *) hdfql_cursor_get_int()
    END DO

    ! use cursor "my_cursor"
    state = hdfql_cursor_use(my_cursor)

    ! populate cursor "my_cursor" with size of dataset "example_dataset" and display it
    state = hdfql_execute("SHOW SIZE example_dataset" // CHAR(0))
    state = hdfql_cursor_first()
    WRITE(*, *) "Dataset size: ", hdfql_cursor_get_int()

END PROGRAM

