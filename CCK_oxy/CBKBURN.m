function [  TG,POX,TENV,P,E3,E2,E1,AC,EC,...
      N,DPINIT,OMEGA,ALPHA,XAO,RHOCINIT,Q,TP,MMO,MCMCO,...
      DP,DCARB,DELT,BOT,TPORFILM,DELMONO,... 
      IFLAGERR,XK3OI,XK2OBYK3O,XK3OBYK1O,TAUBYF,...
      ITRAJ,LAMBASH,TPINIT,XK7OI,XK4OBYK7O,...
      XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
      E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
      PCO2,PH2O,PH2,PCO,CONSO2,CONSH2O,PRODCO2,...
      PRODCO,PRODH2,PRODCH4,OUTFILE,PSI,time,height ] =...
  CBKBURN( POX,TENV,P,E3,E2,E1,AC,EC,...
      N,DPINIT,OMEGA,ALPHA,XAO,RHOCINIT,...
      DELT,BOT,TPORFILM,DELMONO,... 
      IFLAGERR,XK3OI,XK2OBYK3O,XK3OBYK1O,TAUBYF,...
      ITRAJ,LAMBASH,TPINIT,XK7OI,XK4OBYK7O,...
      XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
      E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
      PCO2,PH2O,PH2,PCO,CONSO2,CONSH2O,PRODCO2,...
      PRODCO,PRODH2,PRODCH4,OUTFILE,PSI,HEIGHT,...
      VC1,VC2,VC3,VC4,VC5,VC6,VC7,TC1,TC2,TC3,TC4,TC5,TC6,TC7,time_elapsed...
      ,dtl,time_initial,cci,Tpeak,HR,p0,ZONE1FAC,NED_CPD)

%This function is a single particle burnout model
%This function has been verified against the original FORTRAN CCK code.
%Note that that there are very slight differences in the code as it
%progresses due to slightly different rounding errors in calculation and
%slightly different methods of initializing to zero when, for example, a
%given reactant gas is not present. This is especially noticable in the
%calculation of NEFF in SUBROUTINE EIGHTSTEP because the values are highly
%sensitive to concentrations of gas at the surface. The original CCK code
%has fairly substantial swings back and forth due to initialization errors
%of O2 when no O2 is present. Such initialization errors may be problematic
%or they may be completely innocuous. This must be investigated, but for
%now the matlab code performs similarly to the FORTRAN, so I will leave it
%where it is for the moment.

%Note that for the output in matlab functions, the name of the output value
%is designated in the CALL of the function, not by what I call my input and
%output arguments here. 

%Note that input arguments are locally defined by the name given here, and do not
%redefine anything in the main script, though they can be redefined within
%the function.


%start a timer
tic

% Initialization
DELT_store=DELT;%this value is for reuse if an adjustable time step is needed
imarker=0;
DPINIT=DPINIT*OMEGA;
TP(:,1)=0;
Q(:,1)=0;
MMO(:,1)=0;
MCMCO(:,1)=0;
DP(:,1)=0;
RHO(:,1)=0;
DCARB(:,1)=0;
NEFF(:,1)=0;
NEFFCO2(:,1)=0;
NEFFH2O(:,1)=0;

% C  Generate initial number of active sites array for annealing
% C  Note: these active site numbers are normalized and sum to 1
bins=100;%number of bins with active sites

%initialize

p0;
HR;
tf=45.550000060234204;
tr=176.6408458222123;
Tpeak;%This is only an estimate
trunc_factor=tf;%This is the activation energy range in kcal/mol inside which the fraction of active sites is truncated
trunc_rat=tr;%This is the divisor for the bins to be truncated

%New annealing model
a=0.456096847556700;
b=1.773859468702700;
c=0.073163138929300;
LNSIGMA=0.647758787904000;
LNEDMEAN=a*p0+b+Tpeak*.001*c;
LNSIGMA=LNSIGMA/p0;
AD=9.714647064251753e+11;

