{Copyright notes}
{ Free Pascal Whetstone Double Precision Benchmark}
{ (c) Copyright 2002 - 2017 Anatoly S. Krivitsky, Ph.D.}
{All rights reserved}

{Conditional permission for free use of the code}
{ As soon as above copyright notes are mentioned,}
{ the author grants a permission to any person or organization}
{ to use, distribute and publish this code for free}
{ Questions and comments may be directed to the author at}
{ akrivitsky@yahoo.com and akrivitsky@usa.com}

{ Disclaimer of Liability}
{ The user assumes all responsibility }
{ and risk for the use of this code "as is".}
{ There is no  warranty of any kind associated with the code.}
{ Under no circumstances, including negligence, shall the author be liable}
{ for any DIRECT, INDIRECT, INCIDENTAL, SPECIAL or CONSEQUENTIAL DAMAGES,}
{ or LOST PROFITS that result from the use or inability to use the code.}
{ Nor shall the author be liable for any such damages including,}
{ but not limited to, reliance by any person on any }
{ information obtained with the code}



Uses sysutils, math;

const

  edim = 4;
type
vectore = array[1..edim] of extended;

VAR
  BEGIN_TIME,DIF_SAVE,DIF_TIME,ENDDO,END_TIME,ERROR,KILOWHET,PERCENT_ERR,
WHET_ERR, T1, T2, T3,
  WHET_SAVE,X,Y,Z: extended;

 J,I,INNER,ISAVE,KOUNT,MAX_PASS,NPASS,
 N2,N3,N4,N6,N7,N8,N9,N11, K, L,
 OUTER:
longint;
E1 : vectore;
LABEL
  10,20,30,40,50,60,70,80,100;


  Function  SECNDS : extended;
  Var HH,MM,SS,MS: Word;
  Var H1, M1, S1, MS1 : AnsiString;
  Var hint, mint, sint, msint: integer;
  Var sdouble, msdouble: extended;
Begin
  DecodeTime(Time,HH,MM,SS,MS);
  H1 := format('%d',[hh]);
  hint := StrToInt(H1);
  M1 := format('%d',[mm]);
  mint := StrToInt(M1);
  S1 := format('%d',[ss]);
  sint := StrToInt(S1);
  MS1 := format('%d',[ms]);
  msint := StrToInt(MS1);
  msdouble := extended(msint);
  sdouble := extended(hint) * 3600.00 + extended(mint) * 60.0
  + extended(sint) + msdouble/1000.00;
  SECNDS := sdouble;
end;

  Procedure SUB3;
    begin
    E1[J] := E1[K];
    E1[K] := E1[L];
    E1[L] := E1[J];
    end;

Procedure SUB2(X : extended; Y : extended; Z:extended);
   Var X1, Y1 : extended;
Begin
  X1 := X;
  Y1 := Y;
  X1 := (X1 + Y1) * T1;
  Y1 := (X1 + Y1) * T1;
  Z := (X1 + Y1)/T3;
end;

Procedure SUB1(e : vectore);
Var i : integer;
Begin
   for i := 1 to 6 do

   begin  {5}

   e[1] := (e[1]  + e[2] + e[3] - e[4]) * T1;
      e[2] := (e[1]  + e[2] - e[3] + e[4]) * T1;
      e[3] := (e[1]  - e[2] + e[3] + e[4]) * T1;
      e[4] := (-e[1] + e[2] + e[3] + e[4]) / T3;
    end;
    end;

{Body}


  BEGIN;


      NPASS:=0;
      MAX_PASS:=2;

      WRITELN('0Number of inner loops (suggest more than 3):  ');

      READLN(INNER);

      WRITELN(' Number of outer loops (suggest more than 1):  ');

      READLN(OUTER);
      WHILE NPASS < MAX_PASS do {do first}
      begin
      WRITELN(' Pass #', NPASS+1:3, ': ', OUTER:10, ' outer loop(s),', INNER:10);
      WRITELN('____________________________________________');
      KOUNT:=0;
      BEGIN_TIME:=SECNDS;

