// Copyright notes 
// Java Whetstone Double Precision Benchmark 
// (c) Copyright 2002 - 2017  Anatoly S. Krivitsky, Ph.D. 
// All rights reserved 
// Conditional permission for free use of the code 
// As soon as above copyright notes are mentioned, 
// the author grants a permission to any person or organization 
// to use, distribute and publish this code for free 
// Questions and comments may be directed to the author at 
// akrivitsky@yahoo.com and akrivitsky@gmail.com
// Disclaimer of Liability 
// The user assumes all responsibility 
// and risk for the use of this code "as is". 
// There is no  warranty of any kind associated with the code. 
// Under no circumstances, including negligence, shall the author be liable  
// for any DIRECT, INDIRECT, INCIDENTAL, SPECIAL or CONSEQUENTIAL DAMAGES, 
// or LOST PROFITS that result from the use or inability to use the code. 
// Nor shall the author be liable for any such damages including, 
// but not limited to, reliance by any person on any  
// information obtained with the code 

import java.lang.Math;
import java.util.Calendar;
//import java.util.Date;
//import java.util.GregorianCalendar;
import java.util.GregorianCalendar;

public class Dwhet {
  public static double t1, t2, t3;
  public static int j, k, l;
  public static double e1[];

  public static void main(String[] args) {
    int i, isave;
    int n2, n3, n4, n6, n7, n8, n9, n11;
    int inner_program, outer_program, kount, npass, max_pass;

    double x, y, z;
    double whet_save, dif_save, kilowhet;
    double begin_time, end_time, dif_time;
    double error, whet_err, percent_err;

    kilowhet = 0;

    begin_time = 0;

    end_time = 0;

    dif_time = 0;

    whet_save = 0;

    dif_save = 0;

//    Date date = new Date();

    e1 = new double[5];

    npass = 0;
    max_pass = 2;

    //inner = 1000;
    //outer = 20;
//****************************************************************** 
//* Important notes.
//* If you have fast enough CPU, it is possible that first path will produce some "Infinity" results. 
//* In this case you should increase inner_program and outer_program values below. 
//* Good starting point for the increase is to multiply inner_program and outer_program by 10. 
//* 
//****************************************************************** 
       inner_program = 3000;
      outer_program = 1000;

    while(npass < max_pass) {
      System.out.print("\n Pass number: " + npass);


      kount = 0;
      begin_time = secnds();
      while(kount < outer_program) {
	t1 = 0.499975;
	t2 = 0.50025;
	t3 = 2.0;

	isave = inner_program;
	n2    = 12  * inner_program;
	n3    = 14  * inner_program;
	n4    = 345 * inner_program;
	n6    = 210 * inner_program;
	n7    = 32  * inner_program;
	n8    = 899 * inner_program;
	n9    = 616 * inner_program;
	n11   = 93  * inner_program;

	e1[1] = 1.0;
	e1[2] = -1.0;
	e1[3] = 1.0;
	e1[4] = -1.0;

	// Loop 2
	for(i = 1; i <= n2; i++) {
	  e1[1] = ( e1[1] + e1[2] + e1[3] - e1[4]) * t1;
	  e1[2] = ( e1[1] + e1[2] - e1[3] + e1[4]) * t1;
	  e1[3] = ( e1[1] - e1[2] + e1[3] + e1[4]) * t1;
	  e1[4] = (-e1[1] + e1[2] + e1[3] + e1[4]) * t1;
	}

	// Loop 3
	for(i = 1; i <= n3; i++) {
	  sub1(e1);
	}

	// Loop 4
	j = 1;
	for (i = 1; i <= n4; i++) {
	  if(j - 1 != 0) {
	    j = 2;
	  } else {
	    j = 3;
	  }
	  if(j - 2 != 0) {
	    j = 1;
	  } else {
	    j = 0;
	  }
	  if(j - 1 != 0) {
	    j = 1;
	  } else {
	    j = 0;
	  }
	}

	// Loop 6
	j = 1;
	k = 2;
	l = 3;
	for(i = 1; i <= n6; i++) {
	  j = j * (k - j) * (l - k);
	  k = l * k - (l - j) * k;
	  l = (l - k) * (k + j);
	  e1[l - 1] = j + k + l;
	  e1[k - 1] = j * k * l;
	}

	// Loop 7
	x = 0.5;
	y = 0.5;
	for(i = 1; i <= n7; i++) {
	  x = t1 * Math.atan( t3 * Math.sin( x ) * Math.cos( x ) / (Math.cos( x + y ) + Math.cos( x - y ) - 1.0) );
	  y = t1 * Math.atan( t3 * Math.sin( y ) * Math.cos( y ) / (Math.cos( x + y ) + Math.cos( x - y ) - 1.0) );
	}

	// Loop 8
	x = 1.0;
	y = 1.0;
	z = 1.0;
	for(i = 1; i <= n8; i++) {
	  sub2(x,y,z);
	}

	// Loop 9
	j = 1;
	k = 2;
	l = 3;
	e1[1] = 1.0;
	e1[2] = 2.0;
	e1[3] = 3.0;
	for(i = 1; i <= n9; i++) {
	  sub3();
	}

	// Loop 11
	x = 0.75;
	for(i = 1; i <= n11; i++) {
	  x = Math.sqrt( Math.exp( Math.log( x ) / t2 ) );
	}

	inner_program = isave;
	kount = kount + 1;
      }
      end_time = secnds();
      dif_time = end_time - begin_time;
      kilowhet =  ((double)(100*inner_program*outer_program))/dif_time;
      System.out.print("\n Elapsed time = " + dif_time + " kilowhet = " +
      kilowhet);
      npass = npass + 1;
      if(npass < max_pass) {
        dif_save = dif_time;
        whet_save =  kilowhet;
	inner_program = inner_program * max_pass;
      }
    }
    error = dif_time - (dif_save * max_pass);
    whet_err = whet_save - kilowhet;
    percent_err = whet_err * (double)100 / kilowhet;
    System.out.print("\n __________________________________");
    System.out.print("\n error = " + error + " whet_err = " + whet_err
    + " percent_err = " + percent_err + "%");
  }

