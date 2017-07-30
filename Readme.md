Welcome to my perfomance whetstone benchmarks for different languages!
===================



 In this repository, you will find 3 simple samples of popular **Whetsone** benchmark. Why whetstone? Well, it is easy, widespread and relatively accurate.  That's why it can be imlemented among different technologies (including but not limited to different languages, compilers, hardware etc). So you have some assrance that you are
comparing "oranges to oranges" in terms of performance.  I personally use this kind of testing each time I buy a new computer, install new compiler etc.

Java
-------------

You may want to run it within your favorite IDE (say Eclipse). In this case you may want to use run configuration. Add two arguments (a number of inner loops and a number of outer loops) 
separated by blank in  **Arguments** tab of your run configuration. You may want to start from say 1000 300 (which for sure depends on you CPU clock speed) and than adjust it as needed.

The file with source code is **Dwhet.java**.

It is easy to change it for testing on a server side, say by creating corresponding servlrets out of this file.


C
-------------

The file with source code is **dwhet.c**.
It runs fine under GCC 7.1.1 (run under Fedora 26) 
Your compiler may complain on how to deal with timing, in this case minor chages will be required.
You may want to use like 4000 2000 as a number of inner loops and a number of outer loops and than adjust it as needed. 
Under Fedora 26 it was compiled using the following command:
gcc -OFast dwhet.c -o dwhet_run_fast -lm
3000 and 1000 was used as a number of inner loops and a number of outer loops 


Fortran
-------------

The source code is in file **dwhet.f**. It is compiled gfortran but you can adjust it to your fortran compiler with little or no changes. 
1000 300 as a number of inner loops and a number of outer loops.

Suppose that you run from command line, you will be asked to enter it.

 
Free Pascal
-------------

I tried this one only on Windows, though it looks like that there is no explicit dependencies on any operating system here.
If you use the latest release (which is 3.0.2 at the time of writing) and if your Windows System is 64-bit you may want to use ppcrossx64.exe with corresponding options for compilation.
The file name is   **whet.pas** 

My articles in Java Development Journal  that may help you
-------------
http://anatolykrivitsky.sys-con.com/ 

Legal text related to the code
-------------

**Copyright notes**

 (c) Copyright 2002 - 2017 Anatoly S. Krivitsky, Ph.D.
 All rights reserved

 Conditional permission for free use of the code
 As soon as above copyright notes are mentioned,
 the author grants a permission to any person or organization
 to use, distribute and publish this code for free
 Questions and comments may be directed to the author at
 akrivitsky@yahoo.com and akrivitsky@gmail.com

**Disclaimer of Liability**
  The user assumes all responsibility
 and risk for the use of this code "as is".
 There is no  warranty of any kind associated with the code.
 Under no circumstances, including negligence, shall the author be liable
 for any DIRECT, INDIRECT, INCIDENTAL, SPECIAL or CONSEQUENTIAL DAMAGES,
 or LOST PROFITS that result from the use or inability to use the code.
 Nor shall the author be liable for any such damages including,
 but not limited to, reliance by any person on any
 information obtained with the code
 
 

