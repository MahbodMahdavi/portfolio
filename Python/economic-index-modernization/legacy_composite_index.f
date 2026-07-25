
Conversation opened. 3 messages. 3 messages unread.

Skip to content
Using DEPARTMENT OF THE INTERIOR Mail with screen readers
Conversations
8% full
Using 2.65 GB of your 30 GB
Program Policies
Powered by Google
Last account activity: 0 minutes ago
Details

C     NHCOMP  --  COMPOSITE INDEX PROGRAM  -  WRITTEN BY BDK
C      COMPUTES COMPOSITE INDEXES BY 1 OF 3 METHODS OF STANDARDIZATION
C      converted to run using comets databank by BDK -- 3/28/89
C     LAST CHANGED ON 16 FEB. 1993 BY C. ROBINSON
C     PUTREC NEEDED FURTHER WORK -- C. ROBINSON
C 
C     Copy of Compy2kx.for
C     Modified on 05/27/14 to increase time span to 1014 months

      REAL ISF
      INTEGER XSP, CSPMO(50,12), CSPYR(50,12)
      INTEGER BEOS(50), SERMA(50), CSFMA(50)
      INTEGER FYEAR, BMA, BASEYR, YR, REPEAT, SSP1, SSP2, TRFLAG
      INTEGER BWFLAG(50), CIWT, CSFMTH, SSFMTH(50)
      INTEGER *2 IMON, IDAY, IHR, IMIN, ISEC, IHSEC
      CHARACTER *4 AMPM, AM, PM, IDS*9(18), TEMPVAR
      CHARACTER*40 INPUTFILE, OUTPUTFILE 
C
      LOGICAL ANN
C
      DIMENSION KTITL(24), ID1(50), METHOD(50), CSF(50), ID2(50),
     &          KSPAN(50), KCHG(50), INVERT(50), WT(50),
     &          KEOS(50), BSW(50), MCSP(50),
     &          SSF(50)
      DIMENSION SERBWT(50,12), SERWT(12), KN(8), KNN(8)
C
      COMMON /READW/ DATA(1014,18), IDS, IDECML(18) 
      COMMON /SREC/ IPOUT(48), SERIES(1014), KFOUND
      COMMON /INPUT/ ARRAY(1014), I1, I2, KPRNT
      COMMON /WORK/ CINDEX(1014), SUMPOS(1014), AVCH(1014), SUMW(1014),
     &              TOTAL(1014)
      COMMON /PARAM/ AVWOS(10), AV(10), SD(10),
     &               XSP(10), NXSP, FLEXSF(1014)
      COMMON /REF/ REFSER(1014), IR1, IR2, CCWT
      COMMON /IOFILES/  INPUTFILE, OUTPUTFILE 
C
      DATA K4BL/4H    /, K3BL/3H   /, KNEG/3HNEG/, KPOS/3HPOS/,
     &     KE/1HE/, K1BL/1H /
      DATA SERMA/50*0/,
     &     KCHG/50*0/, INVERT/50*0/, WT/50*0.0/,
     &     BEOS/50*1H /, BWFLAG/50*0/,
     &     ID1/50*3H   /, ID2/50*3H   /
      DATA AMPM/'    '/, AM/'A.M.'/, PM/'P.M.'/
C
C
C     -------------------------------------------------------------------
C     FIRST CALL TO CGTREC IS TO ALLOW USER TO SPECIFY DATABANK(S)
    8 ANN = .FALSE.   
      WRITE (6,FMT='(22H ENTER INPUT FILE NAME)')
      READ (5,FMT='(A40)') INPUTFILE 
      TEMPVAR = INPUTFILE(1:4)
      IF (TEMPVAR .EQ. K4BL) STOP
C      'E:\TEMP\PRIMARYA.TXT'
      WRITE (6,FMT='(23H ENTER OUTPUT FILE NAME)')
      READ (5,FMT='(A40)') OUTPUTFILE 
      CALL READWK (INPUTFILE)
C
      KSTOR = 0
      DO 7 I = 1, 50
       ID1(I) = 0
       ID2(I) = 0
       KCHG(I) = 0
       INVERT(I) = 0
       METHOD(I) = 0
       WT(I) = 0.0
       SERMA(I) = 0
       BWFLAG(I) = 0
       BEOS(I) = K1BL
       KSPAN(I) = 0
       KEOS(I) = K1BL
       CSF(I) = 0.0
       MCSP(I) = 0
       CSFMA(I) = 0
       SSF(I) = 0.0
       SSFMTH(I) = 9
   7  CONTINUE
C
   9  WRITE(6,10)
   10 FORMAT(//' COMPOSITE INDEX PROGRAM -- LAST CHANGE 3 JULY 2001 '/
     & ' ENTER 80 CHARACTER TITLE')
      READ(5,15) KTITL
   15 FORMAT( 20A4 )
      IF(KTITL(1) .EQ. K4BL) STOP
C
      WRITE(6,20)
  20  FORMAT(' ENTER START YR,FIRST PRNT YR,PRINT OPTION,REPEAT OPTION'/
     &       ' IIII IIII I I')
      READ(5,25) FYEAR,KFPRYR,KPRNT,REPEAT,KDUMP
   25 FORMAT( 2(I4,1X), 2(I1,1X), I1 )
      IF( FYEAR .LT. 1945 ) FYEAR = 1948
      IF( KFPRYR .EQ. 0 ) KFPRYR = FYEAR
      IF( FYEAR .GT. KFPRYR ) STOP
C
      WRITE(6,26)
   26 FORMAT(' ENTER INDEX ST PERIOD,INDEX ST METHOD,ISF MA,COMPONENT',
     & ' ST PERIOD,' /' BASE YR,ISF,TREND,TURNPT,INDEX WT,CCORR,3DS'/
     & ' YYYYMM YYYYMM I II - YYYYMM YYYYMM - YYYY FFFFFF FFFFFF')
C     & ' I I I II')
      READ(5,28) IY1,IM1,IY2,IM2, IMETH,ISFMA, ICY1,ICM1,ICY2,ICM2,
     &           BASEYR,ISF,TREND,TRFLAG,CIWT,ICCORR,IOPTSM,ICUMSM
   28 FORMAT( 2(I4,I2,1X), I1, 1X,I2, 2X, 2(1X,I4,I2), 3X,I4, 2(1X,F6.0),
     &        4(1X,I1), I1 )
C
      IF(IY1 .EQ. 0 .OR. IM1 .EQ. 0) STOP
      IF(BASEYR .EQ. 0)  BASEYR = 1977
      IF(ICCORR .EQ. 1) CALL REFNCE
C
C     SERIES STANDARDIZATION PERIOD
      SSP1 = (ICY1 - 1945)*12 + ICM1
      SSP2 = (ICY2 - 1945)*12 + ICM2
C     INDEX STANDARDIZATION PERIOD
      ISP1 = (IY1 - 1945)*12 + IM1
      ISP2 = (IY2 - 1945)*12 + IM2
      IF(KSTOR .EQ. 1) GO TO 62
C
      NN = 0
      WRITE(6,30)
  30  FORMAT(' ENTER SERIES ID,TYPE CHG,INVERT,METHOD,ST. FACTOR MA,'/
     & ' WEIGHT,SERIES MA,WT,EOS - SPAN - EOS,CSF,CSP'/
     & ' AAAAAA I I I II FFFFFF IIWE IIE FFFFFF I')
C
C     READ INPUT IDS AND PARAMETERS
  40  NN = NN + 1
      READ(5,50) ID1(NN), ID2(NN), KCHG(NN), INVERT(NN),
     &           METHOD(NN), CSFMA(NN), WT(NN),
     &           SERMA(NN), BWFLAG(NN), BEOS(NN), KSPAN(NN), KEOS(NN),
     &           CSF(NN), MCSP(NN)
   50 FORMAT( 2A3, 3(1X,I1), 1X,I2, 1X,F6.3, 1X,I2, I1,A1, 1X,I2,A1,
     &        1X, F6.3, 1X,I1)
      IF(KDUMP .EQ. 9)  WRITE(6,55) NN, ID1(NN), ID2(NN)
   55 FORMAT( ' ', I6, 2A3 )
      IF( CSFMA(NN) .GT. 0 .AND. CSF(NN) .GT. 0.0 ) STOP
      IF( ID1(NN) .EQ. K3BL .AND. NN .EQ. 1 ) STOP
      IF( ID1(NN) .EQ. K3BL ) GO TO 60
      GO TO 40
