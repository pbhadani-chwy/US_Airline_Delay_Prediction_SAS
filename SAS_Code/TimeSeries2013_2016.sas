DATA TEMPAS;
SET Y13_16;
if CARRIER = 'AS' then OUTPUT;
RUN;

DATA TEMPB6;
SET Y13_16;
IF CARRIER = 'B6' THEN OUTPUT;
RUN;

DATA TEMPHA;
SET Y13_16;
IF CARRIER = 'HA' THEN OUTPUT;
RUN;

DATA TEMPUA;
SET Y13_16;
IF CARRIER = 'UA' THEN OUTPUT;
RUN;

DATA TEMPVX;
SET Y13_16;
IF CARRIER = 'VX' THEN OUTPUT;
RUN;

DATA FINDATA_AS;
SET TEMPAS;
IF YEAR = '2016'
THEN
D1 = 1;
ELSE
D1 = 0;
IF YEAR = '2015'
THEN
D2 = 1;
ELSE
D2 = 0;
IF YEAR = '2014'
THEN
D3 = 1;
ELSE
D3 = 0;

RUN;

/*proc contents data= Findata_as;*/
/*run;*/


TITLE "REGRESSION EQUATION FOR THE 'AS' CARRIER BASED ON THE TIME";

PROC REG DATA=FINDATA_AS;
MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT D1 D2 D3/STB VIF COLLIN;
RUN;

DATA FINDATA_B6;
SET TEMPB6;
IF YEAR = '2016'
THEN
D1 = 1;
ELSE
D1 = 0;
IF YEAR = '2015'
THEN
D2 = 1;
ELSE
D2 = 0;
IF YEAR = '2014'
THEN
D3 = 1;
ELSE
D3 = 0;

RUN;

/*proc contents data= Findata_as;*/
/*run;*/


/* REGRESSION EQUATION FOR THE AS CARRIER BASED ON THE TIME */



TITLE "REGRESSION EQUATION FOR THE 'B6' CARRIER BASED ON THE TIME";
PROC REG DATA=FINDATA_B6;
MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT LATE_AIRCRAFT_CT D1 D2 D3/STB VIF COLLIN;
RUN;

DATA FINDATA_HA;
SET TEMPHA;
IF YEAR = '2016'
THEN
D1 = 1;
ELSE
D1 = 0;
IF YEAR = '2015'
THEN
D2 = 1;
ELSE
D2 = 0;
IF YEAR = '2014'
THEN
D3 = 1;
ELSE
D3 = 0;

RUN;


TITLE "REGRESSION EQUATION FOR THE HA CARRIER BASED ON THE TIME";
PROC REG DATA=FINDATA_HA;
MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT LATE_AIRCRAFT_CT D1 D2 D3/STB VIF COLLIN;
RUN;



DATA FINDATA_UA;
SET TEMPUA;
IF YEAR = '2016'
THEN
D1 = 1;
ELSE
D1 = 0;
IF YEAR = '2015'
THEN
D2 = 1;
ELSE
D2 = 0;
IF YEAR = '2014'
THEN
D3 = 1;
ELSE
D3 = 0;

RUN;

TITLE "REGRESSION EQUATION FOR THE UA CARRIER BASED ON THE TIME";
PROC REG DATA=FINDATA_UA;
MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT LATE_AIRCRAFT_CT D1 D2 D3/STB VIF COLLIN;
RUN;


DATA FINDATA_UA;
SET TEMPUA;
IF YEAR = '2016'
THEN
D1 = 1;
ELSE
D1 = 0;
IF YEAR = '2015'
THEN
D2 = 1;
ELSE
D2 = 0;
IF YEAR = '2014'
THEN
D3 = 1;
ELSE
D3 = 0;

RUN;

TITLE "REGRESSION EQUATION FOR THE UA CARRIER BASED ON THE TIME";
PROC REG DATA=FINDATA_UA;
MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT LATE_AIRCRAFT_CT D1 D2 D3/STB VIF COLLIN;
RUN;



DATA FINDATA_UA;
SET TEMPUA;
IF YEAR = '2016'
THEN
D1 = 1;
ELSE
D1 = 0;
IF YEAR = '2015'
THEN
D2 = 1;
ELSE
D2 = 0;
IF YEAR = '2014'
THEN
D3 = 1;
ELSE
D3 = 0;

