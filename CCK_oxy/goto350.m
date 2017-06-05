%This script circumvents the lack of a goto command in matlab for the
%specific case of the CCK code stating GOTO 350
%P350='350 START'

[ TP2,DELHCO,DELHCO2,DELHGH2O,DELHGCO2,DELHGH2 ] =...
 HEATSCOMB( TP2 );

DELH = (QCOMB*(DELHCO2*FCO2 + DELHCO*(1. - FCO2))...
        +QH2O*DELHGH2O+QCO2*DELHGCO2+QH2*DELHGH2)/QRXN;
    
%C  Calculate terms in heat balance

CONSO2 = QCOMB*STOICH;
CONSH2O = QH2O*STOICHH2O;
PRODCO2 = QCOMB*FCO2/12.-QCO2*STOICHCO2;
PRODCO = QCOMB*(1.-FCO2)/12.+QCO2*STOICHCO2*2.+QH2O*STOICHH2O;
PRODH2 = CONSH2O-QH2*STOICHH2;
PRODCH4 = 0.5*QH2*STOICHH2;
HRAD = EMISS*STEFBOL*(TP2^4 - TENV^4);


BETA=-(CPCO*(PRODCO)+CPCO2*(PRODCO2)-CONSO2*CPO2...
     	-CPH2O*CONSH2O+CPH2*(PRODH2)+CPCH4*PRODCH4)...
     	*DCCM/(LAMBGAS*XNU);
    
if (TP2-TG)<0
    BETA=-BETA;
end
if BETA^2>1E-6
    TERM=BETA/(exp(BETA)-1);
else
    TERM=1;
end

LAMBDA = LAMBASH*(1-PORFILM)+(LAMBGAS*PORFILM);
RESEXT = 2*DPCM/(LAMBGAS*XNU);
RESINT = (DPCM/DCCM)*(DPCM-DCCM)/LAMBDA;
HCOND = 2*((DPCM/DCCM)^2)*(TP2-TG)/(RESEXT+RESINT);
HTHERM = RHOCP*(1./6.)*DPCM*(TP2 - TPPREV)/DELTIME;
HGEN = HRAD + HCOND + HTHERM;


%C Calculate QHEAT and compare

QHEAT = HGEN/DELH;
QERR2 = QRXN - QHEAT;


%C   Check for zero divide
if abs(QERR2-QERR1)<1E-20
    TP=TP2;
    Q=QRXN;
    goto500;
    return
end
TPNEW=TP2-DAMP*QERR2*(TP2-TP1)/(QERR2-QERR1);



%C  Prevent huge jumps 

if TPNEW<200
    TPNEW=TGUESS-3*ICOUNT*(-1^ICOUNT);
end
if TPNEW>3200
    TPNEW=2000+3*ICOUNT*(-1^ICOUNT);
end

SUMERR = (2.*QERR2/(QRXN+QHEAT+1.E-10))^2;
SUMTERR = ((TP2 - TP1)/TP2)^2;
SMALLTST = QRXN^2+QHEAT^2;

if (SUMERR>TOL)&&(SMALLTST>2E-15)
    if (ICOUNT<100)&&(SUMTERR>1E-25)
        TP1=TP2;
        QERR1=QERR2;
        TP2=TPNEW;
        ICOUNT=ICOUNT+1;
        goto200;
        return
    else
        TP=TP2;
        Q=QRXN;
        IFLAGERR=IFLAGERR+1;
    end
else
    TP=TP2;
    Q=QRXN;
end
%the following if statement flags an error if P or Q did not converge
%Note that this error returns values before the computations in foto500,
%so the new (erroneous) outputs aren't computed
if ICOUNT>=100
    CONVERGENCE='No Q/Ps convergence'
    DELTIME
    con_flag=1;
    return
else
    FLAG=3;
end

goto500; 
return