C
C     CHECK INPUT IDS AND PARAMETERS AND ADD SERIES IF NECESSARY
  60  N = NN
      NN = NN - 1
  62  WRITE(6,65)
  65  FORMAT(/' CHECK INPUT; IF ERROR, ENTER LINE NO. OF ERROR'/' II')
      READ(5,70) KK
  70  FORMAT(I2)
      IF(KK .EQ. 0) GO TO 80
      IF(KK .GT. N) GO TO 8
      WRITE(6,74) KK
  74  FORMAT(' FOR LINE NUMBER - ',I2)
      WRITE( 6,30)
      READ(5,50) ID1(KK), ID2(KK), KCHG(KK), INVERT(KK),
     &           METHOD(KK), CSFMA(KK), WT(KK),
     &           SERMA(KK), BWFLAG(KK), BEOS(KK), KSPAN(KK),
     &           KEOS(KK), CSF(KK), MCSP(KK)
      IF(KK .LT. N) GO TO 62
C     ADD SERIES TO LIST
      NN = NN + 1
      N = N + 1
      GO TO 62
C
C     DEFAULT VALUES FOR WEIGHT, SERMA, SPAN
  80  DO 85 I = 1, NN
       IF( WT(I) .EQ. 0.0 ) WT(I) = 1.000
       IF( SERMA(I) .EQ. 0 ) SERMA(I) = 1
       IF( KSPAN(I) .EQ. 0 ) KSPAN(I) = 1
       BSW(I) = FLOAT( SERMA(I) )
      IF(I .EQ. 1) GO TO 85
      IF(REPEAT .EQ. 0) GO TO 85
C
C     PARAMS FOR FIRST SERIES ARE USED FOR REMAINING SERIES
       WT(I) = WT(1)
       SERMA(I) = SERMA(1)
       BWFLAG(I) = BWFLAG(1)
       BEOS(I) = BEOS(1)
       KSPAN(I) = KSPAN(1)
       KEOS(I) = KEOS(1)
       CSFMA(I) = CSFMA(1)
      IF(KDUMP .EQ. 9) WRITE(6,105) WT(I),SERMA(I),BSW(I),
     &                              KSPAN(I)
  105 FORMAT('  ',3(F7.3,I6))
   85 CONTINUE
C
      DO 86 I = 1, 50
      DO 88 J = 1, 12
       SERBWT(I,J) = 1.0
       IF(J .GT. 10) GO TO 88
       CSPMO(I,J) = 0
       CSPYR(I,J) = 0
  88  CONTINUE
  86  CONTINUE
C
C
C     ENTER WEIGHTS FOR SERIES MA
      DO 138 I = 1, NN
       IF(BWFLAG(I) .EQ. 0) GO TO 138
       NB = SERMA(I)
       IF( I .GT. 1 .AND. REPEAT .EQ. 1 ) GO TO 162
       WRITE(6,135) ID1(I), ID2(I)
  135  FORMAT(' FOR SERIES ', 2A3, ' ENTER WEIGHTS FOR MOVING AVERAGE'/
     &        ' ', 12('FFFFFF '))
       READ(5,134) ( SERBWT(I,J), J = 1,NB )
  134  FORMAT( 12(F6.3,1X) )
       BSW(I) = 0.0
       DO 124 K = 1, NB
        BSW(I) = BSW(I) + SERBWT(I,K)
  124  CONTINUE
      GO TO 138
C
C     SERIES 1 BASE WEIGHTS ARE USED FOR REMAINING SERIES
  162  DO 128 J = 1, NB
        SERBWT(I,J) = SERBWT(1,J)
  128  CONTINUE
       BSW(I) = BSW(1)
  138 CONTINUE
C
C     ENTER MULTIPLE COMPONENT STND. PERIODS
      DO 360 II = 1, NN
       IF(MCSP(II) .EQ. 0) GO TO 360
       WRITE(6,350) ID1(II), ID2(II)
  350  FORMAT(' ENTER COMPONENT STND. PERIODS FOR ',2A3/
     &        ' ', 5('YYYYMM YYYYMM-'))
       READ(5,352) ( CSPYR(II,I), CSPMO(II,I), I = 1,10 )
  352  FORMAT( 10(I4,I2,1X) )
  360 CONTINUE
C
      DO 120 I = 1, 1014
       ARRAY(I) = 0.0
       TOTAL(I) = 0.0
       SUMW(I) = 0.0
       CINDEX(I) = 0.0
       SUMPOS(I) = 0.0
       AVCH(I) = 0.0
  120 CONTINUE
C
C     DETERMINE STARTING YEAR,MONTH  SUBSCRIPT
      ISTART = (FYEAR - 1945)*12 + 1
      ILAST = 1
      IFIRST = 1014
C
C     MAIN PROGRAM: FOR EACH COMPONENT, GET DATA, COMPUTE STANDARDIZED,
C      WEIGHTED SYMMETRICAL PERCENT CHANGES OR DIFFERENCES,AND ADD THEM
C      TO TOTAL
C
      WRITE(6,186)
  186 FORMAT(/' ',7X,'AVWOS',5X,'AVERAGE',4X,'STND DEV',7X,'DATA USED',
     &            4X,' AVDR'/)
C
      DO 200 II = 1, NN
       ANN = .FALSE.
  196  CALL GETSER( ID1(II), ID2(II) )
       IF( KFOUND .NE. 500 ) GO TO 198
       WRITE(6,192)
  192  FORMAT(' RE-ENTER ID'/' AAAAAA')
       READ(5,194) ID1(II), ID2(II)
  194  FORMAT( 2A3 )
       IF(ID1(II) .EQ. K3BL) STOP
       GO TO 196
  198 IF( IPOUT(38) .EQ. 3 ) CALL QPOL
       KK1 = (IPOUT(35) - 1945)*12 + IPOUT(34)
       IF(KK1 .LT. ISTART) KK1 = ISTART
       KK2 = (IPOUT(37) - 1945)*12 + IPOUT(36)
       KDEC = IPOUT(39)
C
      DO 188 I = 1, 12
       SERWT(I) = SERBWT(II,I)
  188 CONTINUE
C
C     SET SERIES STANDARDIZATION PERIODS
      NXSP = 0
      DO 189 I = 1, 10
       IF( CSPYR(II,I) .EQ. 0 .OR. CSPMO(II,I) .EQ. 0 ) GO TO 189
       XSP(I) = ( CSPYR(II,I) - 1945 )*12 + CSPMO(II,I)
       IF( XSP(I) .NE. 0 ) NXSP = NXSP + 1
  189 CONTINUE
      IF( MOD(NXSP,2) .EQ. 1 ) STOP
      IF( NXSP .EQ. 0 ) THEN
        NXSP = 2
        XSP(1) = SSP1
        XSP(2) = SSP2
      ENDIF
C
       IF( KPRNT .GT. 2 ) WRITE(6,190) ID1(II), ID2(II)
  190  FORMAT(/' SERIES '2A3)
       IF( KPRNT .GT. 2 ) CALL PRINT( SERIES, KK1, KK2, KDEC, KFPRYR )
