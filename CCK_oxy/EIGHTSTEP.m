function [ K3O,K2OBYK3O,K3OBYK1O,E3,...
      E2,E1,TPART,PS,DEFFC,N,CINCOR,DCCM,STOICH,ETA,ETAC,ETAH,QRXN,K7O,...
      K4OBYK7O,K4ROBYK7O,K5OBYK7O,K6OBYK7O,K6ROBYK7O,K8OBYK7O,...
      E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,QCOMB,QCO2,QH2O,QH2,...
      PSH2O,PSCO2,PSH2,PSCO,DEFFCCO2,DEFFCH2O,DEFFCCO,DEFFCH2,...
      NEFF,NEFFCO2,NEFFH2O ] =...
 EIGHTSTEP( K3O,K2OBYK3O,K3OBYK1O,E3,...
      E2,E1,TPART,PS,DEFFC,N,CINCOR,DCCM,STOICH,ETA,ETAC,ETAH,K7O,...
      K4OBYK7O,K4ROBYK7O,K5OBYK7O,K6OBYK7O,K6ROBYK7O,K8OBYK7O,...
      E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
      PSH2O,PSCO2,PSH2,PSCO,DEFFCCO2,DEFFCH2O,DEFFCCO,DEFFCH2 )
       
%This code has been verified against the original FORTRAN CCK.
% C The following kinetic subroutine, EIGHTSTEP, 
% C carries out the calculation of the 
% C instantaneous rate at a given particle temp- 
% C erature and surface oxygen partial pressure, CO2, H2O, CO, AND H2. 
% C The routine uses the modified 3-step 
% C intrinsic kinetic law of Hurt and Calo together
% C with a generalized modulus for calculation
% C of the internal effectivness factor describing
% C the coupling of chemical reaction and pore diffusion.
% C
% C  Key units: 
% C  RSURF: sec-1; CINCOR: g/cm3; QRXN: g/s-cm2
% C  K1: sec-1(mol/cm3)-1; K2: sec-1(mol/cm3)-N; 
% C  K3: sec-1; CMEAN,CSURF: mol/cm3

%Note that for the output in matlab functions, the name of the output value
%is designated in the CALL of the function, not by what I call my input and
%output arguments here. 

%Note that input arguments are locally defined by the name given here, and do not
%redefine anything in the main script, though they can be redefined within
%the function.

%Initialize all the input arguments at their own value so they have an
%output value if nothing reassigns them here.

%C  Generate the rate constants


TCORR5=TPART;
if TCORR5>1573
    TCORR5=1573;
end
if TCORR5<1073
    TCORR5=1073;
end

K3=K3O*exp(-E3/(1.987*TPART));
K2=K3O*K2OBYK3O*exp(-E2/(1.987*TPART));
K3BYK1=K3OBYK1O*exp((E1-E3)/(1.987*TPART));
K7=K7O*exp(-E7/(1.987*TPART));
K4=K7O*K4OBYK7O*exp(-(E4mE7+E7)/(1.987*TPART));
K4R=K7O*K4ROBYK7O*exp(-(E4RmE7+E7)/(1.987*TPART));
K7BYK5=(1./K5OBYK7O)*exp(E5mE7/(1.987*TCORR5));% !This one is supposed to be different from all the others
K6=K7O*K6OBYK7O*exp(-(E6mE7+E7)/(1.987*TPART));
K6R=K7O*K6ROBYK7O*exp(-(E6RmE7+E7)/(1.987*TPART));
K8=K7O*K8OBYK7O*exp(-(E8mE7+E7)/(1.987*TPART));

%C	CALCULATE GASIFICATION STOICHIOMETRIC RATIOS: MOLE REACTANT GAS/GRAM CARBON

STOICHCO2=1/12;
STOICHH2O=1/12;

% C  Calculate the mean oxygen concentration and 
% C  effective order based on mean concentration (I think effective order
% is a bit of a misnomer, this is just a component of the generalized
% thiele modulus)

CMEAN=(PS/2)/(82.1*TPART);
NEFF1=((N+1)*K2*(CMEAN^N)+K3)/(K3+K2*(CMEAN^N));
NEFF2=-1/(1+(K3BYK1/(2*CMEAN)));
NEFF=NEFF1+NEFF2;


%C  Calculate effective orders for gasification, surface reactant concentrations, and intrinsic rate at that concentration

