%This script displays the results of the CCK calculation
%C  Calculate residence times, total % burnouts, LOI,etc.

for i = 1:INTSTEP;
           TAU(i) = (i-1)*DELT;
           GLBO(i) = 100.*(1 - GLMCMCO(i));
           CLOSS(i) = 100. - GLBO(i);
           CLOSSCOAL(i) = 100.*(1-HTVL)*GLMCMCO(i);
           GLBOCOAL(i) = 100-CLOSSCOAL(i); 
end

%final loss on ignition

FINALLOI = 100*(1-XAO)*CLOSSCOAL(INTSTEP)/((1-XAO)*...
      CLOSSCOAL(INTSTEP) + 100.*XAO);
  
  RS='RESULTS SUMMARY'
  
  disp(['OVERALL % LOI= ',num2str(FINALLOI)])
  
  
  disp(['OVERALL % CARBON CONVERSION:','CHAR-BASIS= ',num2str(GLBO(INTSTEP)),', COAL-BASIS= ',num2str(GLBOCOAL(INTSTEP))])
  disp(['OVERALL % CARBON UNBURNED:','CHAR-BASIS= ',num2str(CLOSS(INTSTEP)),', COAL-BASIS= ',num2str(CLOSSCOAL(INTSTEP))])

  disp(['IFLAG= ',num2str(IFLAGERR)])
  
  disp(['BO.txt= ',num2str(GLBOCOAL(INTSTEP))])
  
%C
%C  Print out time-resolved burnouts and mean reactivities
%C  The production rates of species are for just one particle size
%C
disp('species production rates units: (mol/s/g_coal_daf)')

%REWORK A FEW VARIABLES FOR DISPLAY IN THE CORRECT UNITS
PNETO2=PNETO2*(1-HTVL)/(1-CHARXAO);
PNETCO=PNETCO*(1-HTVL)/(1-CHARXAO);
PNETCO2=PNETCO2*(1-HTVL)/(1-CHARXAO);
PNETH2=PNETH2*(1-HTVL)/(1-CHARXAO);
PNETCH4=PNETCH4*(1-HTVL)/(1-CHARXAO);
PNETH2O=PNETH2O*(1-HTVL)/(1-CHARXAO);





disp(['Matrices of the following values can be displayed under the listed name:'])
disp(['time(sec), ','NAME: TAU'])
disp(['C(CHAR), ','NAME: CLOSS'])
disp(['BURNOUT(CHAR) ,','NAME: GLBO'])
disp(['C(COAL), ','NAME: CLOSSCOAL'])
disp(['BURNOUT(COAL), ','NAME: GLBOCOAL'])
disp(['PRODUCTION OF O2, ','NAME: PNETO2'])
disp(['PRODUCTION OF H2O, ','NAME: PNETH2O'])
disp(['PRODUCTION OF CO2, ','NAME: PNETCO2'])
disp(['PRODUCTION OF H2, ','NAME: PNETH2'])
disp(['PRODUCTION OF CO, ','NAME: PNETCO'])
disp(['PRODUCTION OF CH4, ','NAME: PNETCH4'])





