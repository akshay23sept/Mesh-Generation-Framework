# Copyright (C) 2016-2017
# This file is part of the Hierarchical Data Format query language (HDFql)
# For more information about HDFql, please visit the website http://www.hdfql.com

# $Rev: 134 $



#===========================================================
# The following script provides an example on how to use the HDFql Python wrapper. The output of executing it would be similar to this:
#
# HDFql version: 1.4.0
# File in use: example_python.h5
# Attribute value: 12.400000
# Variable:
# 1
# 2
# 3
# 4
# 5
# 6
# Cursor:
# 1
# 2
# 3
# 4
# 5
# 6
# Dataset size: 24
#
#===========================================================

# import HDFql module (make sure it can be found by the Python interpreter)
import HDFql
import numpy

# display HDFql version in use
print("HDFql version: %s" % HDFql.VERSION)

# create an HDF file named "example_python.h5" and use (i.e. open) it
HDFql.execute("CREATE FILE example_python.h5")
HDFql.execute("USE FILE example_python.h5")

# populate HDFql default cursor with name of the HDF file in use and display it
HDFql.execute("SHOW USE FILE")
HDFql.cursor_first()
print("File in use: %s" % HDFql.cursor_get_char())

# create an attribute named "example_attribute" of type float with a value of 12.4
HDFql.execute("CREATE ATTRIBUTE example_attribute AS FLOAT DEFAULT 12.4")

# select (i.e. read) attribute "example_attribute" and display its value
HDFql.execute("SELECT FROM example_attribute")
HDFql.cursor_first()
print("Attribute value: %f" % HDFql.cursor_get_float())

# create a dataset named "example_dataset" of type int of two dimensions (size 3x2)
HDFql.execute("CREATE DATASET example_dataset AS INT(3, 2)")

# create variable "values" and populate it with certain values
values = numpy.zeros((3, 2), dtype = numpy.int32)
for x in range(3):
	for y in range(2):
		values[x][y] = x * 2 + y + 1

# register variable "values" for subsequent use (by HDFql)
HDFql.variable_register(values)

# insert (i.e. write) content of variable "values" into dataset "example_dataset"
HDFql.execute("INSERT INTO example_dataset VALUES FROM MEMORY %d" % HDFql.variable_get_number(values))

# populate variable "values" with zeros (i.e. reset variable)
for x in range(3):
	for y in range(2):
		values[x][y] = 0

# select (i.e. read) dataset "example_dataset" into variable "values"
HDFql.execute("SELECT FROM example_dataset INTO MEMORY %d" % HDFql.variable_get_number(values))

# unregister variable "values" as it is no longer used/needed (by HDFql)
HDFql.variable_unregister(values)

# display content of variable "values"
print("Variable:")
for x in range(3):
	for y in range(2):
		print(values[x][y])

# another way to select (i.e. read) dataset "example_dataset" using HDFql default cursor
HDFql.execute("SELECT FROM example_dataset")

# display content of HDFql default cursor
print("Cursor:")
while HDFql.cursor_next() == HDFql.SUCCESS:
	print(HDFql.cursor_get_int())

# create cursor "my_cursor" and use it
my_cursor = HDFql.Cursor()
HDFql.cursor_use(my_cursor)

# populate cursor "my_cursor" with size of dataset "example_dataset" and display it
HDFql.execute("SHOW SIZE example_dataset")
HDFql.cursor_first()
print("Dataset size: %d" % HDFql.cursor_get_int())

