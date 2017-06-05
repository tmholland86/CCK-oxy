function [ TM,MOLF,LAMBGAS,CPCH4,CPH2,CPCO2,CPCO,CPO2,CPH2O ] =...
 GASPROPS( TM,MOLF )
%This subroutine calculates the multicomponent gas diffusion
%This subroutine has been verified against the original FORTRAN CCK code.

%Note that for the output in matlab functions, the name of the output value
%is designated in the CALL of the function, not by what I call my input and
%output arguments here. 

%Note that input arguments are locally defined by the name given here, and do not
%redefine anything in the main script, though they can be redefined within
%the function.

%Initialize all the input arguments at their own value so they have an
%output value if nothing reassigns them here.

MOLF=MOLF;
TM=TM;



%C  Calculate gas properties (from R.Mitchell RATE routine)
%C  Thermal conductivity (cal/(cm*s*K)) WITH MODIFIED WATER fit to experimental data found in DIPPR 801 database:
LAMBGAS = MOLF(1)*(7.6893E-7*TM^0.7722) +...
      MOLF(2)*(1.1111E-7*TM^1.1778)+ MOLF(3)*(51.840E-7*TM^0.7681)+...
      MOLF(4)*(2.3291E-7*TM^0.9386)+ MOLF(5)* (7.3710E-7*TM^0.7820)+...
      MOLF(6)*(7.1352E-7*TM^0.7968)+ MOLF(7)* (0.14827E-7*TM^1.3973);

%C   Determine Cp, cal/mol-K from Gordon-McBride correlation (1000-6000 K range with a simpler curve fit below 1000 K)
if TM<1000
       CPCH4 = 1.325162E-02*TM+4.558756E+00;
	   CPH2 = 4.032382E-04*TM+6.780701E+00;
	   CPCO2 = 3.423310E+00*log(TM)-1.061621E+01;
	   CPCO = 1.463938E-03*TM+6.442999E+00;
	   CPO2 = 1.950505E-03*TM+6.459068E+00;
	   CPH2O = 2.680356E-03*TM+7.127678E+00;
else
    CPCH4 = 1.987*((3730042.76)/(TM^2)+(-13835.01485)/TM+...
      (20.49107091)+(-0.001961975)*TM+(4.72731E-07)*TM^2+...
      (-3.72881E-11)*TM^3+(1.62374E-15)*TM^4);
       CPH2 = 1.987*((560812.801)/(TM^2)+(-837.150474)/TM+...
      (2.975364532)+(0.001252249)*TM+(-3.74072E-07)*TM^2+...
      (5.93663E-11)*TM^3+(-3.60699E-15)*TM^4);
       CPCO2 = 1.987*((117696.2419)/(TM^2)+(-1788.791477)/TM+...
      (8.29152319)+(-9.22316E-05)*TM+(4.86368E-09)*TM^2+...
      (-1.89105E-12)*TM^3+(6.33004E-16)*TM^4);
       CPCO = 1.987*((461919.725)/(TM^2)+(-1944.704863)/TM+...
      (5.91671418)+(-0.000566428)*TM+(1.39881E-07)*TM^2+...
      (-1.78768E-11)*TM^3+(9.62094E-16)*TM^4);
       CPO2 = 1.987*((-1037939.022)/(TM^2)+(2344.830282)/TM+...
      (1.819732036)+(0.001267848)*TM+(-2.18807E-07)*TM^2+...
      (2.05372E-11)*TM^3+(-8.19347E-16)*TM^4);
       CPH2O = 1.987*((1034972.096)/(TM^2)+(-2412.698562)/TM+...
      (4.64611078)+(0.002291998)*TM+(-6.83683E-07)*TM^2+...
      (9.42647E-11)*TM^3+(-4.82238E-15)*TM^4);
    
end