OMEGA=K7+K7BYK5*K4R*(PSCO+2*PSCO2*DEFFCCO2/DEFFCCO...
             + PSH2O*DEFFCH2O/DEFFCCO)...
             + K6R*(PSH2+PSH2O*DEFFCH2O/DEFFCH2);
ZK1A=K7*K4/OMEGA;
ZK1B=K7*K6/OMEGA;
ZK2=(K7BYK5*K4-2.*K7BYK5*K4R*DEFFCCO2/DEFFCCO)/OMEGA;
ZK3=(K6-K6R*DEFFCH2O/DEFFCH2-K7BYK5*K4R*DEFFCH2O/DEFFCCO)/OMEGA;
NEFFCO2=1-ZK2*PSCO2/(1+ZK2*PSCO2+ZK3*PSH2O);
NEFFH2O=1-ZK3*PSH2O/(1+ZK2*PSCO2+ZK3*PSH2O);
%The if statements keep the reaction order in a reasonable range when ZK
%values are absurdly tiny
if -2>NEFFCO2 | NEFFCO2>3
    NEFFCO2=1;
end
if -2>NEFFH2O | NEFFH2O>3
    NEFFH2O=1;
end
CSCO2=PSCO2/(82.1*TPART);
CSH2O=PSH2O/(82.1*TPART);
RSCO2=ZK1A*PSCO2/(1+ZK2*PSCO2+ZK3*PSH2O);
RSH2O=ZK1B*PSH2O/(1+ZK2*PSCO2+ZK3*PSH2O);

%The if statements keep the reaction from occuring when ZK
%values are absurdly tiny. Removing them can cause significant round off
%error in some conditions
if ZK1A<1e-8
    RSCO2=0;
end
if ZK1B<1e-8
    RSH2O=0;
end
% C  Calculate the surface oxygen concentration, 
% C  and the intrinsic rate at that concentration
CSURF=PS/(82.1*TPART);
RSURF1=(K2*(CSURF^(N+1)))+(K3*CSURF);
RSURF2=CSURF+(K3BYK1/2);
RSURF=RSURF1/RSURF2;

%C  Calculate a generalized Thiele Modulus and effect. factor

if CSURF<1E-10
    ETA=0;
else
    BRACKET=((NEFF+1)/(2*DEFFC))*(RSURF/CSURF)*CINCOR*STOICH;
    THIELE=(DCCM/6)*(BRACKET^.5);
    if THIELE>10
        ETA=1/THIELE;
    elseif THIELE<.1
        ETA=1;
    else
        COTHTHIE=(exp(3.*THIELE)+exp(-3.*THIELE))/...
                  (exp(3.*THIELE)-exp(-3.*THIELE));
        ETA = (1./THIELE)*(COTHTHIE - (1./(3.*THIELE)));
    end
end

%C  Calculate gasification Thiele Moduli and effectiveness factors 

if CSCO2<1E-10
    ETAC=0;
else
    BRACKET=((NEFFCO2+1)/(2*DEFFCCO2))*(RSCO2/CSCO2)*CINCOR*STOICHCO2;
    THIELE=(DCCM/6)*(BRACKET^.5);
    if THIELE>10
        ETAC=1/THIELE;
    elseif THIELE<.1
        ETAC=1;
    else
        COTHTHIE=(exp(3.*THIELE)+exp(-3.*THIELE))/...
                  (exp(3.*THIELE)-exp(-3.*THIELE));
        ETAC = (1./THIELE)*(COTHTHIE - (1./(3.*THIELE)));
    end
end

if CSH2O<1E-10
    ETAH=0;
else
    BRACKET=((NEFFH2O+1)/(2*DEFFCH2O))*(RSH2O/CSH2O)*CINCOR*STOICHH2O;
    THIELE=(DCCM/6)*(BRACKET^.5);
    if THIELE>10
        ETAH=1/THIELE;
    elseif THIELE<.1
        ETAH=1;
    else
        COTHTHIE=(exp(3.*THIELE)+exp(-3.*THIELE))/...
                  (exp(3.*THIELE)-exp(-3.*THIELE));
        ETAH = (1./THIELE)*(COTHTHIE - (1./(3.*THIELE)));
    end
end

%C  Calculate the global rate, QRXN and return 

QCO2=(DCCM/6.)*ETAC*RSCO2*CINCOR;
QH2O=(DCCM/6.)*ETAH*RSH2O*CINCOR;
QH2=(DCCM/6.)*CINCOR*K8*PSH2;
QCOMB=(DCCM/6.)*ETA*RSURF*CINCOR;
QRXN=QCOMB+QCO2+QH2O+QH2;

end

