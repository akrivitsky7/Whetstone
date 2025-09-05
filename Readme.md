# Welcome to My Whetstone Performance Benchmarks Across Languages!


In this repository, you'll find simple implementations of the popular **Whetstone** benchmark. Why Whetstone? It's easy to understand, widely adopted, and relatively accurate. This makes it ideal for comparing performance across various technologies—different languages, compilers, and hardware. With Whetstone, you can feel confident you're comparing "oranges to oranges."

I personally use this benchmark every time I buy a new computer, install a new compiler, or update my environment.

---

## Java

You may want to run the benchmark in your favorite IDE (e.g., Eclipse). In that case, configure your run settings to include two arguments—inner loop count and outer loop count—separated by a space in the **Arguments** tab.

Try starting with: `1000 300` (adjust depending on your CPU speed).

* Source file: **Dwhet.java**
* Easy to adapt for server-side use, such as wrapping into a servlet.

---

## C

* Source file: **dwhet.c**
* Compiles cleanly under GCC 15.2 Some systems may require minor adjustments to the timing functions.

**Compile using:**


gcc -Ofast dwhet.c -o dwhet_run_fast -lm

**Or with Intel Compiler:**


icc dwhet.c -o Dwhet_optimized_with_intel_c.exe -O3 -ipo -no-prec-div



Suggested arguments: `3000 1000`

---

## C++ (Microsoft Visual Studio 2017–2022)

* Source file: **Dwhet.cpp**

**Instructions:**

1. Create a new project: Visual C++ Console Application (e.g., name it `Dwhet`)
2. Replace the default `Dwhet.cpp` with the version from this repo.
3. Go to Project → Properties, and add `_CRT_SECURE_NO_WARNINGS;` to **Preprocessor Definitions**

> Repeat step 3 for both Debug and Release configurations.

Suggested arguments: `3000 1000` (e.g., for Intel Core i7 @ 2.8 GHz)

---

## Fortran

* Most compilers use **dwhet.f**
* For NVIDIA `nvfortran`, use: **whet_cuda_parallel.cuf**

**Suggested arguments for dwhet.f:** `6000 2000`, then adjust.

### Example compilation:

**Intel Fortran:**


ifort dwhet.f -o Dwhet_optimized_with_intel -O3 -ipo -no-prec-div





**GFortran:**


gfortran dwhet.f -o Dwhet_gcc -Ofast



### NVIDIA CUDA Fortran:

If your system supports CUDA 12.7 and you're using `nvhpc-25-5-cuda-multi` (e.g., in Ubuntu 24.04 on WSL2 under Windows 11 pro), compile with:


nvfortran -cuda whet_cuda_parallel.cuf -o whet_cuda_parallel


**Suggested inputs (for GPUs like RTX 4070 with 8GB VRAM):**


Enter inner loop count:   3600000
Enter outer loop count:   1200000
Enter number of GPU threads: 8192


Adjust these for your GPU capabilities.

---

## Free Pascal

Tested on Windows 11 pro and Ubuntu 20.04 (via WSL2).

* Source: **whet.pas**

**Windows (64-bit with Core i7-1360P):**


ppcrossx64 -O3 -OoFASTMATH -CpCOREAVX2 -Xs -XX -Sh whet.pas



**Ubuntu:**


fpc whet.pas


---

## Julia

* Source: **whestone.jl**

**Compile with:**


julia --optimize=3 --check-bounds=no whestone.jl


Try: `1000 3000`, then adjust as needed.

---

## Rust

* File: **main.rs** under `src/`
* Project structure supports Cargo

**Compile:**


cargo build --release


**Run:**


cargo run --release


Try: `1000 3000` as initial loop parameters.

---

## My Articles in Java Developer's Journal

http://web.archive.org/web/20190703063724/http://anatolykrivitsky.sys-con.com/

---

## Legal Text Related to the Code

### **Copyright Notice**

(c) 2002–2025 Anatoly S. Krivitsky, Ph.D.
All rights reserved.

You are granted permission to use, distribute, and publish this code freely, provided the above copyright is retained.

**Contact:**
[akrivitsky@yahoo.com](mailto:akrivitsky@yahoo.com)
[akrivitsky@gmail.com](mailto:akrivitsky@gmail.com)

---

### **Disclaimer of Liability**

This code is provided "as is" without warranty of any kind.
Use at your own risk.
The author is not liable for any damages, direct or indirect, including (but not limited to) lost profits, data corruption, or hardware failure resulting from use or inability to use of the code.

---


