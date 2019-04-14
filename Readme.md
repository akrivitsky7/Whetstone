Welcome to my perfomance whetstone benchmarks for different languages!
===================



 In this repository you will find 5 simple samples of popular **Whetsone** benchmark. Why whetstone? Well, it is easy, widespread and relatively accurate.  That's why it can be imlemented among different technologies (including but not limited to different languages, compilers, hardware etc). So with whetstone you will have some assurance that you are
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
It runs fine under GCC  8.3.1 (run under Fedora 29) 
Your compiler may complain on how to deal with timing, in this case minor chages will be required.
You may want to use like 4000 2000 as a number of inner loops and a number of outer loops and than adjust it as needed. 
Under Fedora 29 it was compiled using the following command:
gcc -Ofast dwhet.c -o dwhet_run_fast -lm

3000 and 1000 was used as a number of inner loops and a number of outer loops 

Also it was compiled with Intel(R) Parallel Studio XE 2019 Update 1 Professional Edition for Fortran and C++ Linux 
using the following command:
icc dwhet.c -o Dwhet_optimized_with_intel_c.exe -O3 -ipo -no-prec-div


C++ for Microsoft Visual Studio 2017 - 2019
-------------
The file with source code is **Dwhet.cpp**.
As you may guess, the program is compliled with Microsoft Visual Studio 2017 and can be run within it.
To compile you may want to do the following
1. Create new project as Visual C++ console application. For brevity we will further use name Dwhet for it.
2. Open Dwhet.cpp within the project (if needed replace content with Dwhet.cpp from this repository).
3. Choose Project | Properties and after that add _CRT_SECURE_NO_WARNINGS; to Preprocessor Definitions (just after CONSOLE);
Please note that you will need to do point 3 above both for Debug and Release configurations
3000 and 1000 was used as a number of inner loops and a number of outer loops  for PC with Intel Core i7 @ 2.8 GHz

  

Fortran
-------------

The source code is in file **dwhet.f**. It is compiled gfortran but you can adjust it to your fortran compiler with little or no changes. 
3000 1000 as a number of inner loops and a number of outer loops.

Examples of compile and run using different compilers:

1. **Intel(R) Fortran Compiler Version  19.0.1.144** from Intel(R) Parallel Studio XE 2019 Update 1 Professional Edition for Fortran and C++ Linux  
ifort dwhet.f -o Dwhet_optimized_with_intel -O3 -ipo -no-prec-div
or 
ifort dwhet.f -o Dwhet_optimized_with_intel -Ofast

2. **gfortran from gcc 8.3.1**

gfortran dwhet.f -o Dwhet_gcc -Ofast

Suppose that you run  your code (compiled as shown above) from command line, you will be asked to a enter number of inner loops and a number of outer loops. Please see recommendations above.

 
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

 (c) Copyright 2002 - 2019 Anatoly S. Krivitsky, Ph.D.
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
 
 

