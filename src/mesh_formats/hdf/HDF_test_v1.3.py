import numpy as np
import h5py
raw_mesh= np.loadtxt('raw_mesh.data')
#create a NaN case 
#if NaN found yell out the location of NaN
e=np.isnan(raw_mesh)
shape=e.shape

for i in range(0,shape[0]):
        for j in range (0,shape[1]):
                if e[i,j]==True:
                        print 'A NaN exists at Node', i,'element',j
                        print 'Replacing NaN with Zero'
                        raw_mesh[i,j]=0.00
  

length=raw_mesh.shape[0]

print 'Creating Datasets'
node = raw_mesh[:,0]
velocity = raw_mesh[:,1:4]
position = raw_mesh[:,4:7]
pressure = raw_mesh[:,7]



print 'Writing 3 Dimensional Vectors'
hdf5 = h5py.File('mesh_v2.hdf5', 'w')
dataset_3d= hdf5.create_dataset('Vectors3D', (length,),
                              dtype=[('Position', '<f8', 3),
                                     ('Velocity', '<f8', 3)])

dataset_3d['Position'] = position 
dataset_3d['Velocity'] = velocity

print 'Writing 1 Dimensional Scalars'
dataset_1d= hdf5.create_dataset('Scalars', (length,),
                              dtype=[('Pressure', '<f8'),
                                     ('Node','<f8')])
                                     
dataset_1d['Pressure'] = pressure
dataset_1d['Node'] = node

hdf5.close()



#idea(s)
#create error codes