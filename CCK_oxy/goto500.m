%This script circumvents the lack of a goto command in matlab for the
%specific case of the CCK code stating GOTO 500
%P500='500 START'


% C  Calculate Chi1, Chi2 for reference.  Chi1 is the actual rate 
% C  normalized by the absolute maximum rate on the carbon 
% C  core surface, a measure of the combined resistance 
% C  of all internal processes (chemical reaction, pore diffusion 
% C  and ash film diffusion.  Chi2 is the actual rate divided by 
% C  the maximum rate in the presence of ash film resistance 
% C  and as such is a measure of the combined chemical 
% C  and internal pore diffusion resistance.  The difference 
% C  between Chi1 and Chi2 is an indication of the  
% C  importance of the ash film resistance.

QMAX = (KDIFF*P/GAMMA)*log(1./(1.-GAMMA*POX/P));
CHI2 = QCOMB/QMAX;
QMAXH2O = (KDIFFH2O*P/GAMMAH2O)*log(1./(1.-GAMMAH2O*PH2O/P));
CHI2H2O = QH2O/QMAXH2O;
QMAXCO2 = (KDIFFCO2*P/GAMMACO2)*log(1./(1.-GAMMACO2*PCO2/P));
CHI2CO2 = QCO2/QMAXCO2;
QMAXH2 = (KDIFFH2*P/GAMMAH2)*log(1./(1.-GAMMAH2*PH2/P));
CHI2H2= QH2/QMAXH2;
KDIFF = SH*DO2/(DCCM*TM*STOICH*82.1);
QMAX = (KDIFF*P/GAMMA)*log(1./(1.-GAMMA*POX/P));
KDIFFH2O = SH*DH2O/(DCCM*TM*STOICHH2O*82.1);
QMAXH2O = (KDIFFH2O*P/GAMMAH2O)*log(1./(1.-GAMMAH2O*PH2O/P));
KDIFFCO2 = SH*DCO2/(DCCM*TM*STOICHCO2*82.1);
QMAXCO2 = (KDIFFCO2*P/GAMMACO2)*log(1./(1.-GAMMACO2*PCO2/P));
KDIFFH2 = SH*DH2/(DCCM*TM*STOICHH2*82.1);
QMAXH2 = (KDIFFH2*P/GAMMAH2)*log(1./(1.-GAMMAH2*PH2/P));
CHI1 = QCOMB/QMAX;
CHI1H2O = QH2O/QMAXH2O;
CHI1CO2 = QCO2/QMAXCO2;
CHI1H2 = QH2/QMAXH2;

for i=1:5
    PS(i)=PS2RXN(i);
end
%P500='500 END'
%all of the "goto" statements ultimately lead here, and they are all
%followed by a return, bouncing this function back to the equation that
%invoked them 

