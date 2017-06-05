function [ TG,POX,P,PS,TENV,E3,E2,E1,AC,EC,N,...
        DP,TPPREV,DELTIME,RHOCP,Q,CHI1,CHI2,TP,TGUESS,...
        DCARB,PORFILM,IFLAGERR,XA,XAO,RHO,XK3O,XK2OBYK3O,...
        XK3OBYK1O,ETA,TAUBYF,LAMBASH,ASHINCOR,ITSOLVE,XK7O,XK4OBYK7O,...
        XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
        E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
        PCO2,PH2O,PH2,PCO,CONSO2,CONSH2O,...
        PRODCO2,PRODCO,PRODH2,PRODCH4,CHI1H2O,CHI1CO2,CHI1H2,...
        CHI2H2O,CHI2CO2,CHI2H2,ETAC,ETAH,NEFF,NEFFCO2,NEFFH2O,...
        con_flag,QCOMB,QH2O,QCO2,QH2] =...
        RATE( TG,POX,P,PS,TENV,E3,E2,E1,AC,EC,N,...
        DP,TPPREV,DELTIME,RHOCP,Q,CHI1,CHI2,TP,TGUESS,...
        DCARB,PORFILM,IFLAGERR,XA,XAO,RHO,XK3O,XK2OBYK3O,...
        XK3OBYK1O,ETA,TAUBYF,LAMBASH,ASHINCOR,ITSOLVE,XK7O,XK4OBYK7O,...
        XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
        E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
        PCO2,PH2O,PH2,PCO,...
     	CHI1H2O,CHI1CO2,CHI1H2,CHI2H2O,CHI2CO2,CHI2H2,...
     	ETAC,ETAH,NEFF,NEFFCO2,NEFFH2O,MAX_T_step )
    

  FLAG=0;
  con_flag=0;
 %PRO='RATE START' 
%This subroutine has been verified against the original FORTRAN CCK code.

% C **************  SUBROUTINE RATE ***********************
% C
% C  This low-level subroutine computes the burning rate, q, and 
% C  particle temperature, TP based on the Reggie Mitchell 1film model, 
% C  modified to include ash effects, the 3-step semi-global reaction 
% C  mechanism of Hurt and Calo, an additional 5-step gasification mechanism
% C  from Liu and Niksa, and a simple intrinsic treatment 
% C  of reaction / diffusion within the porous particle. Required
% C  inputs include parameters that specify the gas environment 
% C  of the particle (TG,POX,P,TENV, etc.), kinetic parameters and the
% C  char thermal inertia terms (TPPREV,RHOCP).  A value for the 
% C  surface oxygen partial pressure, PS, is passed to the  
% C  as a first guess in this search.  This routine uses
% C  subroutine a custom algorithm for converging on the correct  
% C  particle temperature and surface oxygen pressure, that is found
% C  to be both fast and stable for typical combustion conditions. 
% C
% C  The algorithm functions as follows: the converged particle 
% C  temperature, TPPREV is taken as a first guess for the new 
% C  particle temperature from which the burning rate is computed
% C  from the known kinetics, and a heat balance is carried out.  
% C  The residual term in the trial heat balance qerr is  
% C  then driven to zero by adjusting the particle temperature 
% C  via Newton's method.  Within each temperature iteration, 
% C  there is an inner loop that determines the surface partial 
% C  pressure of oxygen at the guessed TP value.  
% C
% C  First written October 1994 for early CBK versions drawing  
% C  from the Sandia global RATE routine written by Prof. 
% C  Reginald Mitchell.   
% C  Revised for CBK8 September 1998 - February 1999.
% C  Revised for CBK/E in August-October, 2001.
% C  Revised for CCK in March-August 2010 and June 2011 at BYU based on the article:
% C  Liu, G.-S. and S. Niksa, 
% C  Progress in Energy and Combustion Science, 30(6), 679-717 (2004)


%Note that for the output in matlab functions, the name of the output value
%is designated in the CALL of the function, not by what I call my input and
%output arguments here. 

%Note that input arguments are locally defined by the name given here, and do not
%redefine anything in the main script, though they can be redefined within
%the function.

%Initialize all the input arguments at their own value so they have an
%output value if nothing reassigns them here.

%initialize IFLAGERR
IFLAGGERR=0;

%C  ************ Limit checking ******************
FLAG=0;
RHOATRU=2.65;
if  DCARB<.001
    TP=TG;
    Q=1E-7;
    IFLAGERR=IFLAGERR+1;
    goto500;
    return
