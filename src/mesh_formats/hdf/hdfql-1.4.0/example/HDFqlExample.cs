// Copyright (C) 2016-2017
// This file is part of the Hierarchical Data Format query language (HDFql)
// For more information about HDFql, please visit the website http://www.hdfql.com

// $Rev: 134 $



//===========================================================
// The following program provides an example on how to use the HDFql C sharp wrapper. The output of executing it would be similar to this:
//
// HDFql version: 1.4.0
// File in use: example_csharp.h5
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
	public static void Main(string []args)
	{
		// declare variables
		HDFqlCursor myCursor;
		int [,]values;
		int x;
		int y;

		// display HDFql version in use
		System.Console.WriteLine("HDFql version: {0}", HDFql.Version);

		// create an HDF file named "example_csharp.h5" and use (i.e. open) it
		HDFql.Execute("CREATE FILE example_csharp.h5");
		HDFql.Execute("USE FILE example_csharp.h5");

		// populate HDFql default cursor with name of the HDF file in use and display it
		HDFql.Execute("SHOW USE FILE");
		HDFql.CursorFirst();
		System.Console.WriteLine("File in use: {0}", HDFql.CursorGetChar());

		// create an attribute named "example_attribute" of type float with a value of 12.4
		HDFql.Execute("CREATE ATTRIBUTE example_attribute AS FLOAT DEFAULT 12.4");

		// select (i.e. read) attribute "example_attribute" and display its value
		HDFql.Execute("SELECT FROM example_attribute");
		HDFql.CursorFirst();
		System.Console.WriteLine("Attribute value: {0}", HDFql.CursorGetFloat());

		// create a dataset named "example_dataset" of type int of two dimensions (size 3x2)
		HDFql.Execute("CREATE DATASET example_dataset AS INT(3, 2)");

		// create variable "values" and populate it with certain values
		values = new int[3, 2];
		for(x = 0; x < 3; x++)
		{
			for(y = 0; y < 2; y++)
			{
				values[x, y] = x * 2 + y + 1;
			}
		}

		// register variable "values" for subsequent use (by HDFql)
		HDFql.VariableRegister(values);

		// insert (i.e. write) content of variable "values" into dataset "example_dataset"
		HDFql.Execute("INSERT INTO example_dataset VALUES FROM MEMORY " + HDFql.VariableGetNumber(values));

		// populate variable "values" with zeros (i.e. reset variable)
		for(x = 0; x < 3; x++)
		{
			for(y = 0; y < 2; y++)
			{
				values[x, y] = 0;
			}
		}

		// select (i.e. read) dataset "example_dataset" into variable "values"
		HDFql.Execute("SELECT FROM example_dataset INTO MEMORY " + HDFql.VariableGetNumber(values));

		// unregister variable "values" as it is no longer used/needed (by HDFql)
		HDFql.VariableUnregister(values);

		// display content of variable "values"
		System.Console.WriteLine("Variable:");
		for(x = 0; x < 3; x++)
		{
			for(y = 0; y < 2; y++)
			{
				System.Console.WriteLine(values[x, y]);
			}
		}

		// another way to select (i.e. read) dataset "example_dataset" using HDFql default cursor
		HDFql.Execute("SELECT FROM example_dataset");

		// display content of HDFql default cursor
		System.Console.WriteLine("Cursor:");
		while(HDFql.CursorNext() == HDFql.Success)
		{
			System.Console.WriteLine(HDFql.CursorGetInt());
		}

		// create cursor "myCursor" and use it
		myCursor = new HDFqlCursor();
		HDFql.CursorUse(myCursor);

		// populate cursor "myCursor" with size of dataset "example_dataset" and display it
		HDFql.Execute("SHOW SIZE example_dataset");
		HDFql.CursorFirst();
		System.Console.WriteLine("Dataset size: {0}", HDFql.CursorGetInt());
	}
}