  public static void sub1(double[] e) {

    for(int i = 1; i <= 6; i++) {
      e[1] = (e[1]  + e[2] + e[3] - e[4]) * t1;
      e[2] = (e[1]  + e[2] - e[3] + e[4]) * t1;
      e[3] = (e[1]  - e[2] + e[3] + e[4]) * t1;
      e[4] = (-e[1] + e[2] + e[3] + e[4]) / t3;
    }
  }

  public static void sub2(double x, double y, double z) {
    double x1, y1;

    x1 = x;
    y1 = y;
    x1 = (x1 + y1) * t1;
    y1 = (x1 + y1) * t1;
    z  = (x1 + y1) / t3;
  }

  public static void sub3() {
    e1[j] = e1[k];
    e1[k] = e1[l];
    e1[l] = e1[j];
  }

  public static double secnds() {
//  Date date = new Date();
	  Calendar now = GregorianCalendar.getInstance();
	  int mins = now.get(Calendar.MINUTE);
	  int secs = now.get(Calendar.SECOND);
	  int mills = now.get(Calendar.MILLISECOND);
	  int hours = now.get(Calendar.HOUR);
	  System.out.println(" hour =" + hours + "mins = " + mins + " secs = " + secs + " mills = " + mills);
	  double s1 = (double)(hours*3600 + mins * 60 + secs) + ((double)mills)*1.e-3;
	  
//  double s1 = (double)(date.getHours()*3600) +
//  (double)(date.getMinutes()*60) + (double)(date.getSeconds());
  //System.out.print("\n in secnds s1 = " + s1);
  return(s1);
   }

}