%%%
if Tpeak>1500%Turn off the peak temperature effect if the ash isn't likely to melt at the estimated Tpeak value
    c=0;
end

%%%%
%%%%
%%%%
LNEMIN=LNEDMEAN-3*LNSIGMA;
LNEMAX=LNEDMEAN+6*LNSIGMA;
DELLNE=(LNEMAX-LNEMIN)/bins;
if HR>=1e4
    AD=p0*AD/(log(1e4));
else
    AD=p0*AD/(log(HR+2.7));
end

for ii=1:bins
    LNED=LNEMIN+(ii-0.5)*DELLNE;
    ED=exp(LNED);
    EDS(ii,1)=ED;
    if ii==1
        DELE(ii,1)=0;
    else
        DELE(ii,1)=EDS(ii,1)-EDS(ii-1,1);
    end
 NED(ii)=DELE(ii)/ED*(1/(LNSIGMA*2.506))*(exp(-((LNEDMEAN-LNED)^2)/(2*LNSIGMA^2)));
%The above line of code is the log normal PDF multiplied by the range of
%activation energy that the density function covers, resulting in a
%probability of sites having a deactivation activation energy in that
%range, which is the same as the number of sites in question divide by the
%total number of sites, which sums to N/No
end


%Split and shift the peak or the first part of the log normal distribution to eliminate
%activation energies that are too low, and cause an excessively rapid
%decline in reactivity
trunc_center=exp(LNEDMEAN);
tlb=trunc_center-tf;
tub=trunc_center+tf;
for jj=1:max(size(NED))
if tlb<EDS(jj,1) && EDS(jj,1)<tub
    NED(jj)=NED(jj)/trunc_rat;
end
end
NED=NED/sum(NED);



%reset i
i=1;

if ZONE1FAC<0
    ZONE1FAC=1;
elseif ZONE1FAC>0
    NED=NED_CPD;
end
PS=zeros(5,1);
PS(1)=POX(1);
PS(2)=PH2O(1);
PS(3)=PCO2(1);
PS(4)=PH2(1);
PS(5)=PCO(1);


T=time_initial;
time(1,1)=time_initial;%initialize the time counter
height(1,1)=HEIGHT;
XA=XAO;
RHOATRU=2.65;
RHOA=RHOATRU*(1-TPORFILM);
RHO(1)=1/((XA/RHOA)+(1-XA)/RHOCINIT);
M=1E-12*RHO(1)*(3.141/6)*((DPINIT)^3);
MO=M;
MC=M*(1-XA);
MCO=MC;
MC=(1-cci)*MC;
MASH=M*XA;
DP(1)=DPINIT;
MMO(1)=1;
MCMCO(1)=MC/MCO;
ASHINCOR=1;
DCARB(1)=DPINIT;
FILMDEL=0;
TP(1)=TPINIT;
PORFILM=1;

CPASH=(1/4.186)*(0.2767*log(TP(1))-0.8137);
CPCARB=-0.050734+(0.00089834*TP(1))-(5.1026E-7*(TP(1)^2))...
           +(9.705E-11*(TP(1)^3));
CP=XA*CPASH+(1-XA)*CPCARB;
RHOCP=RHO(1)*CP;

ETA=0;
ETA = 0.0;
ETAC = 0.0;
ETAH = 0.0;
CHI1 = 0.0;
CHI2=0.0;
CHI1H2O=0;
CHI2H2O=0;
CHI1CO2=0;
CHI2CO2=0;
CHI1H2=0;
CHI2H2=0;
%C   Find initial burning rate

TGUESS=TPINIT;
ITSOLVE=0;

%Get initial gas temperature
    vloc=VC1*HEIGHT^6+VC2*HEIGHT^5+VC3*HEIGHT^4+...
        VC4*HEIGHT^3+VC5*HEIGHT^2+VC6*HEIGHT+VC7;%in m/s
    HEIGHT=HEIGHT+vloc*DELT;%in meters

