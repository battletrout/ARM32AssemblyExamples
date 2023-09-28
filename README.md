# ARM32 Assembly Examples
Here are some examples of algorithms implemented in 32-bit ARM Assembly. They are derived from coursework in the JHU Engineering for Professionals computer science course EN.605.204: Computer Organization. Credit to Prof. Charles W. Kann, who taught the course and wrote the phenomenal book "Introduction to Assembly Language Programming: From Soup to Nuts: ARM Edition," published 2021 by Gettysburg Press.  

These examples were tested on a Raspberry Pi.

## Compile and Run on Raspberry Pi

To compile and them using GNU Compiler Collection (gcc):
1. load/copy/sftp the .s files onto the Raspberry Pi
2. navigate to the directory where the .s files are loaded to 
3. run the following code for the example you want to run, where "program.s" is the filename:

'''
gcc program.s -c -o program.o
gcc program.o -o program
./program
'''

The first command creates the object file from the assembly text file. Program.s is the assembly text file, and program.o is the output object file.
	-c means create the object file
	-o followed by name is the name for output file

The second command links the references in main that are unresolved (such as printf in HelloWorld.s) and outputs the executable. Because of the .o file extension, gcc knows it needs linkage run on it.
    -o followed by name is the name for output file

The final command (./program) runs the program executable.

## To Enable Debugging with gdb: 

Instead compile using the following commands:
'''
gcc program.s -g -c -o program.o
gcc program.o -o program
gdb program -tui
'''
The addition of the -g option in the first command enables more detailed debugging info.
The final command opens gdb with the Text User Interface (TUI), which allows you to set breakpoints and do other important things.

https://sourceware.org/gdb/onlinedocs/gdb/TUI.html#TUI

Some particularly useful commands in GDB's TUI:
Show the registers' values
'''
layout regs
'''

Set a breakpoint at line 22
'''
break 22
'''

Refresh the screen (if the formatting is off after)
'''
refresh
'''
