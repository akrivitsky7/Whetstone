c Copyright notes
c Gnu Fortran Whetstone Double Precision Benchmark
c (c) Copyright 2002 - 2017 Anatoly S. Krivitsky, Ph.D.
c All rights reserved

c Conditional permission for free use of the code
c As soon as above copyright notes are mentioned,
c the author grants a permission to any person or organization
c to use, distribute and publish this code for free
c Questions and comments may be directed to the author at
c akrivitsky@yahoo.com and akrivitsky@usa.com

c Disclaimer of Liability
c The user assumes all responsibility
c and risk for the use of this code "as is".
c There is no  warranty of any kind associated with the code.
c Under no circumstances, including negligence, shall the author be liable
c for any DIRECT, INDIRECT, INCIDENTAL, SPECIAL or CONSEQUENTIAL DAMAGES,
c or LOST PROFITS that result from the use or inability to use the code.
c Nor shall the author be liable for any such damages including,
c but not limited to, reliance by any person on any
c information obtained with the code


      INTEGER*4   j, k, l, i, isave
      INTEGER*4   n2, n3, n4, n6, n7, n8, n9, n11
      INTEGER*4   inner, outer, kount, npass, max_pass

      REAL*8      x, y, z, t1, t2, t3, e1(4)
      REAL*8      whet_save, dif_save, kilowhet
      REAL*8      begin_time, end_time, dif_time
      REAL*8      error, whet_err, percent_err
      REAL*8      secnds

      COMMON      t1, t2, t3, e1, j, k, l



      npass    =    0
      max_pass =    2

      WRITE (*,9000)
      READ  (*,*) inner
      WRITE (*,9100)
      READ  (*,*) outer

      DO WHILE( npass .LT. max_pass)
         WRITE (*,9200) npass + 1, outer, inner
         WRITE (*,*) ('=', j = 1, 60)
         kount      = 0
         begin_time = dble(secndsmy())



         DO WHILE( kount .LT. outer )


            t1 = 0.499975D00
            t2 = 0.50025D00
            t3 = 2.0D00


            isave = inner
            n2    = 12  * inner
            n3    = 14  * inner
            n4    = 345 * inner
            n6    = 210 * inner
            n7    = 32  * inner
            n8    = 899 * inner
            n9    = 616 * inner
            n11   = 93  * inner


            e1(1) =  1.0D00
            e1(2) = -1.0D00
            e1(3) = -1.0D00
            e1(4) = -1.0D00


            DO i = 1, n2
               e1(1) = ( e1(1) + e1(2) + e1(3) - e1(4)) * t1
               e1(2) = ( e1(1) + e1(2) - e1(3) + e1(4)) * t1
               e1(3) = ( e1(1) - e1(2) + e1(3) + e1(4)) * t1
               e1(4) = (-e1(1) + e1(2) + e1(3) + e1(4)) * t1
            END DO


            DO i = 1, n3
               CALL sub1( e1 )
            END DO


            j = 1
            DO i = 1, n4
               IF( j - 1 ) 20, 10, 20
   10          j = 2
               GOTO 30
   20          j = 3
   30          IF( j - 2 ) 50, 50, 40
   40          j = 0
               GOTO 60
   50          j = 1
   60          IF( j - 1 ) 70, 80, 80
   70          j = 1
               GOTO 100
   80          j = 0
  100       END DO


            j = 1
            k = 2
            l = 3
            DO i = 1, n6
               j = j * (k - j) * (l - k)
               k = l * k - (l - j) * k
               l = (l - k) * (k + j)
               e1(l - 1) = j + k + l
               e1(k - 1) = j * k * l
            END DO


            x = 0.5D00
            y = 0.5D00
            DO i = 1, n7
               x = t1 * DATAN( t3 * DSIN( x ) * DCOS( x ) /
     +             (DCOS( x + y ) + DCOS( x - y ) - 1.0D00) )
               y = t1 * DATAN( t3 * DSIN( y ) * DCOS( y ) /
     +             (DCOS( x + y ) + DCOS( x - y ) - 1.0D00) )
            END DO


            x = 1.0D00
            y = 1.0D00
            z = 1.0D00
            DO i = 1, n8
               CALL sub2( x, y, z )
            END DO


            j = 1
            k = 2
            l = 3
            e1(1) = 1.0D00
            e1(2) = 2.0D00
            e1(3) = 3.0D00
            DO i = 1, n9
               CALL sub3
            END DO


            x = 0.75D00
            DO i = 1, n11
               x = DSQRT( DEXP( DLOG( x ) / t2 ) )
            END DO



            inner = isave
            kount = kount + 1
         END DO




         end_time = secndsmy()
         dif_time = end_time - begin_time



         kilowhet = 100.0D+00 * DBLE( outer * inner ) / dif_time

         WRITE (*,9300) dif_time, kilowhet


         npass = npass + 1
         IF( npass .LT. max_pass ) THEN
            dif_save  = dif_time
            whet_save = kilowhet
            inner     = inner * max_pass
         ENDIF
      END DO


      error       =   dif_time - (dif_save * max_pass )
      whet_err    =   whet_save - kilowhet
      percent_err =   whet_err * 100.0D+00 / kilowhet
      WRITE (*,*)
      WRITE (*,*)
      WRITE (*,*) ('=', j = 1, 60)
      WRITE (*,9400) error, whet_err, percent_err
      IF( dif_time .LT. 10.0D00 )
     +   WRITE (*,*) 'TIME is less than 10 seconds -- ',
     +               'suggest larger inner loop'


 9000 FORMAT( '0Number of inner loops (suggest more than 3):  '  )
 9100 FORMAT( ' Number of outer loops (suggest more than 1):  '  )
 9200 FORMAT( ' Pass #', I3.2, ': ', I10, ' outer loop(s),', I10,
     +           ' inner loop(s)' )
 9300 FORMAT( ' Elapsed time =', E12.2, ' seconds' ,
     +        ' Whetstones   =', E12.2,
     +        ' double-precision kilowhets/second' )
 9400 FORMAT( ' Time error   =', E12.2, ' seconds' ,
     +        ' Whet error   =', E12.2, ' kwhets/sec' ,
     +        ' %    error   =', E12.2, ' % whet error' )

      END





      SUBROUTINE sub1( e )

      REAL*8 t1, t2, t3, e(4)
      COMMON t1, t2, t3

      DO i = 1, 6
         e(1) = (e(1)  + e(2) + e(3) - e(4)) * t1
         e(2) = (e(1)  + e(2) - e(3) + e(4)) * t1
         e(3) = (e(1)  - e(2) + e(3) + e(4)) * t1
         e(4) = (-e(1) + e(2) + e(3) + e(4)) / t3
      END DO
      RETURN
      END



      SUBROUTINE sub2( x, y, z )

      REAL*8 t1, t2, t3, x1, y1, x, y, z
      COMMON t1, t2, t3

      x1 = x
      y1 = y
      x1 = (x1 + y1) * t1
      y1 = (x1 + y1) * t1
      z  = (x1 + y1) / t3
      RETURN
      END



      SUBROUTINE sub3

      REAL*8 t1, t2, t3, e1(4)
      COMMON t1, t2, t3, e1, j, k, l

      e1(j) = e1(k)
      e1(k) = e1(l)
      e1(l) = e1(j)
      RETURN
      END





      FUNCTION  secndsmy()

cc      INTEGER*2 hour, minute, second, hundredth
      Real Seconds
      real *8 aux
      CALL CPU_Time(Seconds)

c      aux=dble(Seconds)
      secndsmy= Seconds
c      write (*,5000) aux
c 5000 format (1x, 'current time in seconds = ', g25.11)
c     CALL GETTIM( hour, minute, second, hundredth )
c     secnds = ((DBLE( hour ) * 3600.0) + (DBLE( minute) * 60.0) +
c    +           DBLE( second) + (DBLE( hundredth ) / 100.0))
      END