TG(1)=TC1*HEIGHT^6+TC2*HEIGHT^5+TC3*HEIGHT^4+TC4*HEIGHT^3+TC5*HEIGHT^2+TC6*HEIGHT^1+TC7; %in Kelvin

[ TG(1),POX(1),P,PS,TENV(1),E3,E2,E1,AC,...
       EC,N,DPINIT,TPINIT,DELT,RHOCP,Q(1),CHI1,CHI2,TP(1),...
       TGUESS,DCARB(1),PORFILM,IFLAGERR,XA,XAO,RHO(1),...
       XK3OI,XK2OBYK3O,XK3OBYK1O,ETA,TAUBYF,LAMBASH,...
       ASHINCOR,ITSOLVE,XK7OI,XK4OBYK7O,...
       XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
       E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
       PCO2(1),PH2O(1),PH2(1),PCO(1),CONSO2(1),...
       CONSH2O(1),PRODCO2(1),PRODCO(1),PRODH2(1),PRODCH4(1),...
       CHI1H2O,CHI1CO2,CHI1H2,CHI2H2O,CHI2CO2,CHI2H2,ETAC,ETAH,...
       NEFF(1),NEFFCO2(1),NEFFH2O(1),con_flag, QCOMB(i),QH2O(i),QCO2(i),QH2(i) ] =...
        RATE( TG(1),POX(1),P,PS,TENV(1),E3,E2,E1,AC,...
       EC,N,DPINIT,TPINIT,DELT,RHOCP,Q(1),CHI1,CHI2,TP(1),...
       TGUESS,DCARB(1),PORFILM,IFLAGERR,XA,XAO,RHO(1),...
       XK3OI,XK2OBYK3O,XK3OBYK1O,ETA,TAUBYF,LAMBASH,...
       ASHINCOR,ITSOLVE,XK7OI,XK4OBYK7O,...
       XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
       E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
       PCO2(1),PH2O(1),PH2(1),PCO(1),...
       CHI1H2O,CHI1CO2,CHI1H2,CHI2H2O,CHI2CO2,CHI2H2,ETAC,ETAH,...
       NEFF(1),NEFFCO2(1),NEFFH2O(1),dtl );
%Adjust the height after each step
    vloc=VC1*HEIGHT^6+VC2*HEIGHT^5+VC3*HEIGHT^4+...
        VC4*HEIGHT^3+VC5*HEIGHT^2+VC6*HEIGHT+VC7;%in m/s
    HEIGHT=HEIGHT+vloc*DELT;%in meters

%C	PUT SPECIES PRODUCTION/CONSUMPTION RATES IN UNITS OF MOL/S/(INITIAL GRAMS OF CHAR)

SA=3.141*(DCARB(1)/10000)^2;
CONSO2(1)=CONSO2(1)*SA/MO;
CONSH2O(1)=CONSH2O(1)*SA/MO;
PRODCO2(1)=PRODCO2(1)*SA/MO;
PRODCO(1)=PRODCO(1)*SA/MO;
PRODH2(1)=PRODH2(1)*SA/MO;
PRODCH4(1)=PRODCH4(1)*SA/MO;
ITSOLVE=1;

%Execute the annealing for a single step

[ TPINIT,DELT,NED,ZONE1FAC ] =...
  DELTAANNEAL( TPINIT,DELT,NED,AD,EDS,bins );

if PSI>0
    SASAO=MCMCO(1)*sqrt(1-PSI*log(MCMCO(1)));
else
    SASAO=1;
end

XK3O=XK3OI*(ZONE1FAC*SASAO);
XK7O=XK7OI*(ZONE1FAC*SASAO);
%initialize i for the while loop
%for i=2:INTSTEP
i=1;

while T<time_elapsed
    i=i+1;
%    T=T+DELT; this statement is moved to the while loop around the main
%    RATE call to catch the self-adjusting DELT

