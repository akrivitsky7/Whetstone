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
It runs fine under gcc version 14.2.0  
Your compiler may complain on how to deal with timing, in this case minor chages will be required.
 
It was compiled using the following command:
gcc -Ofast dwhet.c -o dwhet_run_fast -lm

3000 and 1000 was used as a number of inner loops and a number of outer loops 

Also it was compiled with Intel(R) Parallel Studio XE 2020 Update 1 for Linux with icc version 19.1.1.217  
using the following command:
icc dwhet.c -o Dwhet_optimized_with_intel_c.exe -O3 -ipo -no-prec-div


C++ for Microsoft Visual Studio 2017 - 2022
-------------
The file with source code is **Dwhet.cpp**.
As you may guess, the program is compliled with Microsoft Visual Studio 2017 - 2022 and can be run within it.
To compile you may want to do the following
1. Create new project as Visual C++ console application. For brevity we will further use name Dwhet for it.
2. Open Dwhet.cpp within the project (if needed replace content with Dwhet.cpp from this repository).
3. Choose Project | Properties and after that add _CRT_SECURE_NO_WARNINGS; to Preprocessor Definitions (just after CONSOLE);
Please note that you will need to do point 3 above both for Debug and Release configurations
3000 and 1000 was used as a number of inner loops and a number of outer loops  for PC with Intel Core i7 @ 2.8 GHz

  

Fortran
-------------

The source code is in file **dwhet.f**. It is compiled gfortran but you can adjust it to your fortran compiler with little or no changes. 
You may want to start from 6000 2000 as a number of inner loops and a number of outer loops and after several runs adjust it accordingly.

Examples of compile and run using different compilers:

1. **Intel(R) Fortran Compiler Version  19.1.1.217** from Intel(R) Parallel Studio XE 2020 Update 1 for Linux  
ifort dwhet.f -o Dwhet_optimized_with_intel -O3 -ipo -no-prec-div
or 
ifort dwhet.f -o Dwhet_optimized_with_intel -Ofast

2. **gfortran from gcc  14.2.0**

gfortran dwhet.f -o Dwhet_gcc -Ofast


3. **pgfortran 19.10-0 64-bit**

pgfortran -opgi_dwhet_2020.exe -O3 dwhet.f   

Suppose that you run  your code (compiled as shown above) from command line, you will be asked to a enter number of inner loops and a number of outer loops. Please see recommendations above.

 
Free Pascal
-------------

I tried this one on Windows 11 and Ubuntu 20.04 (under WSL). 
If you use the latest release (which is 3.2.2 at the time of writing) and if your Windows System is 64-bit you may want to use ppcrossx64.exe with corresponding options for compilation.
Options depend on your CPU. For example, if you have Intel Core i7 CPU like Intel Core i7-1360P
you may want to use the following options:

ppcrossx64 -O3 -OoFASTMATH -CpCOREAVX2 -Xs -XX -Sh whet.pas

If you use it on Ubuntu 20.04 you may want to use fpc.
The file name is   **whet.pas** 

Julia
-------------
You may want to try the following command:

julia --optimize=3 --check-bounds=no whestone.jl

The file name is **whestone.jl**.

For the first run you may want to use 1000 3000 as a number of inner loops and a number of outer loops. After that you may want to adjust it according to your CPU clock speed.

Rust
-------------
Please note the structure of directories under whetstone_rust foldrer as you may want to use something similar.
As we are going to use Cargo, Cargo.toml file is included.

The file with whetstone code is **main.rs** under src folder.

It is compiled using the following command:

cargo build --release

Executable file (e.g. whetstone_rust.exe if you run on windows) will be created under target/release folder.

Executable can be run with the following command:

cargo run --release


As with other languages you may want to start with 1000 3000 as a number of inner loops and a number of outer loops and after that adjust it according to your CPU clock speed.


My articles in Java Development Journal  that may help you
-------------
http://web.archive.org/web/20190703063724/http://anatolykrivitsky.sys-con.com/ 

Legal text related to the code
-------------

**Copyright notes**

 (c) Copyright 2002 - 2025 Anatoly S. Krivitsky, Ph.D.
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
 
 