{C}
{C       Beginning of timed interval}
{C}
      WHILE KOUNT < OUTER do   {do second}
      begin
{C}
{C          Whetstone code begins here.  First initialize variables}
{C          and loop counters based on the number of inner loops.}
{C}
{C          Loops 2 and 3 (described below) use variations of the}
{C          following transformation statements:}
{C}
{C                 x1 = ( x1 + x2 + x3 - x4) * 0.5}
{C                 x2 = ( x1 + x2 - x3 + x4) * 0.5}
{C                 x3 = ( x1 - x2 + x3 + x4) * 0.5}
{C                 x4 = (-x1 + x2 + x3 + x4) * 0.5}
{C}
{C          Theoretically this set tends to the solution}
{C}
{C                 x1 = x2 = x3 = x4 = 1.0}
{C}
{C          The variables t1, t2, and t3 are terms designed to limit}
{C          convergence of the set.}
{C}
      T1:=0.499975E00;
      T2:=0.50025E00;
      T3:=2.0E00;
{C}
{C          The variables n2-n11 are counters for Loops 2-11.}
{C          Based on earlier statistical work (Wichmann, 1970),}
{C          loops 1, 5, and 10 are omitted from the program.}
{C}
      ISAVE:=INNER;
      N2:=12*INNER;
      N3:=14*INNER;
      N4:=345*INNER;
      N6:=210*INNER;
      N7:=32*INNER;
      N8:=899*INNER;
      N9:=616*INNER;
      N11:=93*INNER;
{C}
{C          The values in array e1 are arbitrary.}
{C}
      E1[1]:=1.0E00;
      E1[2]:=-1.0E00;
      E1[3]:=-1.0E00;
      E1[4]:=-1.0E00;
{C}
{C          Loop 1 - Convergence test using real numbers.  The}
{C          execution of this loop was found to be statistically}
{C          invalid, but is included here for completeness.}
{C}
{C          DO i = 1, n1}
{C             x1 = ( x1 + x2 + x3 - x4) * t1}
{C             x2 = ( x1 + x2 - x3 + x4) * t1}
{C             x3 = ( x1 - x2 + x3 + x4) * t1}
{C             x4 = (-x1 + x2 + x3 + x4) * t1}
{C          END DO}
{C}
{C          Loop 2 - Convergence test using array elements.}
{C}
      FOR I:=1 TO N2 DO
      BEGIN
        E1[1]:=(E1[1]+E1[2]+E1[3]-E1[4])*T1;
        E1[2]:=(E1[1]+E1[2]-E1[3]+E1[4])*T1;
        E1[3]:=(E1[1]-E1[2]+E1[3]+E1[4])*T1;
        E1[4]:=(-E1[1]+E1[2]+E1[3]+E1[4])*T1;
      END; {Do}
{C}
{C          Loop 3 - Convergence test using subroutine calls.}
{C}
      FOR I:=1 TO N3 DO SUB1(E1);
{C}
{C          Loop 4 - Conditional jumps.  Repeated iterations}
{C          alternate the value of j between 0 and 1.}
{C}
      J:=1;
      FOR I:=1 TO N4 DO
      BEGIN
        IF J-1 < 0 THEN GOTO 20;
        IF J-1 = 0 THEN GOTO 10;
        IF J-1 > 0 THEN GOTO 20;
10:     J:=2;
        GOTO 30;
20:     J:=3;
30:     IF J-2 < 0 THEN GOTO 50;
        IF J-2 = 0 THEN GOTO 50;
        IF J-2 > 0 THEN GOTO 40;
40:     J:=0;
        GOTO 60;
50:     J:=1;
60:     IF J-1 < 0 THEN GOTO 70;
        IF J-1 = 0 THEN GOTO 80;
        IF J-1 > 0 THEN GOTO 80;
70:     J:=1;
        GOTO 100;