%The factor of 1e6 under DELT is to make sure coals cant burn out on step
%one
if i==2
burn_C=(Q(i-1)*(DELT)*3.141*(DCARB(i-1)/10000)^2);
while burn_C>MC*.0001%don't let the first step eat more than .0001% of the coal

DELT=DELT/10;
burn_C=(Q(i-1)*(DELT)*3.141*(DCARB(i-1)/10000)^2);
end
end

MC=MC-(Q(i-1)*(DELT)*3.141*(DCARB(i-1)/10000)^2);%***** here possible lasw of conservation of mass/diameter/density violation
btQ(i-1)=((Q(i-1)*(DELT)*3.141*(DCARB(i-1)/10000)^2))/MCO;



if MCMCO(end)<10*1e-5

%i should be reduced by 1 because of the nature of the while loop
if i~=1
i=i-1;
end
    MC=0;
    RHO(i)=RHOA;
    M=MASH;
    MCMCO(i,1)=0;
    XA=1;
    MMO(i)=XAO;
    DP(i)=10000*((6*M/(3.141*RHO(i)))^.33333333);
    BOT=DELT*(i-1);
    ETA=0;

% % %     [ TG(i),POX(i),P,PS,TENV(i),E3,E2,E1,AC,...
% % %        EC,N,DP(i),TP(i-1),DELT,RHOCP,Q(i),CHI1,CHI2,TP(i),...
% % %        TP(i-1),DCARB(i),PORFILM,IFLAGERR,XA,XAO,RHO(i),...
% % %        XK3O,XK2OBYK3O,XK3OBYK1O,ETA,TAUBYF,LAMBASH,...
% % %        ASHINCOR,ITSOLVE,XK7O,XK4OBYK7O,...
% % %        XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
% % %        E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
% % %        PCO2(i),PH2O(i),PH2(i),PCO(i),CONSO2(i),...
% % %        CONSH2O(i),PRODCO2(i),PRODCO(i),PRODH2(i),PRODCH4(i),...
% % %       CHI1H2O,CHI1CO2,CHI1H2,CHI2H2O,CHI2CO2,CHI2H2,ETAC,ETAH,...
% % %        NEFF(i),NEFFCO2(i),NEFFH2O(i) ] =...
% % %         RATE( TG(i),POX(i),P,PS,TENV(i),E3,E2,E1,AC,...
% % %        EC,N,DP(i),TP(i-1),DELT,RHOCP,Q(i),CHI1,CHI2,TP(i),...
% % %        TP(i-1),DCARB(i),PORFILM,IFLAGERR,XA,XAO,RHO(i),...
% % %        XK3O,XK2OBYK3O,XK3OBYK1O,ETA,TAUBYF,LAMBASH,...
% % %        ASHINCOR,ITSOLVE,XK7O,XK4OBYK7O,...
% % %        XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
% % %        E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
% % %        PCO2(i),PH2O(i),PH2(i),PCO(i),CONSO2(i),...
% % %      	CONSH2O(i),PRODCO2(i),PRODCO(i),PRODH2(i),...
% % %      	PRODCH4(i),CHI1H2O,CHI1CO2,CHI1H2,CHI2H2O,CHI2CO2,CHI2H2,...
% % %      	ETAC,ETAH,NEFF(i),NEFFCO2(i),NEFFH2O(i) );
 
%Put species production and consumption rates in units of mol/s/initial
%grams of char


    SA=3.141*(DCARB(i)/10000)^2;
    CONSO2(i)=CONSO2(i)*SA/MO;
    CONSH2O(i)=CONSH2O(i)*SA/MO;
    PRODCO2(i)=PRODCO2(i)*SA/MO;
    PRODCO(i)=PRODCO(i)*SA/MO;
    PRODH2(i)=PRODH2(i)*SA/MO;
    PRODCH4(i)=PRODCH4(i)*SA/MO;
    Q(i)=0;
    return
end

%continuing on if the IF statement is not "TRUE"