end

if TGUESS<200
    TGUESS=200;
end

%C  ****** Initialization and First Time Through Logic  *******

SH=2;
XNU=2;
EMISS=0.8;
DPCM=DP/10000;
DCCM=DCARB/10000;
FILMDEL=(DPCM-DCCM)/2;
R=1.987;
XACORE=XAO;
XCCORE=1-XAO;
RHOCORE=RHO*(DPCM/DCCM)^3*(1-(XA*(1-ASHINCOR)));
PORINCOR=1-(XAO*RHOCORE/RHOATRU)-(RHOCORE*(1-XAO)/2);
CINCOR=RHOCORE*(1-XAO);

STEFBOL=1.355E-12;
TOL=1E-9;
PTOL=1E-10;
DAMP=1;
PDAMP=1;
ZZZ=1;

%Guess TP
TP1=TGUESS;
if POX<1E-7
    POX=1E-5;
end
if PH2<1E-7
    PH2=1E-5;
end
if PCO2<1E-7
    PCO2=1E-5;
end
if PCO<1E-7
    PCO=1E-5;
end
if PH2O<1E-7
    PH2O=1E-5;
end

if max([POX,PH2,PCO2,PH2O])<.0001
    TP1=TG;
end
TM=(TG+TP1)/2;

%C  Calculate Diff coefficients in mixture(cm^2/s)
MOLF(1)=0;
MOLF(2)=0;
MOLF(3)=PH2/P;
MOLF(4)=PCO2/P;
MOLF(5)=PCO/P;
MOLF(6)=POX/P;
MOLF(7)=PH2O/P;
MOLF(1)=1-sum(MOLF(2:7));%assume the remainder is N2

[ MOLF,P,TM,DO2,DH2O,DN2,DH2,DCO2,DCO ] =...
 DIFFUSE( MOLF,P,TM );

%C  Calculate gas properties (from R.Mitchell RATE routine)

[ TM,MOLF,LAMBGAS,CPCH4,CPH2,CPCO2,CPCO,CPO2,CPH2O ] =...
 GASPROPS( TM,MOLF );

%C  Calculate CO/CO2 ratio

COCO2=AC*exp(-EC/(R*TP1));
FCO2=1/(1+COCO2);
GAMMA=(FCO2-1)/(FCO2+1);
GAMMACO2=-1;
GAMMAH2O=-1;
GAMMAH2=.5;

if abs(GAMMA)<.01
    GAMMA=.01;
end

%C Calculate stoich coefficient: mol O2/gm carbon and max rate of oxidation

STOICH=.5*(1+FCO2)/12;
DEFF=DO2*(PORFILM^2.5);
KDIFF=SH*DO2*DEFF*DPCM/(82.1*TM*STOICH*(SH*FILMDEL*DO2*DCCM+DEFF*DCCM*DCCM));
QMAX=(KDIFF*P/GAMMA)*log(1/(1-GAMMA*POX/P));


%C calculate stoich coefficients for gasification and max rates of gasification

STOICHCO2=1/12;
STOICHH2O=1/12;
STOICHH2=2/12;
DEFFCO2=DCO2*(PORFILM^2.5);
DEFFH2O=DH2O*(PORFILM^2.5);
DEFFH2=DH2*(PORFILM^2.5);
DEFFCO=DCO*(PORFILM^2.5);
KDIFFCO2=SH*DCO2*DEFFCO2*DPCM/(82.1*TM*STOICHCO2*(SH*FILMDEL*DCO2*DCCM+DEFFCO2*DCCM*DCCM));
QMAXCO2 = (KDIFFCO2*P/GAMMACO2)*log(1/(1-GAMMACO2*MOLF(4)));
KDIFFH2O =  SH*DH2O*DEFFH2O*DPCM/(82.1*TM*STOICHH2O*(SH*FILMDEL*DH2O*DCCM+DEFFH2O*DCCM*DCCM));
QMAXH2O = (KDIFFH2O*P/GAMMAH2O)*log(1/(1-GAMMAH2O*MOLF(7)));
KDIFFH2 =  SH*DCO2*DEFFH2*DPCM/(82.1*TM*STOICHH2*(SH*FILMDEL*DH2*DCCM+DEFFH2*DCCM*DCCM));
QMAXH2 = (KDIFFH2*P/GAMMAH2)*log(1/(1-GAMMAH2*MOLF(3)));
%!leave the stoichiometric coefficient off because CO shows up in multiple reactions as a product only    
KDIFFCO =  SH*DCO*DEFFCO*DPCM/(82.1*TM*(SH*FILMDEL*DCO*DCCM+DEFFCO*DCCM*DCCM));   
 