80:     J:=0;
100:      END; {Do}
{C}
{C          Loop 6 - Integer arithmetic and array addressing.}
{C          The values of integers j, k, and l remain unchanged}
{C          through iterations of loop.}
{C}

      J:=1;
      K:=2;
      L:=3;
      FOR I:=1 TO N6 DO
      BEGIN
        J:=J*(K-J)*(L-K);
        K:=L*K-(L-J)*K;
        L:=(L-K)*(K+J);
        E1[L-1]:=extended(J+K+L);
        E1[K-1]:=extended(J*K*L);
      END;

{C}
{C          Loop 7 - Trigonometric functions.  The following loop}
{C          almost transforms x and y into themselves and produces}
{C          results that slowly vary.  (The value of t1 ensures}
{C          slow convergence, as described above.)}
{C}
      X:=0.5E00;
      Y:=0.5E00;
      FOR I:=1 TO N7 DO
      BEGIN

        X:=T1*ARCTAN(T3*SIN(Y)*COS(Y)/(COS(X+Y)+COS(X-Y)-1.0E00));
        Y:=T1*ARCTAN(T3*SIN(Y)*COS(Y)/(COS(X+Y)+COS(X-Y)-1.0E00));
      END; {Do}

{C}
{C          Loop 8 - Subroutine calls.  Values of x, y, and z}
{C          are arbitrary.}
{C}
      X:=1.0E00;
      Y:=1.0E00;
      Z:=1.0E00;
      FOR I:=1 TO N8 DO SUB2(X,Y,Z);

{C}
{C          Loop 9 - Array references and subroutine calls.}
{C}

      J:=1;
      K:=2;
      L:=3;
      E1[1]:=1.0E00;
      E1[2]:=2.0E00;
      E1[3]:=3.0E00;
      FOR I:=1 TO N9 DO SUB3;

{C}
{C          Loop 10 - Simple integer arithmetic.  The execution}
{C          of this loop was found to be statistically invalid,}
{C          but is included here for completeness.}
{C}
{C          j = 2}
{C          k = 3}
{C          DO i = 1, n10}
{C             j = j + k}
{C             k = j + k}
{C             j = j - k}
{C             k = k - j - j}
{C          END DO}
{C}
{C          Loop 11 - Standard functions DSQRT, DEXP, and DLOG.}
{C}
      X:=0.75E00;
      FOR I:=1 TO N11 DO
      X:=SQRT(EXP(LN(X)/T2));

{C}
{C          End of Whetstone code.}
{C}
      INNER:=ISAVE;
      KOUNT:=KOUNT+1;
      END; {Do second}
{C}
{C       End of timed interval}
{C}
      END_TIME:=SECNDS;
      DIF_TIME:=END_TIME-BEGIN_TIME;
{C}
{C       1000 whetstones (kilowhetstones) = 100 * loops per second}
{C}
      KILOWHET:=100.0E+00*extended(OUTER*INNER)/DIF_TIME;
{     WRITE (*,9300)DIF_TIME,KILOWHET}
      WRITELN(' Elapsed time =',DIF_TIME:12:2,' seconds Whetstones  '
      +' =',KILOWHET:12:2);
{C}
{C       Repeat with inner count doubled.}
{C}
      NPASS:=NPASS+1;
      IF NPASS < MAX_PASS THEN
      BEGIN
        DIF_SAVE:=DIF_TIME;
        WHET_SAVE:=KILOWHET;
        INNER:=INNER*MAX_PASS;
        END;
      END; {Do FIRST}
{C}
{C    Compute sensitivity.}
{C}
      ERROR:=DIF_TIME-(DIF_SAVE*MAX_PASS);
      WHET_ERR:=WHET_SAVE-KILOWHET;
      PERCENT_ERR:=WHET_ERR*100.0E+00/KILOWHET;

      WRITELN('____________________________________________');
      WRITELN(' Time error   =',ERROR:12:2,' seconds Whet error  '
      +' =',WHET_ERR:12:2,' kwhets/sec');
      WRITELN('% error   =',PERCENT_ERR:12:2);
      IF (DIF_TIME < 10.0E00) THEN
      BEGIN
        WRITELN('TIME is less than 10 seconds -- ','suggest larger inner loop');
      END;

END.