C
      CALL MAVG( SERMA(II), KK1, KK2, SERWT, BSW(II) )
      IF( ICCORR .EQ. 1 ) CALL CCORR( INVERT(II) )
      IF( ICCORR .EQ. 1 ) WT(II) = CCWT
       IF( KPRNT .GT. 2 ) CALL PRINT( ARRAY, I1, I2, KDEC, KFPRYR )
      CALL PCTDIF( KCHG(II), KSPAN(II), KEOS(II), INVERT(II) )
       IF( KPRNT .GT. 2 ) CALL PRINT( ARRAY, I1, I2, 3, KFPRYR )
      CSFMTH = METHOD(II)
      CALL STAT( SSP1, SSP2 )
      IF( CSFMA(II) .EQ. 0 ) GO TO 153
       CALL MOVEAV( CSFMA(II), METHOD(II) )
       CSFMTH = 4
  153 IF( CSF(II).NE.0.0 ) CSFMTH = 3
      CALL WTSF( CSFMTH, WT(II), CSF(II), SF )
      SSF(II) = SF
      SSFMTH(II) = CSFMTH
       IF( KPRNT .GT. 1 ) CALL PRINT( FLEXSF, I1, I2, 3, KFPRYR )
       IF( KPRNT .GT. 1 ) CALL STAT( SSP1, SSP2 )
       IF( KPRNT .GT. 1 ) CALL PRINT( ARRAY, I1, I2, 3, KFPRYR )
C
      DO 160 I = I1, I2
       TOTAL(I) = TOTAL(I) + ARRAY(I)
       SUMW(I) = SUMW(I) + WT(II)
       IF( ARRAY(I) .LT. 0.0 ) GO TO 155
        AMT = WT(II)
        IF( ARRAY(I) .EQ. 0.0 ) AMT = WT(II)/2.0
        SUMPOS(I) = SUMPOS(I) + AMT
  155  ARRAY(I) = 0.0
  160 CONTINUE
C
      IF( I2 .GT. ILAST ) ILAST = I2
      IF( I1 .LT. IFIRST ) IFIRST = I1
C
  200 CONTINUE
C
      IF( IFIRST .GT. ISTART ) ISTART = IFIRST
      IF( ISTART .GT. ILAST ) STOP
      WRITE(6,250)
  250 FORMAT('  ')
C
C     COMPUTE COMPOSITE INDEX
      I1 = ISTART
      I2 = ILAST
      ISAVE = NXSP
      NXSP = 1
      IF( KPRNT .GT. 2 ) CALL PRINT( SUMPOS, ISTART, ILAST, 3, KFPRYR )
      IF( KPRNT .GT. 2 ) CALL PRINT( TOTAL, ISTART, ILAST, 3, KFPRYR )
      IF( KPRNT .GT. 2 ) CALL PRINT( SUMW, ISTART, ILAST, 3, KFPRYR)
      DO 150 I = ISTART, ILAST
       ARRAY(I) = TOTAL(I)/ SUMW(I)
  150 CONTINUE
      IF( KPRNT .GT. 2 ) CALL PRINT( ARRAY, ISTART, ILAST, 3, KFPRYR )
      CALL STAT( ISP1, ISP2 )
      IF(ISFMA .EQ. 0) GO TO 220
       CALL MOVEAV( ISFMA, IMETH )
       IMETH = 4
  220 IF( ISF .NE. 0.0 ) IMETH = 3
      CALL WTSF( IMETH, 1.0, ISF, SF )
       IF( KPRNT .GT. 1 ) CALL PRINT( FLEXSF, ISTART, ILAST, 3, KFPRYR )
       IF( KPRNT .GT. 2 ) CALL PRINT( ARRAY, ISTART, ILAST, 3, KFPRYR )
       IF( KPRNT .GT. 2 ) CALL STAT( ISP1, ISP2 )
      DO 145 I = ISTART, ILAST
       AVCH(I) = ARRAY(I)
  145 CONTINUE
      IF( CIWT .EQ. 1 ) CALL INDXWT( NN )
      IF( KPRNT .GT. 2 ) CALL PRINT( ARRAY, ISTART, ILAST, 3, KFPRYR )
      IF( TREND .NE. 0.0) CALL CONST1( TREND )
      CALL STAT( ISP1, ISP2 )
      NXSP = ISAVE
C
C     CUMULATE AND REBASE THE INDEX
      CALL CUM( BASEYR )
