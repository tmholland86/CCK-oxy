%This script circumvents the lack of a goto command in matlab for the
%specific case of the CCK code stating GOTO 150
%P150='150 START' 

[ TP1,DELHCO,DELHCO2,DELHGH2O,DELHGCO2,DELHGH2 ] =...
 HEATSCOMB( TP1 );

%C	ADD HEATS OF REACTION TOGETHER

DELH = (QCOMB*(DELHCO2*FCO2 + DELHCO*(1 - FCO2))+QH2O*DELHGH2O+QCO2*DELHGCO2+QH2*DELHGH2)/QRXN;

%c	CALCULATE CONSUMPTION AND PRODUCTION RATES OF SPECIES (MOL/CM^2/S)

CONSO2 = QCOMB*STOICH;
CONSH2O = QH2O*STOICHH2O;
PRODCO2 = QCOMB*FCO2/12-QCO2*STOICHCO2;
PRODCO = QCOMB*(1-FCO2)/12+QCO2*STOICHCO2*2+QH2O*STOICHH2O;
PRODH2 = CONSH2O-QH2*STOICHH2;
PRODCH4 = 0.5*QH2*STOICHH2;

%c Calculate terms in heat balance

HRAD = EMISS*STEFBOL*(TP1^4 - TENV^4);
BETA=-(CPCO*(PRODCO)+CPCO2*(PRODCO2)-CONSO2*CPO2...
     	-CPH2O*CONSH2O+CPH2*(PRODH2)+CPCH4*PRODCH4)...
     	*DCCM/(LAMBGAS*XNU);
  
if (TP1-TG)<0
    BETA=-BETA;
end
if (BETA^2)>1E-6
    TERM=BETA/(exp(BETA)-1);
else
    TERM=1;
end
LAMBDA = LAMBASH*(1-PORFILM)+(LAMBGAS*PORFILM);
RESEXT = 2*DPCM/(LAMBGAS*XNU);
RESINT=(DPCM/DCCM)*(DPCM-DCCM)/LAMBDA;
HCOND=2*((DPCM/DCCM)^2)*(TP1-TG)*TERM/(RESEXT+RESINT);
HTHERM = RHOCP*(1/6)*DPCM*(TP1-TPPREV)/DELTIME;
HGEN = HRAD + HCOND + HTHERM;

%C calculate qheat and compare

QHEAT=HGEN/DELH;
QERR1=QRXN-QHEAT;

%C *******  ITERATION BLOCK TO FIND OPTIMAL TP **********

%C  Initialize first guess for TP
% if DELH>0
%     TP2=TP1+1;%!This is for combustion, where the particle may be hotter than the gas due to exothermic reaction (positive heat of combustion or negative heat of reaction)
% else
%     TP2=TP1-1;%!This is for gasification, where the particle is typically cooler than the gas
% end

TP2=TP1+.5*MAX_T_step;

if DELTIME<1e-6 && DELTIME>1e-9
    TP2=TP1+1e-5;
elseif DELTIME<1e-9 &&DELTIME>1e-15
TP2=TP1+1e-8;
elseif DELTIME<1e-15
    TP2=TP1+1e-11;
end

%initialize the loop
for i=1:5
    PS2RXN(i,1)=PS(i);
end
ICOUNT=1;
%P150='150 END'

goto200;