MCMCO(i,1)=MC/MCO;
ASHINCOR=MCMCO(i,1);
M=MC+MASH;
XA=MASH/M;
MMO(i)=M/MO;
MCORE=MC+MASH*ASHINCOR;

%C  Calculations of particle diameter, carbon core diameter, 
%C  and core density
% % ALPHA=.5;
% % RHOC=RHOCINIT*(MCMCO(i,1)^ALPHA);
% % %RHOCORE=1/((XAO/RHOA)+((1-XAO)/RHOC));erroneous definition
% % DCARB(i)=10000*((6*MCORE/(3.141*RHOC))^0.33333333);


%New density and diameter change model

%Compute the consumption rate per unit volume for each gas species at the
%particle surface

%Define the weighted Eta for this system
ETA_w(i-1)=ETA*QCOMB(i-1)/Q(i-1)+ETAC*QCO2(i-1)/Q(i-1)+ETAH*QH2O(i-1)/Q(i-1)+1*QH2(i-1)/Q(i-1);

SA_init=3.141*(DCARB(1)/10000)^2;%The factor of 10000 converts from microns to cm
Vol_init=3.141/6*(DCARB(1)/10000)^3;%The factor of 10000 converts from microns to cm
rpv=Q(i-1)*SA_init/Vol_init/ETA_w(i-1);%**** here and dmdt in line 349%This is the rate of grams of C consumed by all reactions per unit volume of the carbonaceous core
%The above rate is the rate at the surface of the particle where the
%concentration of the gasseous reactants is highest, so it is the maximum
%rate (hence the division by ETA)

num_int_r(i-1)=rpv*DELT;%this stores the steps of the numerical integral that is check to see if the outermost layer
% % % btH=num_int_r(i-1);
% % % btH
% % % tt2=sum(btQ)
%of char has been consumed yet in accordance with Haugen, Tilghman, and
%mitchell, "The conversion mode of a porous carbon particle during
%oxidation and gasification eq 14"

if sum(num_int_r)>=RHOCINIT
    SA=3.141*(DCARB(i-1)/10000)^2;
    dmdt=-Q(i-1)*SA;%**** here possible conservation of mass violation
    drdt=dmdt*(1-ETA_w(i-1))/(pi*(DCARB(i-1)/10000)^2*RHOC);
    Vol=3.141/6*(DCARB(i-1)/10000)^3;
    drhodt=dmdt*ETA_w(i-1)/Vol;
else
    drdt=0;
    DCARB(i)=DCARB(1);
    SA=3.141*(DCARB(i-1)/10000)^2;
    Vol=3.141/6*(DCARB(i-1)/10000)^3;
    dmdt=-Q(i-1)*SA;
    drhodt=dmdt/Vol;
end


if i==2
    RHOC=RHOCINIT;
    DCARB(i)=10000*((6*MC/(3.141*RHOC))^0.33333333);
else
    RHOC=RHOC+drhodt*DELT;%******hereThis is + because the rate of mass change is negative
    DCARB(i)=10000*((6*MC/(3.141*RHOC))^0.33333333);
    %DCARB(i)=DCARB(i-1)+drdt*DELT*10000;% This form can't be used because it
    %violates the law of conservation of mass. I believe this is because
    %the derivation is only strictly true for first order kinetics where
    %all of thiele's and Haugen's assumptions hold. Such is not the case
    %here, so while the form of the model makes intuitive sense, and is
    %certainly an improvement over the static alpha, it does not perfectly
    %represent this scenario where we compute both the total mass consumed
    %and the rate at which the diameter changes, which leaves no room to
    %independly calculated a density change.
end
    

%C  Treat the ash film  (try thickness of one monolayer first)

DP(i)=DCARB(i)+2*DELMONO;
DPBYDC=DP(i)/DCARB(i);
REGRESS=(DPINIT-DCARB(i))/2;
if REGRESS<DELMONO
    PORFILM=1;   
