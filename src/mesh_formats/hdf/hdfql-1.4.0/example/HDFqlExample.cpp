// Copyright (C) 2016-2017
// This file is part of the Hierarchical Data Format query language (HDFql)
// For more information about HDFql, please visit the website http://www.hdfql.com

// $Rev: 138 $



//===========================================================
// The following program provides an example on how to use HDFql in C++. The output of executing it would be similar to this:
//
// HDFql version: 1.4.0
// File in use: example_cpp.h5
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

// include HDFql C++ header file (make sure it can be found by the C++ compiler)
#include <iostream>
#include "HDFql.hpp"

int main(int argc, char *argv[])
{

	// declare variables
	HDFql::Cursor myCursor;
	char script[1024];
	int values[3][2];
	int x;
	int y;

	// display HDFql version in use
	std::cout << "HDFql version: " << HDFql::Version << std::endl;

	// create an HDF file named "example_cpp.h5" and use (i.e. open) it
	HDFql::execute("CREATE FILE example_cpp.h5");
	HDFql::execute("USE FILE example_cpp.h5");

	// populate HDFql default cursor with name of the HDF file in use and display it
	HDFql::execute("SHOW USE FILE");
	HDFql::cursorFirst();
	std::cout << "File in use: " << HDFql::cursorGetChar() << std::endl;

	// create an attribute named "example_attribute" of type float with a value of 12.4
	HDFql::execute("CREATE ATTRIBUTE example_attribute AS FLOAT DEFAULT 12.4");

	// select (i.e. read) attribute "example_attribute" and display its value
	HDFql::execute("SELECT FROM example_attribute");
	HDFql::cursorFirst();
	std::cout << "Attribute value: " << *HDFql::cursorGetFloat() << std::endl;

	// create a dataset named "example_dataset" of type int of two dimensions (size 3x2)
	HDFql::execute("CREATE DATASET example_dataset AS INT(3, 2)");

	// populate variable "values" with certain values
	for(x = 0; x < 3; x++)
	{
		for(y = 0; y < 2; y++)
		{
			values[x][y] = x * 2 + y + 1;
		}
	}

	// register variable "values" for subsequent use (by HDFql)
	HDFql::variableRegister(&values);

	// insert (i.e. write) content of variable "values" into dataset "example_dataset"
	sprintf(script, "INSERT INTO example_dataset VALUES FROM MEMORY %u", HDFql::variableGetNumber(&values));
	HDFql::execute(script);

	// populate variable "values" with zeros (i.e. reset variable)
	for(x = 0; x < 3; x++)
	{
		for(y = 0; y < 2; y++)
		{
			values[x][y] = 0;
		}
	}

	// select (i.e. read) dataset "example_dataset" into variable "values"
	sprintf(script, "SELECT FROM example_dataset INTO MEMORY %u", HDFql::variableGetNumber(&values));
	HDFql::execute(script);

	// unregister variable "values" as it is no longer used/needed (by HDFql)
	HDFql::variableUnregister(&values);

	// display content of variable "values"
	std::cout << "Variable:" << std::endl;
	for(x = 0; x < 3; x++)
	{
		for(y = 0; y < 2; y++)
		{
			std::cout << values[x][y] << std::endl;
		}
	}

	// another way to select (i.e. read) dataset "example_dataset" using HDFql default cursor
	HDFql::execute("SELECT FROM example_dataset");

	// display content of HDFql default cursor
	std::cout << "Cursor:" << std::endl;
	while(HDFql::cursorNext() == HDFql::Success)
	{
		std::cout << *HDFql::cursorGetInt() << std::endl;
	}

	// use cursor "myCursor"
	HDFql::cursorUse(&myCursor);

	// populate cursor "myCursor" with size of dataset "example_dataset" and display it
	HDFql::execute("SHOW SIZE example_dataset");
	HDFql::cursorFirst();
	std::cout << "Dataset size: " << *HDFql::cursorGetInt() << std::endl;

	return 0;

}

