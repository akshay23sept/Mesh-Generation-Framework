# symbol to make comments

#If we don't write any option after make the program will execute the first order, this one.
#This order will remove al the created files used to make the program, after creatin the program (that is why I have written program.exe as its dependence)
clean: program.exe
	rm -f *.o *.mod0 *.mod *.modO

#The next two rules compile the modules 
newton.o: newton.f90
	gfortran -c newton.f90

read_file.o: read_file.f90
	gfortran -c read_file.f90

#This rule compiles the main program
program.exe: project.f90 newton.o read_file.o
	gfortran project.f90 newton.o read_file.o -o program.exe



#I am going to try to describe briefly how to use cmake, so that you can match the rest of the project:
#First of all this is the webpage where you can find the commands to install the program
#https://askubuntu.com/questions/610291/how-to-install-cmake-3-2-on-ubuntu-14-04

#Cmake is used to build a program with the different modules it is composed of. I am going to describe the process and use an example of this file To do that, you need to write:
#1º What you want to obtain. On the top of the document, in the first example, this would be 'newton.o'
#2º The things that this file depends on. In this example, the file of 1º point only needs the file 'newton.f90' to be created. We write this after the symbol ':' that follows the desired file.
#3º The command line that is going to be written to create this file. VERY IMPORTANT¡¡¡: to write that, we will press enter to go to the next line, and then pres 'TAB' (tabulador). Then we can write the commands, in this case, 'gfortran -c read_file.f90'

#Maybe anyone is asking himself.....but you need to write in a right order all the files that you create/need to compile everything? Answer:NO, when you execute this on the terminal, writing make (space) and the name of 1º (the file you want to create) (example: 'make newton.o'), the program will check all the dependences that this file has, and will execute all the previous necessary steps to obtain it. So, if you execute your final desired file, the program will execute all the necessary commands to create this one.

#When you execute this file, put in the same folder this file, newton.f90, project.f90 and read_file.f90


