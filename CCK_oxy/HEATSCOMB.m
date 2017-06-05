function [ TP,DELHCO,DELHCO2,DELHGH2O,DELHGCO2,DELHGH2 ] =...
 HEATSCOMB( TP )
%This subroutine calculates the heats of combustions
%This subroutine has been verified against the original FORTRAN CCK code.


% C  Calculate Hrxn: These are negative heats of reaction (heats of combustion)  
% C  from the Gordon-McBride Database (NASA-CEA), using the 1000-2000 K range, 
% C  which extrapolates down to 600 K and up to 3000 K with less than 5 cal/gm error
% C  BELOW 600 K a simpler curve fit of the Gordon-McBride Hrxn in the 200-600 K is used
% C  All of these Hrxn values assume graphite properties for the char

%Note that for the output in matlab functions, the name of the output value
%is designated in the CALL of the function, not by what I call my input and
%output arguments here. 

%Note that input arguments are locally defined by the name given here, and do not
%redefine anything in the main script, though they can be redefined within
%the function.

%Initialize all the input arguments at their own value so they have an
%output value if nothing reassigns them here.

TP=TP;

if TP<600
    DELHCO = 3.053420E-04*TP^2 - 2.996074E-01*TP + 2.263909E+03;
	DELHCO2 = 1.883767E-02*TP + 7.830675E+03;
	DELHGH2O = 3.125036E-04*TP^2 -4.984913E-01*TP - 2.493882E+03;
	DELHGCO2 = 6.039653E-04*TP^2 -6.126775E-01*TP - 3.303796E+03;
	DELHGH2 = 5.632658E-01*TP + 1.318441E+03;
else
%C  Heat of Reaction, cal/gm   C + 1/2 O2 = CO
	DELHCO = (-(-6.45288795E+05)/TP+(5.20591636E+02)*log(TP)...
     +(1.941993748)*TP+(-2.284484016E-03)*(TP^2)/2 ...
     +(1.5949075916E-06)*(TP^3)/3.+(-4.7737519453E-10)*(TP^4)/4 ...
     +(5.61346231905E-14)*(TP^5)/5.+(8.005330999E+03))*1.987/12;
%C     Heat of Reaction, cal/gm  C + O2 = CO2
      DELHCO2 = (-(-8.200348229E+05)/TP+(1.537093391E+03)*log(TP)...
     +(4.77050756E-01)*TP+(-2.1247569402E-03)*(TP^2)/2 ...
     +(1.62052196932E-06)*(TP^3)/3.+(-4.83092346968E-10)*(TP^4)/4 ...
     +(5.6054039736E-14)*(TP^5)/5.+(3.617752117E+04))*1.987/12;
%C     Heat of Reaction, cal/gm    C + H2O = CO + H2
  	DELHGH2O = (-(3.47840011E+05)/TP+(-2.227371593E+03)*log(TP)...
     +(2.702873978E+00)*TP+(-1.878658624E-03)*(TP^2)/2 ...
     +(1.394699562E-06)*(TP^3)/3.+(-4.5274535509E-10)*(TP^4)/4 ...
     +(5.5328910113E-14)*(TP^5)/5.+(-2.73230385600E+03))*1.987/12;
%C	Heat of Reaction, cal/gm    C + CO2 = 2CO
  	DELHGCO2 = (-(-4.705427671E+05)/TP+(-4.95910119E+02)*log(TP)...
     +(3.40693674E+00)*TP+(-2.4442110918E-03)*(TP^2)/2 ...
     +(1.56929321388E-06)*(TP^3)/3.+(-4.71658042092E-10)*(TP^4)/4 ...
     +(5.62152066450E-14)*(TP^5)/5.+(-2.0166859172E+04))*1.987/12;
%C	Heat of Reaction, cal/gm    C + 2H2 = CH4
  	DELHGH2 = (-(-2.272816717E+06)/TP+(9.564185534E+03)*log(TP)...
     +(-7.591499936E+00)*TP+(9.81636917E-04)*(TP^2)/2 ...
     +(6.23317903E-07)*(TP^3)/3.+(-3.494999451E-10)*(TP^4)/4 ...
     +(4.8668664693E-14)*(TP^5)/5.+(-5.065689572E+04))*1.987/12;    
end



end

