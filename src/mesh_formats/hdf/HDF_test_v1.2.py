import numpy as np
import h5py
raw_mesh= np.loadtxt('raw_mesh.data')
length=raw_mesh.shape[0]

print 'Creating Datasets'
velocity = raw_mesh[:,0:3]
position = raw_mesh[:,3:6]
pressure = raw_mesh[:,6]



print 'Writing 3 Dimensional Vectors'
hdf5 = h5py.File('mesh.hdf5', 'w')
dataset_3d= hdf5.create_dataset('Vectors3D', (length,),
                              dtype=[('Position', '<f8', 3),
                                     ('Velocity', '<f8', 3)])

dataset_3d['Position'] = position 
dataset_3d['Velocity'] = velocity

print 'Writing 1 Dimensional Scalars'
dataset_1d= hdf5.create_dataset('Scalars', (length,),
                              dtype=[('Pressure', '<f8')])
dataset_1d['Pressure'] = pressure

hdf5.close()



#idea(s)
#create error codes
