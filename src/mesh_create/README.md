# Hello Everyone #

# Welcome to the Mesh Generation Framework. #

- In order to make you understand how we managed to create the rectangular mesh and an another mesh which is simillar to the nozzle .  
- I had written here README so please, have a kind look.

 ![alt text](http://imp-turbulence.ec-lille.fr/Webpage/Laval/Turbulence/grid_A_Re600.png)














### Working ###

# Simple Rectangular Mesh #

- First of all,their is a module which obtains all the coordinates of rectangle and number of division  for vertical and horizontal axis.
- Then we defined a module to take the value from the user and insert it into variables.
- Finally,it gives us output as px,py,pz,u,v,and w coordinates of meshed grid and these all are the node points.
- For simplicity test cases are also provided to check the initial working of modules.
 
# Geometry similar to Nozzle #

- In this case firstly we ask the user that how many points do they want in the verical discritisation.
- Then we define a module that takes the value from user and insert it into Variables.
- Also we advanced this geometry by asking user that do they want local strecting between some points, if yes .
- Then we define a module that is basically using newton interpolation for the local strectching of points
- Then We ask them to insert the points between which they want local stretching.
- Further advancing we ask the user to insert a factor by which they want local strtching between the points.
- Finally, we ask them for the type of distribution do they like between their selected points.
- Finally,it gives us output as x,y,y2,z1,z2,z3and z4 coordinates of meshed grid and these all are the node points.
- For simplicity test cases are also provided to check the initial working of modules.


### Bibliography ###

- Below mentioned are the list of refrences which helped us a lot during mesh generation for the simple and complex geometries.


- http://water.engr.psu.edu/hill/research/glba/software/battri_guide.pdf
- http://www.pdas.com/refs/tnd6766.pdf
- https://people.eecs.berkeley.edu/~jrs/meshpapers/BernPlassmann.pdf
- https://en.wikipedia.org/wiki/Principles_of_grid_generation
- https://www.iitk.ac.in/tkic/workshop/FEM/ppt/Basics%20of%20Mesh%20Generation_SF%20Anwer.pdf

### Regards ###

### Mesh_Generation Team ###
### Akshay, Alvaro & Drashti ###

