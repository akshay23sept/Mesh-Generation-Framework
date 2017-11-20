// Copyright (C) 2016-2017
// This file is part of the Hierarchical Data Format query language (HDFql)
// For more information about HDFql, please visit the website http://www.hdfql.com

// $Rev: 134 $



//===========================================================
// The following program provides an example on how to use the HDFql Java wrapper. The output of executing it would be similar to this:
//
// HDFql version: 1.4.0
// File in use: example_java.h5
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

public class HDFqlExample
{
	public static void main(String args[])
	{
		// declare variables
		HDFqlCursor myCursor;
		int values[][];
		int x;
		int y;

		// load HDFql shared library (make sure it can be found by the JVM)
		System.loadLibrary("HDFql");

		// display HDFql version in use
		System.out.println("HDFql version: " + HDFql.VERSION);

		// create an HDF file named "example_java.h5" and use (i.e. open) it
		HDFql.execute("CREATE FILE example_java.h5");
		HDFql.execute("USE FILE example_java.h5");

		// populate HDFql default cursor with name of the HDF file in use and display it
		HDFql.execute("SHOW USE FILE");
		HDFql.cursorFirst();
		System.out.println("File in use: " + HDFql.cursorGetChar());

		// create an attribute named "example_attribute" of type float with a value of 12.4
		HDFql.execute("CREATE ATTRIBUTE example_attribute AS FLOAT DEFAULT 12.4");

		// select (i.e. read) attribute "example_attribute" and display its value
		HDFql.execute("SELECT FROM example_attribute");
		HDFql.cursorFirst();
		System.out.println("Attribute value: " + HDFql.cursorGetFloat());

		// create a dataset named "example_dataset" of type int of two dimensions (size 3x2)
		HDFql.execute("CREATE DATASET example_dataset AS INT(3, 2)");

		// create variable "values" and populate it with certain values
		values = new int[3][2];
		for(x = 0; x < 3; x++)
		{
			for(y = 0; y < 2; y++)
			{
				values[x][y] = x * 2 + y + 1;
			}
		}

		// register variable "values" for subsequent use (by HDFql)
		HDFql.variableRegister(values);

		// insert (i.e. write) content of variable "values" into dataset "example_dataset"
		HDFql.execute("INSERT INTO example_dataset VALUES FROM MEMORY " + HDFql.variableGetNumber(values));

		// populate variable "values" with zeros (i.e. reset variable)
		for(x = 0; x < 3; x++)
		{
			for(y = 0; y < 2; y++)
			{
				values[x][y] = 0;
			}
		}

		// select (i.e. read) dataset "example_dataset" into variable "values"
		HDFql.execute("SELECT FROM example_dataset INTO MEMORY " + HDFql.variableGetNumber(values));

		// unregister variable "values" as it is no longer used/needed (by HDFql)
		HDFql.variableUnregister(values);

		// display content of variable "values"
		System.out.println("Variable:");
		for(x = 0; x < 3; x++)
		{
			for(y = 0; y < 2; y++)
			{
				System.out.println(values[x][y]);
			}
		}

		// another way to select (i.e. read) dataset "example_dataset" using HDFql default cursor
		HDFql.execute("SELECT FROM example_dataset");

		// display content of HDFql default cursor
		System.out.println("Cursor:");
		while(HDFql.cursorNext() == HDFql.SUCCESS)
		{
			System.out.println(HDFql.cursorGetInt());
		}

		// create cursor "myCursor" and use it
		myCursor = new HDFqlCursor();
		HDFql.cursorUse(myCursor);

		// populate cursor "myCursor" with size of dataset "example_dataset" and display it
		HDFql.execute("SHOW SIZE example_dataset");
		HDFql.cursorFirst();
		System.out.println("Dataset size: " + HDFql.cursorGetInt());
	}
}