end
if REGRESS>DELMONO
    PORFILM=1-(XA*(1-MCMCO(i,1))*RHOC/((1-XA)*RHOATRU*((DPBYDC^3)-1)));

%C  If monolayer is too dense, adjust dp and thus film thickness	 

    if PORFILM<TPORFILM
        PORFILM=TPORFILM;
        TERM1=XA*RHOC*(1-MCMCO(i,1))/((1-XA)*RHOATRU*(1-TPORFILM));
        DPBYDC=(TERM1+1)^0.3333333333;
        DP(i)=DPBYDC*DCARB(i);
    end
end

RHO(i)=1E12*M/((3.141/6)*(DP(i)^3));

CPASH=(1/4.186)*(0.2767*log(TP(i-1))-.8137);
CPCARB=-0.050734+(0.00089834*TP(i-1))-...
         (5.1026E-7*(TP(i-1)^2))+(9.705E-11*(TP(i-1)^3));
CP=XA*CPASH+(1-XA)*CPCARB;
RHOCP=RHO(i)*CP;

[ TP(i-1),DELT,NED,ZONE1FAC ] =...
  DELTAANNEAL( TP(i-1),DELT,NED,AD,EDS,bins);

if PSI>0
    SASAO=MCMCO(i,1)*sqrt(1-PSI*log(MCMCO(i,1)));
else
    SASAO=1;
end

XK3O=XK3OI*(ZONE1FAC*SASAO);
XK7O=XK7OI*(ZONE1FAC*SASAO);

TGUESS=TP(i-1);

%Get the local gas temperature
TG(i)=TC1*HEIGHT^6+TC2*HEIGHT^5+TC3*HEIGHT^4+TC4*HEIGHT^3+TC5*HEIGHT^2+TC6*HEIGHT^1+TC7; %in Kelvin

%Get the local gas composition as a function of location
POX(i)=POX(1);
PCO2(i)=PCO2(1);
PH2O(i)=PH2O(1);
PH2(i)=PH2(1);
PCO(i)=PCO(1);

%create a loop to preven sharp temperature jumps
del_Temp=10000;%initializes the while loop
temp_count_2=0;
temp_count=0;
%dtl=.1;
% if i>2000%this adjusts the maximum temperature change allowed to a more stable number
%     dtl=.1;
% end
second_while_count=0;
TGUESS=TP(i-1);%initialize guess at each step
failed_ps=0;

while del_Temp>dtl && failed_ps==0

second_while_count=second_while_count+1;

[ TG(i),POX(i),P,PS,TENV,E3,E2,E1,AC,...
       EC,N,DP(i),TP(i-1),DELT,RHOCP,Q(i),CHI1,CHI2,TP(i),...
       TGUESS,DCARB(i),PORFILM,IFLAGERR,XA,XAO,RHO(i),...
       XK3O,XK2OBYK3O,XK3OBYK1O,ETA,TAUBYF,LAMBASH,...
       ASHINCOR,ITSOLVE,XK7O,XK4OBYK7O,...
       XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
       E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
       PCO2(i),PH2O(i),PH2(i),PCO(i),CONSO2(i),...
       CONSH2O(i),PRODCO2(i),PRODCO(i),PRODH2(i),PRODCH4(i),...
      CHI1H2O,CHI1CO2,CHI1H2,CHI2H2O,CHI2CO2,CHI2H2,ETAC,ETAH,...
       NEFF(i),NEFFCO2(i),NEFFH2O(i),con_flag, QCOMB(i),QH2O(i),QCO2(i),QH2(i)] =...
        RATE( TG(i),POX(i),P,PS,TENV,E3,E2,E1,AC,...
       EC,N,DP(i),TP(i-1),DELT,RHOCP,Q,CHI1,CHI2,TP,...
       TGUESS,DCARB(i),PORFILM,IFLAGERR,XA,XAO,RHO(i),...
       XK3O,XK2OBYK3O,XK3OBYK1O,ETA,TAUBYF,LAMBASH,...
       ASHINCOR,ITSOLVE,XK7O,XK4OBYK7O,...
       XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
       E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,...
       PCO2(i),PH2O(i),PH2(i),PCO(i),...
       CHI1H2O,CHI1CO2,CHI1H2,CHI2H2O,CHI2CO2,CHI2H2,...
     	ETAC,ETAH,NEFF,NEFFCO2,NEFFH2O,dtl );
    DELT_old=DELT;      
    %redo the loop if RATE failed to converge. If it fails to converge for
    %over 30 minutes, break the loop
    if con_flag==1 && toc<1800
        TP(i)=1e6;
        imarker=i;%mark the most recent difficult convergeance
        TGUESS=TP(i-1)+(rand-rand);
    end
    
    if toc>300
        failed_ps=1;
        break
    elseif DELT<1e-10%prevent an infinite loop
