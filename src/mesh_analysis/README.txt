Hello everyone and particularly my team, 

In order to make you understand what the hell I did here I wrote this README so please, read-me 
So, I learnt during these vacation some things about CMake and I tried to apply them. 
First of all nothing (from your side) was deleted, I just created a new file named Module in order to put all the module programs we need. 
Secondly, I created a Main folder in order to put the main program 
Thirdly, I created Build folder in order to compile everything. 

and, it is working... Almost... 
If you want to compile write line by line this
 
cd Build/
cmake ..
make
./main

if everything is working you should see 'test' written. 

NEXT STEPS
Now I understood roughly how CMake works, unfortunatly it may have some dependency problem with the module. 
So the next step will be to improve the CMakeLists.txt in order to fix all the problems. 
And also adapt all the codes : from PROGRAM --> MODULE

ENJOY
HAPPY NEW YEAR BTW :-)