if max([KDIFF,KDIFFCO2,KDIFFH2O,KDIFFH2])<1E-30
    IFLAGGERR=IFLAGGERR+1;
    TP=TG;
    Q=1E-7;
    goto500;
    return
end

%C  Look for q = 0.0 and skip ahead  

if max([POX,PCO2,PH2O,PH2])<.0001
    QCOMB=0;
    QCO2=0;
    QH2O=0;
    QH2=0;
    QRXN=0;
    for i=1:5
        PS1RXN(i)=0;
    end
    
    goto150;
    return

end

 %C  Calculate burning rate from kinetics
 DEFFC = DO2*PORINCOR/TAUBYF;
 DEFFCCO2 = DCO2*(PORINCOR)/TAUBYF;
 DEFFCH2O = DH2O*(PORINCOR)/TAUBYF;
 DEFFCH2 = DH2*(PORINCOR)/TAUBYF;
 DEFFCCO = DCO*(PORINCOR)/TAUBYF;
 
 [ XK3O,XK2OBYK3O,XK3OBYK1O,E3,...
      E2,E1,TP1,PS(1),DEFFC,N,CINCOR,DCCM,STOICH,ETA,ETAC,ETAH,QRXN,XK7O,...
      XK4OBYK7O,XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
      E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,QCOMB,QCO2,QH2O,QH2,...
      PS(2),PS(3),PS(4),PS(5),DEFFCCO2,DEFFCH2O,DEFFCCO,DEFFCH2,...
      NEFF,NEFFCO2,NEFFH2O ] =...
 EIGHTSTEP( XK3O,XK2OBYK3O,XK3OBYK1O,E3,...
      E2,E1,TP1,PS(1),DEFFC,N,CINCOR,DCCM,STOICH,ETA,ETAC,ETAH,XK7O,...
      XK4OBYK7O,XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
      E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
      PS(2),PS(3),PS(4),PS(5),DEFFCCO2,DEFFCH2O,DEFFCCO,DEFFCH2 );
  
if QCOMB>QMAX
    QCOMB=.999*QMAX;
end
if QCO2>QMAXCO2
    QCO2=.999*QMAXCO2;
end
if QH2O>QMAXH2O
    QH2O=.999*QMAXH2O;
end
if QH2>QMAXH2
    QH2=.999*QMAXH2;
end
if (GAMMA^2)<1E-4
    PS1DIFF(1)=POX-QCOMB/KDIFF;
else
    PS1DIFF(1,1)=P/GAMMA*(1-(1-GAMMA*POX/P)*exp(GAMMA*QCOMB/(KDIFF*P)));
end

PS1DIFF(2,1) = PH2O-(QH2O/KDIFFH2O);
PS1DIFF(3,1) = PCO2-((QCO2-QCOMB*FCO2)/KDIFFCO2); %! USE NET SPECIES DEPLETION FLUX
PS1DIFF(4,1) = PH2-((QH2-QH2O*(STOICHH2O/STOICHH2))/KDIFFH2); %! USE NET SPECIES DEPLETION FLUX
PS1DIFF(5,1) = PCO + (2*QCO2+QCOMB*(1-FCO2)+QH2O)/(12*KDIFFCO);%! USE NET SPECIES DEPLETION FLUX AND NOTE THE DIFFERENT SIGN; CO IS A NET PRODUCT RATHER THAN A NET REACTANT	

PS1RXN=zeros(5,1);%This may be totally wrong, but the FORTAN code doesn't indicate anything diffent.

for i=1:5
	   PSERR1(i,1) = PS1DIFF(i)-PS1RXN(i); %!WHERE DOES PS1RXN GET INITIALIZED? IS THIS CORRECT? SHOULD I SET IT TO ZERO OR PBULK?
end
%     
% % C  Calculate heat balance for current Tp guess (Tp1)
% % C
% % C  Calculate Hrxn: These are negative heats of reaction (heats of combustion)  
% % C  from the Gordon-McBride Database (NASA-CEA), using the 1000-2000 K range, 
% % C  which extrapolates down to 600 K and up to 3000 K with less than 5 cal/gm error
% % C  BELOW 600 K a simpler curve fit of the Gordon-McBride Hrxn in the 200-600 K is used
% % C  All of these Hrxn values assume graphite properties for the char

%PRO='RATE END'

goto150;

end



    