RUN;

TITLE "REGRESSION EQUATION FOR THE UA CARRIER BASED ON THE TIME";
PROC REG DATA=FINDATA_UA;
MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT LATE_AIRCRAFT_CT D1 D2 D3/STB VIF COLLIN;
RUN;



DATA FINDATA_VX;
SET TEMPVX;
IF YEAR = '2016'
THEN
D1 = 1;
ELSE
D1 = 0;
IF YEAR = '2015'
THEN
D2 = 1;
ELSE
D2 = 0;
IF YEAR = '2014'
THEN
D3 = 1;
ELSE
D3 = 0;

RUN;

TITLE "REGRESSION EQUATION FOR THE VX CARRIER BASED ON THE TIME";
PROC REG DATA=FINDATA_VX;
MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT LATE_AIRCRAFT_CT D1 D2 D3/STB VIF COLLIN;
RUN;

/**transformation for white test;*/
/*proc model DATA=FINDATA_AS HCCME = 3;*/
/*parms b1 b2 b3 b4 b5 b6 b7 b8;*/
/*_ARR_DELAY = b1 + b2*CARRIER_CT + b3*_WEATHER_CT + b4*NAS_CT + b5*SECURITY_CT + b6*D1 + b7*D2 + b8*D3;*/
/*fit _arr_delay / white printall;*/
/*RUN;*/

TITLE " MAIN REGRESSION MODEL";
PROC REG DATA= FINDATA_AS PLOTS= NONE;
MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT LATE_AIRCRAFT_CT/STB VIF COLLIN;
OUTPUT P=PRED1 R=RESID OUT = FINDATA_AS1;
RUN;



Title "White test for heteroscedasticity check";
DATA FINDATA_AS_WHITE;
SET FINDATA_AS1;
CARRIER_CTSQ = CARRIER_CT **2;
WEATHER_CTSQ = _WEATHER_CT **2;
NAS_CTSQ = NAS_CT ** 2;
SECURITY_CTSQ = SECURITY_CT ** 2;
CARWET = CARRIER_CT * _WEATHER_CT;
CARNAS = CARRIER_CT*NAS_CT;
CARSEC = CARRIER_CT*SECURITY_CT;
wetnas = _WEATHER_CT * NAS_CT;
wetsec = _WEATHER_CT * SECURITY_CT;
nassec = NAS_CT * SECURITY_CT;
carwetsec = CARRIER_CT * _weather_ct * security_ct;
carnassec = CARRIER_CT * NAS_CT * SECURITY_CT;
wetnassec = _WEATHER_CT * NAS_CT * SECURITY_CT;
carwetnassec = _WEATHER_CT * NAS_CT * SECURITY_CT * CARRIER_CT;
pred1sqr = pred1 ** 2;
residsqr = resid ** 2;
run;

TITLE "WHITE'S TEST REGRESSION";

PROC REG DATA = FINDATA_AS_WHITE PLOTS = NONE;
MODEL RESIDSQR = CARRIER_CT CARRIER_CTSQ _WEATHER_CT WEATHER_CTSQ SECURITY_CT SECURITY_CTSQ;
RUN;

TITLE "YULE-WALKER WLS ESTIMATES USING PROC AUTOREG ";
PROC AUTOREG DATA= FINDATA_AS;
	MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT/METHOD=YW NLAG= 1 ITER;
RUN;
 


DATA TEMP_CHG;
SET Y13_16;
if airport = 'ORD' then OUTPUT;
RUN;

DATA FINDATA_CHG;
SET TEMP_CHG;
IF YEAR = '2016'
THEN
D1 = 1;
ELSE
D1 = 0;
IF YEAR = '2015'
THEN
D2 = 1;
ELSE
D2 = 0;
IF YEAR = '2014'
THEN
D3 = 1;
ELSE
D3 = 0;

RUN;


TITLE "REGRESSION EQUATION FOR THE CHICAGO AIRPORT CARRIER BASED ON THE TIME";
PROC REG DATA=FINDATA_CHG;
MODEL _ARR_DELAY = CARRIER_CT _WEATHER_CT NAS_CT SECURITY_CT LATE_AIRCRAFT_CT D1 D2 D3/STB VIF COLLIN;
RUN;


