## HDF5 mesh format ###

# HDF5#

- HDF5 is the file format used to save the data points.
- HDF5 file formates are used to store large amount of data and is compatible with cross platform.
# file generation #
- the program uses HDF5 libraries to generate the files.
- program reads the data file generated while mesh generation in this case it reads the file "puntosmalla.dat".
- the first line gives the information of the number of nodes generated.
- the program creates a data set with name nodes and assigns the respective values.
- Program also creates velocity, pressure and node number data sets for future use. for now the values are 0.
- Then the hdf file is generated.
- the generated file can be viewed using hdfview software.

# file viewing software #
- the generated file can be viewed using hdfview software.
- to install the package we the command 
- >> sudo apt-get install hdfview
### Bibliography ###

-References which helped for hdf file generation.


- https://support.hdfgroup.org/HDF5/hdf5-files.html
- For downloading libraries
- https://support.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-1.8/hdf5-1.8.20/src/hdf5-1.8.20.tar

### Regards ###