C
C
C     PRINT THE COMPOSITE INDEX
  244 IF( KPRNT .EQ. 9 ) GO TO 300
      WRITE(6,245)
  245 FORMAT(//' SET PAPER')
      READ(5,248) KDUM
  248 FORMAT( A4)
C
C     USES MICROSOFT TIME AND DATE ROUTINES
      CALL GETTIM (IHR,IMIN,ISEC,IHSEC)
      CALL GETDAT (IYR,IMON,IDAY)
      AMPM = AM
      IF(IHR .GE. 12) AMPM = PM
      IHR = MOD(IHR,12)
      IF(IHR .EQ. 0) IHR = 12
      IYR = IYR - (IYR/100 * 100)
C
      WRITE(6,252) IMON, IDAY, IYR, IHR, IMIN, AMPM
  252 FORMAT(/' BUSINESS OUTLOOK DIVISION'/
     &        ' BUSINESS CYCLE INDICATORS BRANCH'/
     &        ' ', 2(I2,'/'), I2, 4X, I2, ':', I2, 1X, A //)
c
      WRITE( 6, 255 )
  255 FORMAT(5X,'SERIES  INV   CHG  WEIGHT       CSF  METHOD'/)
      DO 260 I = 1, NN
       WRITE(6,265) ID1(I), ID2(I), INVERT(I), KCHG(I),
     &              WT(I), SSF(I), SSFMTH(I)
  265  FORMAT( ' ', 4X,2A3, 3X,I1, 5X,I1, 2X,F6.3, 1X,F10.3, 4X,I1 )
  260 CONTINUE
C
      WRITE(6,280) ICM1, ICY1, ICM2, ICY2
  280 FORMAT(/5X,'COMPONENT ST. PERIOD =  ',I2,'/',I4,'  -  ',I2,'/',I4)
      WRITE(6,281) IM1, IY1, IM2, IY2
  281 FORMAT(5X,' INDEX STAND. PERIOD =  ',I2,'/',I4,'  -  ',I2,'/',I4)
      WRITE(6,284) BASEYR
  284 FORMAT(/5X,'REBASING YEAR =  ',I4/)
      WRITE(6,287) SF, IMETH
  287 FORMAT(5X,'INDEX STAND. FACTOR = ',F8.3, 1X,'(',I1,')')
      WRITE(6,288) TREND
  288 FORMAT(5X,'TREND ADJ. FACTOR = ',F8.3//)
      WRITE(6,290) KTITL
  290 FORMAT(/1X,24A4/) 
      CALL PRINT( CINDEX, ISTART, ILAST, 3, KFPRYR )
C
C     STORE THE OUTPUT SERIES
  300 KSTART = ISTART - 1
      ANN = .FALSE.
      CALL SEROUT( IDF, IDL, ANN, KSTART, ILAST, KTITL, 1 )
      IF( IOPTSM .EQ. 0 ) GO TO 362
C
C     COMPUTE STRENGHT OF MOVEMENT
      CALL SMOVE( IOPTSM, ICUMSM )
      WRITE(6,245)
      READ(5,248) KDUM
      WRITE(6,246) IOPTSM
  246 FORMAT(' STRENGHT OF MOVEMENT -- OPTION = ',I2/)
      CALL PRINT( CINDEX, ISTART, ILAST, 3, KFPRYR )
      ANN = .FALSE.
      CALL SEROUT( IDF, IDL, ANN, ISTART, ILAST, KTITL, 3 )
C
  362 WRITE(6,363)
  363 FORMAT(//' STORE INPUT IDS -- YES, ENTER 1')
      READ(5,364) KSTOR
  364 FORMAT(I1)
C
      IF( TRFLAG .EQ. 0 .AND. KSTOR .EQ. 0 ) GO TO 8
      IF( TRFLAG .EQ. 0 .AND. KSTOR .EQ. 1 ) GO TO 9
C
C     TREND ADJUST BY METHOD OF CYCLICAL AVERAGES
      ANN = .FALSE.
C     CALL CGTREC( IDF, IDL, ANN )
      CALL GETSER( IDF, IDL )
C      STOP
C      IF( KFOUND .EQ. 500 ) GO TO 8
      CALL TURNPT( KPRNT )
      WRITE(6,400) IDF, IDL
  400 FORMAT(/' ENTER TARGET ID AND ITS CYCLE DATES,THEN ENTER CYCLE',
     &        ' DATES FOR SERIES ',2A3 /' AAAAAA', 8(' YYYYMM'))
      READ(5,410) ID3, ID4, KN, KNN
  410 FORMAT( 2A3, 8(1X,I4,I2) )
      CALL TRCOMP( TREND2, KNN )
       IF( ID3 .EQ. K3BL .AND. KSTOR .EQ. 0 ) GO TO 8
       IF( ID3 .EQ. K3BL .AND. KSTOR .EQ. 1 ) GO TO 9      
       
C     CALL CGTREC( ID3, ID4, ANN ) 
      IPOUT(29) = ID3
      IPOUT(30) = ID4
      CALL GETSER( ID3, ID4 )
C      STOP
C      IF( KFOUND .EQ. 500 ) GO TO 8
      CALL TRCOMP( TREND1, KN )
      TREND = TREND1 - TREND2
      DO 420 I = ISTART, ILAST
       ARRAY(I) = AVCH(I) + TREND
  420 CONTINUE
      CALL CUM( BASEYR )
      TRFLAG = 0
      GO TO 244
      END
C
C
C
C
      SUBROUTINE PRINT( TDUM, KK1, KK2, KDEC, KFPRYR )
      CHARACTER *4 KFMT(5), KDFMT(5)
      CHARACTER*40 INPUTFILE, OUTPUTFILE 
      DIMENSION TDUM(1014)
      INTEGER FYR
      COMMON /IOFILES/  INPUTFILE, OUTPUTFILE 
C
      DATA  KFMT/ '(1X,', ' I4,', '12F9', '.0  ', '   )'/
      DATA KDFMT/ '.0  ', '.1  ',  '.2  ', '.3  ', '.4  '        / 
      OPEN (UNIT=8, FILE=OUTPUTFILE, MODE='WRITE', 
     &STATUS='UNKNOWN', ACCESS='SEQUENTIAL')
C
      IF(KDEC .GT. 4) KDEC = 4
      KFMT(4) = KDFMT(KDEC + 1)
      K1 = (KK1 - 1)/12*12 + 1
      KF = (KFPRYR - 1945)*12 + 1
      IF(KF .LT. K1) KF = K1
      FYR = KF/12  + 1945
C
      DO 50 I = KF, KK2
C       J1 = I
C       J2 = J1 + 11
C       IF(J2 .GT. KK2) J2 = KK2 
      K1 = MOD(I,12)
      IF (K1 .EQ. 0) K1 = 12
      KDATE = ((I-1)/12+1945)*100+K1
        WRITE(8,FMT='(I7,F12.3)') KDATE, TDUM(I)
C        FYR = FYR + 1
   50 CONTINUE
      WRITE(8,60)
   60 FORMAT(/'  ')
      RETURN
      END
C
C
C
      SUBROUTINE CONST1( X )
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      DO 40 I = I1, I2
       ARRAY(I) = ARRAY(I) + X
   40 CONTINUE
      RETURN
      END
C
C
C
      SUBROUTINE MAVG( MA, KK1, KK2, SERWT, WTSUM )
      DIMENSION SERWT(12)
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      COMMON /SREC/ IPOUT(48),SERIES(1014),IDC
C
      IF(KPRNT .GT. 2) WRITE(6,10) ( SERWT(J), J = 1,MA)
   10 FORMAT(' WEIGHT(S) = ',12F10.3)
C
      I1 = 0
      I2 = 0
      DO 20 I = 1, 1014
       ARRAY(I) = 0.0
   20 CONTINUE
      KLAST = KK2 - MA + 1
      I1 = KK1 + MA/2
C
      DO 50 K = KK1, KLAST
       LL = K + MA/2
       I = K
       SUM = 0.0
       KK = 0
      DO 40 II = 1, MA
       KK = KK + 1
       SUM = SUM + SERIES(I)*SERWT(KK)
       I = I + 1
   40 CONTINUE
      ARRAY(LL) = SUM/WTSUM
   50 CONTINUE
C
      I2 = LL
      RETURN
      END
C
C
C
      SUBROUTINE PCTDIF( NCHG, NSPAN, NKEOS, NVERT )
      DIMENSION DUMSER(1014)
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      DATA KE/1HE/
C
      DO 50 I = 1, 1014
       DUMSER(I) = 0.0
  50  CONTINUE
C
      DO 100 I = I1, I2
       BASE = ARRAY(I)
       LAST = I + NSPAN
      IF(LAST .GT. I2) GO TO 100
       TERM = ARRAY(LAST)
       LL = LAST - NSPAN/2
      IF(NKEOS .EQ. KE) LL = LAST
      IF(I .EQ. I1) K1 = LL
       DUMSER(LL) = TERM - BASE
      IF(NCHG .EQ. 1) GO TO 90
       DUMSER(LL) = 200.0*(TERM - BASE)/(TERM + BASE)
   90  IF(NVERT .EQ. 1) DUMSER(LL) = DUMSER(LL)*( - 1.0)
  100 CONTINUE
C
      K2 = LL
      DO 60 I = 1, 1014
       ARRAY(I) = 0.0
   60 CONTINUE
      DO 70 I = K1, K2
       ARRAY(I) = DUMSER(I)
  70  CONTINUE
      I1 = K1
      I2 = K2
      RETURN
      END
C
C
C
      SUBROUTINE WTSF( METHD, WEIGHT, XSF, SF )
      INTEGER XSP
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      COMMON /PARAM/ AVWOS(10), AV(10), SD(10),
     &               XSP(10), NXSP, FLEXSF(1014)
C
      IF( METHD .LT. 0 .OR. METHD .GT. 4 ) WRITE(6,10) METHD
   10 FORMAT(' METHOD IS INCORRECT ',I3)
      IF(KPRNT .GT. 2) WRITE(6,5) METHD
   5  FORMAT(/' METHOD = ',I3)
      KK = METHD + 1
C
      DO 100 II = 1, NXSP, 2
       N = (II + 1)/2
       II2 = II + 2
       IB = XSP(II)
       IE = XSP(II + 1)
        IF( II  .EQ. 1 ) IB = I1
        IF( II2 .GT. NXSP ) IE = I2
        IF(IB .LT. I1 ) IB = I1
        IF(IE .GT. I2 ) IE = I2
C
      DO 70 I = IB, IE
      GO TO ( 20, 30, 30, 40, 50 ), KK
  20   FLEXSF(I) = AVWOS(N)
        GO TO 70
  30   FLEXSF(I) = SD(N)
        GO TO 70
  40   FLEXSF(I) = XSF
  50   CONTINUE
  70  CONTINUE
C
      DO 60 I = IB, IE
       IF(KK .EQ. 3) ARRAY(I) = ARRAY(I) - AV(N)
       ARRAY(I) = ARRAY(I) *WEIGHT /FLEXSF(I)
   60 CONTINUE
  100 CONTINUE
C
      SF = FLEXSF(IE)
      RETURN
      END
C
C
C
      SUBROUTINE STAT( SP1, SP2 )
      INTEGER SP1, SP2, XSP
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      COMMON /PARAM/ AVWOS(10), AV(10), SD(10),
     &               XSP(10), NXSP, FLEXSF(1014)
C
      DO 90 I = 1, 10
       AVWOS(I) = 0.0
       AV(I) = 0.0
       SD(I) = 0.0
   90 CONTINUE
C
      DO 100 II = 1, NXSP, 2
       KK = (II + 1)/2
C
      TOT = 0.0
      TOTWOS = 0.0
      TOTSQ = 0.0
C
      IB = XSP(II)
      IE = XSP(II + 1)
      IF( NXSP .EQ. 1 ) THEN
        IB = SP1
        IE = SP2
       ENDIF
      IF(I1 .GT. IB) IB = I1
      IF(I2 .LT. IE) IE = I2
C
      N = 0
      DO 40 I = IB, IE
       N = N + 1
       TOT = TOT + ARRAY(I)
       TOTWOS = TOTWOS + ABS( ARRAY(I) )
       TOTSQ = TOTSQ + ( ARRAY(I)**2 )
   40 CONTINUE
      XN = FLOAT(N)
      AV(KK) = TOT/XN
      AVSQ = AV(KK)**2
      AVWOS(KK) = TOTWOS/XN
      SD(KK) = ((TOTSQ - (XN*AVSQ))/(XN - 1.))**0.5
C
      CALL XAVDR( AVDR, IB, IE )
      CALL DATE( IB, M1, IY1 )
      CALL DATE( IE, M2, IY2 )
      WRITE( 6,60 ) AVWOS(KK), AV(KK), SD(KK), IY1,M1,IY2,M2, AVDR
   60 FORMAT(' ', 3(F12.3),4X, I4,'/',I2,' TO ',I4,'/',I2, 1X,F6.1)
  100 CONTINUE
C
      RETURN
      END
C
C
C
      SUBROUTINE XAVDR( AVDR, IB, IE )
      INTEGER OLD
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
C
      K1 = IB + 2
      N = 1
      OLD = 0
      IF(ARRAY(IB + 1) .GT. ARRAY(IB)) OLD = 1
C
      DO 50 I = K1, IE
       NEW = 0
       IF(ARRAY(I) .GT. ARRAY(I - 1)) NEW = 1
       IF(NEW .EQ. OLD) GO TO 50
       N = N + 1
       OLD = NEW
   50 CONTINUE
      AVDR = FLOAT(IE - IB)/FLOAT(N)
      RETURN
      END
C
C
C
      SUBROUTINE DATE( II, IMO, IYR )
      IMO = MOD( II, 12 )
      IF(IMO .EQ. 0) IMO = 12
      IYR = (II - 1)/12 + 1945
      RETURN
      END
C
C
C
      SUBROUTINE TURNPT( KPRNT )
      CHARACTER *4 HILO(2), NAME
      INTEGER HIGH, YR, GT
      DIMENSION LOW(50), HIGH(50), IDUM(50), W5MA(1014),
     &          MO(12), YR(12), WT(5)
C
      COMMON /SREC/ IPOUT(48),SERIES(1014),KFOUND
      DATA HILO/ 'HIGH', ' LOW'/,   NAME/'    '/
      DATA WT/ 1.0, 2.0, 7.0, 2.0, 1.0 /
C
      DO 20 I = 1, 50
       HIGH(I) = 0
       LOW(I) = 0
       IDUM(I) = 0
   20 CONTINUE
      DO 30 I = 1, 1014
       W5MA(I) = 0.0
   30 CONTINUE
C
C     COMPUTE 5 MONTH WEIGHTED AVERAGE
      ISTART = (IPOUT(35) - 1945)*12 + IPOUT(34)
      ILAST = (IPOUT(37) - 1945)*12 + IPOUT(36)
      IDEC = IPOUT(39)
      IF(KPRNT .GT. 2) CALL PRINT( SERIES, ISTART, ILAST, IDEC, 47 )
      IB = ISTART + 2
      IE = ILAST - 2
      DO 60 I = IB,IE
       N = I - 3
       SUM = 0.0
      DO 50 J = 1,5
       N = N + 1
       SUM = SUM + SERIES(N)*WT(J)
   50 CONTINUE
      W5MA(I) = SUM/13.0
   60 CONTINUE
C
C     ROUND W5MA
      DO 55 I = IB,IE
       W5MA(I) = W5MA(I) + (5.0/10.0**(IDEC + 1))
       KSER = IFIX(W5MA(I)*10.0**IDEC)
       W5MA(I) = FLOAT(KSER)/10.0**IDEC
   55 CONTINUE
      KDEC = IDEC + 1
      IF(KPRNT .EQ. 0) GO TO 65
      WRITE(6,66)
   66 FORMAT(/' SMOOTHED SERIES')
      CALL PRINT( W5MA, IB, IE, KDEC, 47 )
C
   65 NH = 0
      NL = 0
      DO 100 I = IB, IE
       I9 = I + 9
       J7 = I9 - 2
       J11 = I9 + 2
       VALUE = W5MA(I9)
       J1 = I
       J2 = I + 18
       IF(J2 .GT. IE) GO TO 100
       LT = 1
       GT = 1
C
C     CHECK FOR HIGHS AND LOWS IN WEIGHTED MA SERIES
      DO 80 J = J1, J2
       IF( W5MA(J) .LT. VALUE ) GO TO 70
       IF( W5MA(J) .EQ. VALUE .AND. J.LE.I9 ) GO TO 70
       GT = 0
   70  IF( W5MA(J) .GT. VALUE ) GO TO 80
       IF( W5MA(J) .EQ. VALUE .AND. J.LE.I9 ) GO TO 80
       LT = 0
   80 CONTINUE
C
C     FIND HIGH  VALUE NEAREST HIGH IN SMOOTHED SERIES
      IF(GT .EQ. 0) GO TO 90
      NH = NH + 1
      KK = I9
      XMAX = SERIES(I9)
      DO 85 JJ = J7, J11
       IF(SERIES(JJ) .LT. XMAX) GO TO 85
       XMAX = SERIES(JJ)
       KK = JJ
   85 CONTINUE
      HIGH(NH) = KK
C
C     FIND LOW VALUE NEAREST LOW IN SMOOTHED SERIES
   90 IF(LT .EQ. 0) GO TO 100
      NL = NL + 1
      KK = I9
      XMIN = SERIES(I9)
      DO 95 JJ = J7, J11
       IF(SERIES(JJ) .GT. XMIN) GO TO 95
       XMIN = SERIES(JJ)
       KK = JJ
   95 CONTINUE
      LOW(NL) = KK
  100 CONTINUE
C
      IF(KPRNT .GT. 2) WRITE(6,105) HIGH, LOW
  105 FORMAT(' ',25I4)
C
      WRITE(6,110) IPOUT(29),IPOUT(30)
  110 FORMAT(/ ' POTENTIAL TURNING POINTS FOR SERIES ', 2A3 /)
      DO 150 II = 1, 2
       NAME = HILO(II)
       IEND = NH
       IF(II .EQ. 2) IEND = NL
      DO 145 I = 1, 50
       IF(II .EQ. 1) IDUM(I) = HIGH(I)
       IF(II .EQ. 2) IDUM(I) = LOW(I)
  145 CONTINUE
C
      DO 130 I = 1, IEND, 12
       J1 = I
       J2 = I + 11
       IF(J2 .GT. IEND) J2 = IEND
       N = 0
      DO 135 J = J1, J2
       N = N + 1
       CALL DATE( IDUM(J), IMO, IYR )
       MO(N) = IMO
       YR(N) = IYR
  135 CONTINUE
      WRITE(6,140) NAME, ( MO(K), YR(K),K = 1,N )
  140 FORMAT( ' ', A4, 5X, 12(I2,'/',I4,3X) )
  130 CONTINUE
  150 CONTINUE
      RETURN
      END
C
C
C
      SUBROUTINE CUM( BASEYR )
      INTEGER BASEYR
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      COMMON /WORK/ CINDEX(1014),SUMPOS(1014),AVCH(1014),SUMW(1014),
     &              TOTAL(1014)
C
C     CUMULATE
      DO 20 I = 1, 1014
       CINDEX(I) = 0.0
   20 CONTINUE
      CINDEX(I1 - 1) = 100.
      DO 40 I = I1, I2
       CINDEX(I) = CINDEX(I - 1)*(200.0 + ARRAY(I))/(200.0 - ARRAY(I))
   40 CONTINUE
      IF(BASEYR .EQ. 0) RETURN
C
C     REBASE
      K1 = (BASEYR - 1945)*12 + 1
      K2 = K1 + 11
      IF( K1 .LT. I1 .OR. K2 .GT. I2 ) BASEYR = 0
      IF(BASEYR .LE. 0) RETURN
      TOT = 0.0
      DO 50 K = K1, K2
       TOT = TOT + CINDEX(K)
   50 CONTINUE
      FACTOR = TOT/1200.0
C
      MM1 = I1 - 1
      DO 60 I = MM1, I2
       CINDEX(I) = CINDEX(I)/FACTOR
   60 CONTINUE
      RETURN
      END
C
C
C
      SUBROUTINE TRCOMP( U, KY )
      DIMENSION KY(8), LLL(4), TOT(2), COU(2), AV(2)
      COMMON /SREC/ IPOUT(48),SERIES(1014),KFOUND
C
   2  FORMAT( 18X,'HILOW     MONTHS    TOTAL   AVERAGE  CENTER'/
     &      ' FIRST CYCLE',2I4, ' TO ', 2I4, F5.0, 2F10.2, 2I4/
     &      '  LAST CYCLE',2I4, ' TO ', 2I4, F5.0, 2F10.2, 2I4/
     &      ' MONTHS BETWEEN CENTERED AVERAGES = ', F7.0/
     &      ' RATIO OF AVERAGES = ', F12.7/' TREND = ',F10.5//)
C
      WRITE(6,4) IPOUT(29),IPOUT(30)
   4  FORMAT(/' SERIES ',2A3)
C
      DO 10 I = 1, 4
   10 LLL(I) = (KY(2*I - 1) - 1945)*12 + KY(2*I)
      DO 20 I = 1, 2
       TOT(I) = 0.0
       L1 = LLL(2*I - 1)
       L2 = LLL(2*I)
      DO 25 J = L1, L2
       IF(J .EQ. L1 .OR. J .EQ. L2) GO TO 24
       TOT(I) = TOT(I) + SERIES(J)
       GO TO 25
   24 TOT(I) = TOT(I) + SERIES(J)/2.0
   25 CONTINUE
       COU(I) = FLOAT(L2 - L1)
       AV(I) = TOT(I)/COU(I)
   20 CONTINUE
C
      L1 = LLL(1) + LLL(2)
      L2 = LLL(3) + LLL(4)
      IF( MOD(L1,2) .EQ. 1 ) L1 = L1 + 1
      IF( MOD(L2,2) .EQ. 1 ) L2 = L2 + 1
      L1 = L1/2
      L2 = L2/2
      POWER = FLOAT(L2 - L1)
      CALL DATE( L1, M1, M2 )
      CALL DATE( L2, M3, M4 )
      R = AV(2)/AV(1)
      S = R**( 1.0/POWER )
      T = ( S - 1.0 )*100.0
      U = ( 200.0*T )/( 200.0 + T )
C
      WRITE(6,2)
     &   KY(1),KY(2),KY(3),KY(4), COU(1), TOT(1), AV(1), M1,M2,
     &   KY(5),KY(6),KY(7),KY(8), COU(2), TOT(2), AV(2), M3,M4,
     &   POWER,R,U
      RETURN
      END
C
C
C
      SUBROUTINE INDXWT( NN )
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      COMMON /WORK/ CINDEX(1014),SUMPOS(1014),AVCH(1014),SUMW(1014),
     &              TOTAL(1014)
C
      IF(KPRNT .GT. 2) WRITE(6,40)
   40 FORMAT(/' INDEX WEIGHTS BASED ON LIKE - SIGNED COMPONENTS')
      DO 50 I = I1, I2
       IF(ARRAY(I) .LT. 0.0) SUMPOS(I) = FLOAT(NN) - SUMPOS(I)
   50 CONTINUE
      DO 60 I = I1, I2
       ARRAY(I) = ARRAY(I)*SUMPOS(I)/NN
   60 CONTINUE
      RETURN
      END
C
      SUBROUTINE QPOL
      COMMON /SREC/ IPOUT(48),SERIES(1014),KFOUND
C
      KK = (IPOUT(35) - 1945)*12 + IPOUT(34) + 3
      LL = (IPOUT(37) - 1945)*12 + IPOUT(36)
      DO 10 MM = KK, LL, 3
       TEMP = (SERIES(MM) - SERIES(MM - 3))/3.0
       SERIES(MM - 2) = SERIES(MM - 3) + TEMP
       SERIES(MM - 1) = SERIES(MM) - TEMP
   10  CONTINUE
C
      KK = KK - 4
      LL = LL - 1
      DO 20 MM = KK, LL
       SERIES(MM) = SERIES(MM + 1)
   20 CONTINUE
      IPOUT(34) = IPOUT(34) - 1
      IPOUT(36) = IPOUT(36) - 1
      RETURN
      END
C
C
C
C     SUBROUTINE TO STANDARDIZE USING MOVING AVERAGE
      SUBROUTINE MOVEAV( NN, METH )
      INTEGER XSP
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      COMMON /PARAM/ AVWOS(10), AV(10), SD(10),
     &               XSP(10), NXSP, FLEXSF(1014)
C
      IF(METH .GT. 1) WRITE(6,5) METH
   5  FORMAT(/' METHOD IS INCORRECT = ',I3,' OPERATION CANCELLED'/)
      IF(METH .GT. 1) RETURN
      DO 10 I = 1, 1014
       FLEXSF(I) = 0.0
  10  CONTINUE
C
      IF(NN .LT. 1) RETURN
      DO 60 I = I1, I2
       K1 = I
       K2 = K1 + NN - 1
       IF(K2 .GT. I2) GO TO 60
       SUM = 0.0
       TOTWOS = 0.0
      DO 50 K = K1, K2
       SUM = SUM + ARRAY(K)
       TOTWOS = TOTWOS + ABS(ARRAY(K))
  50  CONTINUE
       AVG = SUM/FLOAT(NN)
       AVGWOS = TOTWOS/FLOAT(NN)
C
      TOTSQ = 0.0
      DO 55 K = K1, K2
       SQ = (ARRAY(K) - AVG)**2
       TOTSQ = TOTSQ + SQ
  55  CONTINUE
      STDEV = (TOTSQ/FLOAT(NN))**0.5
C
      KK = METH + 1
      GO TO ( 24, 26, 26 ),KK
  24  FLEXSF(K2) = AVGWOS
      GO TO 30
  26  FLEXSF(K2) = STDEV
  30  IF(I .GT. I1) GO TO 60
      KSAVE = K2 - 1
      SAVE = FLEXSF(K2)
C
  60  CONTINUE
C
C     USE FIRST COMPUTED  FACTOR TO AS FACTOR FOR EARLY DATA
      DO 70 I = I1, KSAVE
       FLEXSF(I) = SAVE
  70  CONTINUE
      RETURN
      END
C
C
C
      SUBROUTINE REFNCE
      COMMON /REF/ REFSER(1014),IR1,IR2,CCWT
      COMMON /SREC/ IPOUT(48),SERIES(1014),KFOUND
      LOGICAL ANN
      DATA K3BL/3H   /
C
  15  WRITE(6,20)
  20  FORMAT(' ENTER REFERENCE SERIES FOR CORRELATION CALC'/
     &       ' AAAAAA')
      READ(5,25) IREF1, IREF2
  25  FORMAT( 2A3 )
      IF(IREF1 .EQ. K3BL) STOP
      ANN = .FALSE.
C     CALL CGTREC( IREF1, IREF2, ANN )
      STOP
      IF(KFOUND .EQ. 500) GO TO 15
      IR1 = (IPOUT(35) - 1945)*12 + IPOUT(34)
      IR2 = (IPOUT(37) - 1945)*12 + IPOUT(36)
      DO 50 I = IR1, IR2
       REFSER(I) = SERIES(I)
  50  CONTINUE
      RETURN
      END
C
C
C
      SUBROUTINE CCORR( NVERT )
      LOGICAL IVERT,ILT,IGT
      DIMENSION SDATA(1014),SREF(1014),CORR(49),NDATA(49),
     &          NC1(49),NC2(49)
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      COMMON /REF/ REFSER(1014),IR1,IR2,CCWT
C
C     COMPUTE CORRELATION COEFF BETWEEN REFERENCE SERIES AND
C      COMPONENT SERIES (SHIFTED - 24 TO + 24 MONTHS)
C
      IVERT =  NVERT .EQ. 0
      DO 5 I = 1, 1014
       SREF(I) = 0.0
       SDATA(I) = 0.0
  5   CONTINUE
      DO 10 I = IR1, IR2
       SREF(I) = REFSER(I)
  10  CONTINUE
C
      KLAG =  - 25
      DO 100 II = 1, 49
       KLAG = KLAG + 1
       IS1 = I1 + KLAG
       IS2 = I2 + KLAG
      DO 20 I = I1, I2
       SDATA(I + KLAG) = ARRAY(I)
  20  CONTINUE
C
      IC1 = MAX0(IR1,IS1)
      IC2 = MIN0(IR2,IS2)
      CALL MEANSD( SDATA, IC1, IC2, XBAR, SDEV )
       SXBAR = XBAR
       SSDEV = SDEV
      CALL MEANSD( SREF, IC1, IC2, XBAR, SDEV )
       RXBAR = XBAR
       RSDEV = SDEV
C
C     COMPUTE CORRELATION COEFFICENT
      TOT = 0.0
      N = 0
      DO 30 I = IC1, IC2
       N = N + 1
       Z1 = SDATA(I) - SXBAR
       IF( .NOT. IVERT ) Z1 = Z1*( - 1.)
       Z2 = SREF(I) - RXBAR
       TOT = TOT + Z1*Z2
  30  CONTINUE
      COVAR = TOT/FLOAT(N - 1)
      CORR(II) = COVAR/( SSDEV*RSDEV )
      NDATA(II) = N
      NC1(II) = IC1
      NC2(II) = IC2
  100 CONTINUE
C
C     FIND LARGEST CORRELATION
C
  150 KLAG =  - 25
      NN = 0
      XMAX = 0.0
      DO 200 I = 1, 49
       KLAG = KLAG + 1
       ILT =  CORR(I) .LT. XMAX
       IGT =  CORR(I) .GT. XMAX
       IF( IVERT.AND.ILT ) GO TO 200
       IF( .NOT.IVERT .AND. IGT ) GO TO 200
        XMAX = CORR(I)
        NN = KLAG
        NUM = NDATA(I)
        IC1 = NC1(I)
        IC2 = NC2(I)
  200 CONTINUE
C
      IF( ABS(XMAX) .NE. 0.0 ) GO TO 202
      IVERT = ( .NOT. IVERT )
      GO TO 150
C
  202 IF(KPRNT .EQ. 0) GO TO 210
      WRITE(6,205) CORR
  205 FORMAT(' ',12F6.3/' ',13F6.3/' ',12F6.3/' ',12F6.3)
  210 CALL DATE( IC1, IMO, IYR )
      KMO = IMO
      KYR = IYR
      CALL DATE( IC2, IMO, IYR )
      WRITE(6,215) XMAX, NN, NUM, KMO, KYR, IMO, IYR
 215  FORMAT(' MAX CORRELATION = ',F6.3,' AT SHIFT OF ',I3,' MONTHS',
     &       '  N = ',I4, 2X, I2,'/',I4,' TO ',I2,'/',I4)
      CCWT = ABS( XMAX )
      RETURN
      END
C
C
C
      SUBROUTINE MEANSD( XSER, IC1, IC2, XBAR, SDEV )
      DIMENSION XSER(1014)
C
      XN = 0.0
      TOT = 0.0
      TOTSQ = 0.0
      XBAR = 0.0
      SDEV = 0.0
      DO 50 I = IC1, IC2
       XN = XN + 1.0
       TOT = TOT + XSER(I)
       TOTSQ = TOTSQ + XSER(I)**2
  50  CONTINUE
      XBAR = TOT/XN
      VAR = (TOTSQ - (XN*(XBAR**2)))/(XN - 1.0)
      SDEV = VAR**0.5
      RETURN
      END
C
C
C     COMPUTE STRENGTH OF MOVEMENT
C
      SUBROUTINE SMOVE( IOPTSM, ICUMSM )
C
      REAL NEGD
      COMMON /INPUT/ ARRAY(1014),I1,I2,KPRNT
      COMMON /WORK/ CINDEX(1014),SUMPOS(1014),AVCH(1014),SUMW(1014),
     &              TOTAL(1014)
C
      IF( IOPTSM .LT. 1 .OR. IOPTSM .GT. 3 ) RETURN
      DO 10 I = 1, 1014
   10 CINDEX(I) = 0.0
      IF(IOPTSM .GT.  1) GO TO 20
      WRITE(6,25)
   25 FORMAT(/' ENTER AMPLITUDE STANDARD'/' FFFFFFFF')
      READ(5,28) AMP
   28 FORMAT( F8.0 )
   20 TOTDUR = 0.0
      TOTDEP = 0.0
      TOTDIF = 0.0
      OLDSGN = 0.0
      K = 0
C
      DO 100 I = I1, I2
       DUR = 0.0
       DEP = 0.0
       DIF = 0.0
       IF( ARRAY(I) .LT. 0.0) SIGN =  ( - 1.0)
       IF( ARRAY(I)  .GT.  0.0) SIGN = 1.0
       IF( ARRAY(I)  .EQ.  0.0) SIGN = OLDSGN
       POSD =  SUMPOS(I)/SUMW(I)
       NEGD =  (SUMW(I) - SUMPOS(I))/SUMW(I)
       IF( SIGN .EQ. OLDSGN) GO TO 30
        TOTDUR =  0.0
        TOTDEP =  0.0
        TOTDIF =  0.0
        K =  0
   30  K = K + 1
       GO TO( 40, 40, 60 ), IOPTSM
C
C      OPTION 1
   40  DUR = 1.0
       IF( ARRAY(I) .EQ.  0.0 ) DUR = 0.5
       IF( IOPTSM .EQ. 2 ) GO TO 50
        IF( ABS( ARRAY(I) ) .GT. AMP ) DEP = 1.0
        IF( SIGN .EQ. 1.0 .AND. POSD .GE. 0.5 ) DIF = 1.0
        IF( SIGN .EQ. (-1.0) .AND. NEGD .GE. 0.5 ) DIF = 1.0
        GO TO 65
C
C      OPTION 2
   50  DEP = ABS( ARRAY(I) )
       IF( SIGN .EQ. 1.0 ) DIF = POSD
       IF( SIGN .EQ. (-1.0) ) DIF = NEGD
       GO TO 65
C
C      OPTION 3
   60  DUR = FLOAT(K + 1)/2.0
       DEP = ABS( ARRAY(I) )
       IF( SIGN .EQ. 1.0 ) DIF = POSD
       IF( SIGN .EQ. (-1.0) ) DIF = NEGD
C
   65  OLDSGN = SIGN
       TOTDUR = TOTDUR + DUR
       TOTDEP = TOTDEP + DEP
       TOTDIF = TOTDIF + DIF
       CINDEX(I) = (TOTDUR + TOTDEP + TOTDIF)*SIGN
       IF(KPRNT .GT. 2) WRITE(6,70) TOTDUR, TOTDEP, TOTDIF
   70  FORMAT(' ',3F10.3)
       IF(ICUMSM .EQ. 1) GO TO 100
C
       TOTDUR = 0.0
       TOTDEP = 0.0
       TOTDIF = 0.0
C
  100 CONTINUE
C
      RETURN
      END
C
C
C     ---------- STORE VARIABLE ------------------------------
      SUBROUTINE SEROUT( IDF, IDL, ANN, KBEGIN, KEND, KTITL, ISW )
C
      LOGICAL ANN
      DIMENSION KTITL(24)
      CHARACTER *4 IRTITL(5), ITTITL(5), IDTITL(5)
      COMMON /SREC/ IPOUT(48),SERIES(1014),KFOUND
      COMMON /WORK/ CINDEX(1014),SUMPOS(1014),AVCH(1014),SUMW(1014),
     &              TOTAL(1014)
C
      DATA IRTITL/'  CO','MPOS','ITE ','INDE','X - '/
      DATA ITTITL/'TREN','D-AD','JUST','ED I','NDX-'/
      DATA IDTITL/'MEAS','URE ','OF D','ECLI','NE  '/

      DATA KPOS/3HPOS/, KNEG/3HNEG/, K3BL/3H   /, K4BL/4H    /
C
      WRITE(6,5)
   5  FORMAT(//' TO STORE SERIES:'/
     &         ' ENTER SERIES ID, INITIALS, DATE, DECIMAL'/
     &         ' AAAAAA AAA MMDDYY I')
      READ(5,10) IDF,IDL, NAME, IDATE, KDEC
   10 FORMAT( 2A3, 1X,A3, 1X,I6, 1X,I1 )
      NPASS = 0
       IF(   IDF .EQ. K3BL ) NPASS = 1
       IF(  NAME .EQ. K3BL ) NPASS = 1
       IF(  KDEC .GT. 4    ) NPASS = 1
       IF(  KDEC .LE. 0    ) NPASS = 1
       IF( IDATE .LE. 0    ) NPASS = 1
       IF( NPASS .EQ. 0    ) GO TO 20
      WRITE(6,15)
   15 FORMAT(/' OUTPUT PARAMETER IS INCORRECT OR MISSING',
     &        ' -- SERIES NOT SAVED')
      RETURN
C
   20 DO 35 I = 1, 5
       IF(ISW .EQ. 1) IPOUT(I) = IRTITL(I)
       IF(ISW .EQ. 2) IPOUT(I) = ITTITL(I)
       IF(ISW .EQ. 3) IPOUT(I) = IDTITL(I)
   35 CONTINUE
      DO 40 I = 6, 28
   40 IPOUT(I) = KTITL(I - 5)
C
      IF( ISW .LT. 3 ) GO TO 50
      DO 45 I = KBEGIN, KEND
       CALL ROUND( CINDEX(I), KDEC )
   45  SERIES(I) = CINDEX(I)
       GO TO 60
   50 DO 55 I = KBEGIN, KEND
       SERIES(I) = CINDEX(I) + ( 5.0/10.0**(KDEC + 1) )
            KSER = IFIX( SERIES(I)*10.0**KDEC )
       SERIES(I) = FLOAT(KSER)/ 10.0**KDEC
   55 CONTINUE
C
   60 IPOUT(29) = IDF
      IPOUT(30) = IDL
      IPOUT(31) = NAME
      IPOUT(32) = IDATE
      IPOUT(33) = KPOS
      DO 65 I = KBEGIN, KEND
       IF( SERIES(I) .LE. 0.0 ) IPOUT(33) = KNEG
   65 CONTINUE
      IPOUT(34) = MOD( KBEGIN, 12 )
       IF(IPOUT(34) .EQ. 0) IPOUT(34) = 12
      IPOUT(35) = (KBEGIN - 1)/12 + 1945
      IPOUT(36) = MOD( KEND, 12 )
       IF(IPOUT(36) .EQ. 0) IPOUT(36) = 12
      IPOUT(37) = (KEND - 1)/12 + 1945
      IPOUT(38) = 1
      IPOUT(39) = KDEC
      ANN = .FALSE.

C     SAVE THE NEWLY COMPUTED INDEX IN THE DATA ARRAY SO IT CAN BE USED IN THE TREND ADJUSTMENT      
      CALL SAVEIN (IDF,IDL,KBEGIN,KEND)
C     CALL PUTREC( IDF,IDL, ANN )
C      STOP
C
      DO 70 I = 1, 1014
   70 CINDEX(I) = 0.0
      RETURN
      END
C
C
C
      SUBROUTINE ROUND( DATA, IDEC )
      X = DATA
      RND5 =  0.5
      IF(X .LT. 0.0)  RND5 = -1.0*RND5
      POWER = 10.0**IDEC
      Y = X * POWER + RND5
      DATA = AINT(Y)/ POWER
      RETURN
      END
C
C
C
      SUBROUTINE READWK (INPUTFILE)
      DIMENSION IDATE(1014)
      CHARACTER*40 INPUTFILE 
      CHARACTER*190 LINE, IDS*9(18), TEMP*9(18) 
      COMMON /READW/ DATA(1014,18), IDS, IDECML(18) 
      DATA LASTDATE/199904/ 
      CLOSE (UNIT=7)
      OPEN (UNIT=7, FILE=INPUTFILE, MODE='READ', 
     &STATUS='OLD', ACCESS='SEQUENTIAL')
      WRITE (6,FMT='(16H ENTER LAST DATE)')
      READ (5,FMT='(I6)') LASTDATE
      NLAST = (LASTDATE/100-1945)*12+MOD(LASTDATE,100) 
      WRITE (6,FMT='(I7)')
      DO 200 N=1, 1014
      DO 100 ICOL=1, 18
      DATA(N,ICOL) = -999999.
 100  CONTINUE   
 200  CONTINUE   
      DO 5 ICOL=1, 18
   5  IDECML(ICOL) = -1    
   1  READ (7,FMT='(A190)') LINE
      IF (INDEX(LINE,'DATE') .EQ. 0) GOTO 1
      READ(LINE,8) IDS
      DO 6 NUMIDS=1, 18
   6  IF (INDEX(IDS(NUMIDS),'         ') .NE. 0) GOTO 7 
   7  IF (NUMIDS .LT. 18) NUMIDS=NUMIDS-1
      DO 20 N=37,NLAST
      READ (7,17) IDATE(N), TEMP
  17  FORMAT(I9,18(1X,A9))
      DO 18 ICOL=1,NUMIDS
      READ (TEMP(ICOL),FMT='(A9)') 
      IF (INDEX(TEMP(ICOL),'NA') .EQ. 0) THEN
      READ(TEMP(ICOL),FMT='(F9.0)') DATA(N,ICOL)
      IF (IDECML(ICOL) .LT. 0) IDECML(ICOL) = NUMDEC(TEMP(ICOL))
      END IF
      IF (INDEX(TEMP(ICOL),'NA') .NE. 0)
     & DATA(N,ICOL) = -999999.
  18  CONTINUE 
  20  CONTINUE
C     WRITE (6, FMT='(7X,18A9)') (IDS(ICOL),ICOL=1,NUMIDS)
C     DO 30 N=37,NLAST
C 30  WRITE (8, 10) IDATE(N), (DATA(N,ICOL),ICOL=1,NUMIDS) 

   8  FORMAT (10X,18(A9,1X))
  10  FORMAT (1X,I6, 18F12.3)
      RETURN
      END      
C
C
C
      FUNCTION NUMDEC (TEMP)
      CHARACTER*9 TEMP
      NUMDEC = 9 - INDEX(TEMP,'.') 
      IF (NUMDEC .EQ. 9) NUMDEC = 0
      RETURN
      END
C
C
C
      SUBROUTINE GETSER ( ID1, ID2 )
      CHARACTER *6 ID,  IDS*9(18)
      COMMON /READW/ DATA(1014,18), IDS, IDECML(18)
      COMMON /SREC/ IPOUT(48), SERIES(1014), KFOUND
 
C
      WRITE (ID, FMT='(2A3)') ID1, ID2
      DO 10 ICOL=1,18
      IF (INDEX(IDS(ICOL),ID) .EQ. 0)  GOTO 10
      GOTO 20
  10  CONTINUE
      KFOUND = 500
      RETURN
C
  20  DO 30 I=1, 1014
  30  SERIES(I) = DATA(I,ICOL) 
C
      DO 40 I=1, 1014
      IF (DATA(I,ICOL) .GT. -999998.) GOTO 50
  40  CONTINUE 
  50  IPOUT(35) = (I-1)/12+1945
      IPOUT(34) = MOD(I,12)
      IF (IPOUT(34) .EQ. 0) IPOUT(34) = 12
C
      DO 60 I=1014, 1, -1
      IF (DATA(I,ICOL) .GT. -999998.) GOTO 70
  60  CONTINUE 
  70  IPOUT(37) = (I-1)/12+1945
      IPOUT(36) = MOD(I,12)
      IF (IPOUT(36) .EQ. 0) IPOUT(36) = 12 
      RETURN
      END
C
C
C
      SUBROUTINE SAVEIN ( ID1, ID2, KBEGIN,KEND ) 
      CHARACTER*9 IDS(18)
      COMMON /WORK/ CINDEX(1014), SUMPOS(1014), AVCH(1014), SUMW(1014),
     &              TOTAL(1014) 
      COMMON /READW/ DATA(1014,18), IDS, IDECML(18)
      COMMON /SREC/ IPOUT(48), SERIES(1014), KFOUND
      IDS(18) = ID1 // ID2
      DO 100 I = KBEGIN, KEND
 100  DATA(I,18) = SERIES(I)
      RETURN
      END
            
C
C
C     END OF PROGRAM ----------------------------------------
comp2k9x05272014.txt
Displaying comp2k9x05272014.txt.