% % %         failed_ps=1;
% % %         break
              TP(i)=1e6;
              TGUESS=TP(i-1)+(rand-rand);
              DELT=1e-3;
    end
    
    del_Temp=abs(TP(i)-TP(i-1));
    %adjust time step
    if del_Temp<dtl*.5 && (i-imarker)>10 && T>.0001 && DELT<.0001 && second_while_count<100
        DELT=DELT*2;
        del_Temp=dtl+1;
    elseif del_Temp>dtl 
        DELT=DELT*.1;%shrink the time step to stabalize the code
    elseif del_Temp<dtl*.5 && (i-imarker)>10 && DELT<.0001 && second_while_count<100
        DELT=DELT*2;
        del_Temp=dtl+1;
    end
end
DELT=DELT_old;%the last time DELT is divided is after the time step is accepted, so the "old" DELT is used
   %Adjust the HEIGHT after each step
   vloc=@(HEIGHT) VC1*HEIGHT^6+VC2*HEIGHT^5+VC3*HEIGHT^4+...
        VC4*HEIGHT^3+VC5*HEIGHT^2+VC6*HEIGHT+VC7;%in m/s
   HEIGHT=HEIGHT+vloc(HEIGHT)*DELT;%in meters
T=T+DELT;
time(i,1)=T;
height(i,1)=HEIGHT;

%C	PUT SPECIES PRODUCTION/CONSUMPTION RATES IN UNITS OF MOL/S/(INITIAL GRAMS OF CHAR)

    SA=3.141*(DCARB(i)/10000)^2;
    CONSO2(i)=CONSO2(i)*SA/MO;
    CONSH2O(i)=CONSH2O(i)*SA/MO;
    PRODCO2(i)=PRODCO2(i)*SA/MO;
    PRODCO(i)=PRODCO(i)*SA/MO;
    PRODH2(i)=PRODH2(i)*SA/MO;
    PRODCH4(i)=PRODCH4(i)*SA/MO;
    
%C  Monitor single particle trajectories

% % % if ITRAJ==1
% % %     FILMDEL=(DP(i)-DCARB(i))/2;
% % %     CHARBO=1-MCMCO(i,1);
% % %     PRINTKOS=1E-7*XK3O;
% % %     
% % %     AOUT=[T;CHARBO;DCARB(i);TP(i);PRINTKOS;(XK7O*1E-7);NEFF(i);NEFFH2O(i);NEFFCO2(i);ETA;ETAH;ETAC;CHI1;CHI2;CHI1H2O;CHI2H2O;CHI1CO2;CHI2CO2;CHI1H2;CHI2H2;FILMDEL;PORFILM];
% % %     fprintf(PRINTOUT,'%12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %12.4f %20.4f %20.4f %20.4f %20.4f %20.4f %20.4f %20.4f %20.4f %12.4f %12.4f\n',AOUT);
% % % end
%break the while loop if the computation is taking ridiculous amounts of
%time
if failed_ps==1
break
end
end

%C  For incomplete burnout, set BOT to MCMCO with a minus sign

BOT=-MCMCO(end);

end





