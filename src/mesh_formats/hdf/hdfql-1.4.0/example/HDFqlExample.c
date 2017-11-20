// Copyright (C) 2016-2017
// This file is part of the Hierarchical Data Format query language (HDFql)
// For more information about HDFql, please visit the website http://www.hdfql.com

// $Rev: 134 $



//===========================================================
// The following program provides an example on how to use HDFql in C. The output of executing it would be similar to this:
//
// HDFql version: 1.4.0
// File in use: example_c.h5
// Attribute value: 12.400000
// Variable:
// 1
// 2
// 3
// 4
// 5
// 6
// Cursor:
// 1
// 2
// 3
// 4
// 5
// 6
// Dataset size: 24
//
//===========================================================

// include HDFql C header file (make sure it can be found by the C compiler)
#include "HDFql.h"

int main(int argc, char *argv[])
{

	// declare variables
	HDFQL_CURSOR my_cursor;
	char script[1024];
	int values[3][2];
	int x;
	int y;

	// display HDFql version in use
	printf("HDFql version: %s\n", HDFQL_VERSION);

	// create an HDF file named "example_c.h5" and use (i.e. open) it
	hdfql_execute("CREATE FILE example_c.h5");
	hdfql_execute("USE FILE example_c.h5");

	// populate HDFql default cursor with name of the HDF file in use and display it
	hdfql_execute("SHOW USE FILE");
	hdfql_cursor_first(NULL);
	printf("File in use: %s\n", hdfql_cursor_get_char(NULL));

	// create an attribute named "example_attribute" of type float with a value of 12.4
	hdfql_execute("CREATE ATTRIBUTE example_attribute AS FLOAT DEFAULT 12.4");

	// select (i.e. read) attribute "example_attribute" and display its value
	hdfql_execute("SELECT FROM example_attribute");
	hdfql_cursor_first(NULL);
	printf("Attribute value: %f\n", *hdfql_cursor_get_float(NULL));

	// create a dataset named "example_dataset" of type int of two dimensions (size 3x2)
	hdfql_execute("CREATE DATASET example_dataset AS INT(3, 2)");

	// populate variable "values" with certain values
	for(x = 0; x < 3; x++)
	{
		for(y = 0; y < 2; y++)
		{
			values[x][y] = x * 2 + y + 1;
		}
	}

	// register variable "values" for subsequent use (by HDFql)
	hdfql_variable_register(&values);

	// insert (i.e. write) content of variable "values" into dataset "example_dataset"
	sprintf(script, "INSERT INTO example_dataset VALUES FROM MEMORY %u", hdfql_variable_get_number(&values));
	hdfql_execute(script);

	// populate variable "values" with zeros (i.e. reset variable)
	for(x = 0; x < 3; x++)
	{
		for(y = 0; y < 2; y++)
		{
			values[x][y] = 0;
		}
	}

	// select (i.e. read) dataset "example_dataset" into variable "values"
	sprintf(script, "SELECT FROM example_dataset INTO MEMORY %u", hdfql_variable_get_number(&values));
	hdfql_execute(script);

	// unregister variable "values" as it is no longer used/needed (by HDFql)
	hdfql_variable_unregister(&values);

	// display content of variable "values"
	printf("Variable:\n");
	for(x = 0; x < 3; x++)
	{
		for(y = 0; y < 2; y++)
		{
			printf("%d\n", values[x][y]);
		}
	}

	// another way to select (i.e. read) dataset "example_dataset" using HDFql default cursor
	hdfql_execute("SELECT FROM example_dataset");

	// display content of HDFql default cursor
	printf("Cursor:\n");
	while(hdfql_cursor_next(NULL) == HDFQL_SUCCESS)
	{
		printf("%d\n", *hdfql_cursor_get_int(NULL));
	}

	// initialize cursor "my_cursor" and use it
	hdfql_cursor_initialize(&my_cursor);
	hdfql_cursor_use(&my_cursor);

	// populate cursor "my_cursor" with size of dataset "example_dataset" and display it
	hdfql_execute("SHOW SIZE example_dataset");
	hdfql_cursor_first(NULL);
	printf("Dataset size: %d\n", *hdfql_cursor_get_int(NULL));

	return 0;

}

