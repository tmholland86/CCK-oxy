%This script sets up the CCK calculations.

%Initialize FUELRHO

FUELRHO=0.0;

%Initialize CHARXAO, which is not initialized in CCK, and so defaulted to 0

CHARXAO=0.0;

%Call CBKSETUP

[ COALC,COALH,OMEGA,HTVL,RHOA,...
     XK3OI,FUELRHOC,XAO,CHARXAO,RHOCO,P,FUELRHO,XK7OI,XK4OBYK7O,...
     XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,E7,E4mE7,...
     E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7 ]=...
CBKSETUP( COALC,COALH,OMEGA,HTVL,RHOA,XK3OI,FUELRHOC,XAO,...
P,XK7OI,XK4OBYK7O,XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,...
XK8OBYK7O,E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7 );   

     
%Initialize COALRHO

COALRHO=FUELRHO;%This is an estimate in the abscence of the moisture content.
                %This should be adjusted in moisture is estimated or coal
                %density is experimentally known
    

%  In the setup call above, the first 2 parameters, 
% C  COALC, COALH, must be passed if the
% C  user wants CBK to estimate swelling factor
% C  (OMEGA), initial reactivity (XK3OI), or parent fuel density
% C  (RHOCO).  The user can specify any of these 3 
% C  parameters or pass a negative real number (typically -1.) 
% C  to request the CBK-generated estimate based on 
% C  COALC and COALH. The last three parameters in the
% C  list are results returned to the main code.  

% Confirm and echo key input parameters (I left this commented out because 
% it is a lot of work to code in and not terribly useful.

%       WRITE(6,*) "" 
%       WRITE(6,*) ""
%       WRITE(6,*) ""
%       WRITE(6,*) ""
%       WRITE(6,*) ""
%       WRITE(6,*) "******************************************************
%      1*******************"
%       WRITE(6,*) ""
%       WRITE(6,*) "                   THE CHAR CONVERSION KINETIC MODEL"
%       WRITE(6,*) "                 FOR OXIDATION AND GASIFICATION (CCK)"
%       WRITE(6,*) ""
%       WRITE(6,*) "                              developed by"
%       WRITE(6,*) "                             Randy C. Shurtz"
%       WRITE(6,*) "                        and Thomas H. Fletcher"
%       WRITE(6,*) ""
%       WRITE(6,*) "                   Chemical Engineering Department"
%       WRITE(6,*) "                       Brigham Young University"
%       WRITE(6,*) "                              Provo, UT"
%       WRITE(6,*) ""	  
%       WRITE(6,*) "                          Released July 2011"
%       WRITE(6,*) ""
%       WRITE(6,*) ""
%       WRITE(6,*) ""
%       WRITE(6,*) ""
%       WRITE(6,*) "                            Based on CBK/E"
%       WRITE(6,*) "                             developed by"
%       WRITE(6,*) "                              Robert Hurt " 
%       WRITE(6,*) "                    Brown University, Providence, RI"
%       WRITE(6,*) ""	
%       WRITE(6,*) ""	  
%       WRITE(6,*) "                          Also based on CBK/G"
%       WRITE(6,*) "                            as published by"
%       WRITE(6,*) "                     Gui-Su Liu and Stephen Niksa " 
%       WRITE(6,*) "                         Niksa Energy Associates"
%       WRITE(6,*) "                              Belmont, CA"
%       WRITE(6,*) ""
%       WRITE(6,*) ""
%       WRITE(6,*) "******************************************************
%      1*******************"
%       WRITE(6,*) ""     
%       WRITE(6,*) ""     
%       WRITE(6,*) "                       INPUT PARAMETER SUMMARY" 
%       WRITE(6,*) ""
%       WRITE(6,*) "           Swelling      High-temperature
%      1Fuel ash"
%       WRITE(6,*) "           factor       volatile loss, daf
%      1fraction"
%       WRITE(6,*) ""
%       WRITE(6,20) OMEGA,HTVL,XAO
% 20    FORMAT("              ",F4.2,"             ",F4.2,
%      1"                       ",F4.2)
%       WRITE(6,*)
%       WRITE(6,*)
%       WRITE(6,*) "  Initial O2 desorption reactivity       ",
%      1"H2O desorption reactivity"   
%       WRITE(6,*) "         XK3OI (sec-1) x 10-7            ",
%      1"   XK7OI (sec-1) x 10-7 "
%       WRITE(6,*) ""     
% 21    FORMAT("        ",F10.2,"                           ",F10.2)
% 22    FORMAT("                        ",F6.2,"             ",F4.2)
%           PRINTKOS = 1.E-7*XK3OI
%           WRITE(6,21) PRINTKOS,(1.E-7*XK7OI)
% 26    CONTINUE
%       WRITE(6,*) " "
%       WRITE(6,*) " "
%       WRITE(6,*) " Size distribution:    dpo (um)        Mass fraction"   
%       WRITE(6,*) ""  
%       DO 28 I = 1, NDPO
%           WRITE(6,22) DPO(I),MODPO(I)
% 28    CONTINUE
%       WRITE(6,*) " "
%       WRITE(6,*) " "
%       WRITE(6,*) " "
%       IF (PSI.GT.0.0) THEN
%          WRITE(6,*) " Use random pore model with PSI =  ",PSI
%       ELSE
%          WRITE(6,*) " Random pore model not used: see input file"
%       endif
%       WRITE(6,*) " "
%       WRITE(6,*) " "
%       IF (ITRAJ .EQ. 1) WRITE(6,*) 
%      1  " Write single particle results to output file: YES"
%       IF (ITRAJ .EQ. 0) WRITE(6,*) 
%      1  "Write single particle results to output file: NO"
%       WRITE(6,*) "" 
%       WRITE(6,*)"-------------------------------------------------------
%      1-------------------"
%       WRITE(6,*) "" 
%       WRITE(6,*) "" 
%       WRITE(6,*) "" 

%Include PRINTKOS from the confirmation sections

PRINTKOS=1E-7*XK3OI;


