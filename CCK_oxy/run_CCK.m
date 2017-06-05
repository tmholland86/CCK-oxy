path(pathdef)
clear;
clc;
close all;
addpath('./CPD_code/');

% create the in_mat
%define the second input matrix to input the coeffecients for velocity,
%temperature, and gas profiles
c1=1;
in_mat_2=zeros(18,1);
in_mat_2(c1,1)=-387.5463104006;%VC1 (the Height^6 coefficient) 
c1=c1+1;
in_mat_2(c1,1)=1271.5930763781;%VC2 (the Height^5 coefficient)
c1=c1+1;
in_mat_2(c1,1)=-1618.3228152897;%VC3 (the Height^4 coefficient)
c1=c1+1;
in_mat_2(c1,1)=1004.4534181925;%VC4 (the Height^3 coefficient)
c1=c1+1;
in_mat_2(c1,1)=-312.7577555722;%VC5 (the Height^2 coefficient)
c1=c1+1;
in_mat_2(c1,1)=45.9320832419;%VC6 (the Height^1 coefficient)
c1=c1+1;
in_mat_2(c1,1)=1.5293369834;%VC7 (the Height^0 coefficient)
c1=c1+1;
in_mat_2(c1,1)=-40848.1245901584;%TC1 (the Height^6 coefficient) 
c1=c1+1;
in_mat_2(c1,1)=136054.8286013380;%TC2 (the Height^5 coefficient) 
c1=c1+1;
in_mat_2(c1,1)=-176203.7594943340;%TC3 (the Height^4 coefficient) 
c1=c1+1;
in_mat_2(c1,1)=111400.5645623280;%TC4 (the Height^3 coefficient) 
c1=c1+1;
in_mat_2(c1,1)=-35214.4185747858;%TC5 (the Height^2 coefficient) 
c1=c1+1;
in_mat_2(c1,1)= 4136.9913421523;%TC6 (the Height^1 coefficient) 
c1=c1+1;
in_mat_2(c1,1)=1575.4851459671;%TC7 (the Height^0 coefficient) 
c1=c1+1;
%% generate some more inputs via CPD input correlations and CPDheat
C=68.96;
H=5;
vol=49.34;
O=16.04;
N=6;
S=4;
HR_i=1e5;
[Mdel,MW,p0,sigp1,c0]=CPD_inputs(C,H,O,N,S,vol);%get CPD inputs
cpd_driver;%runs [HTVL_rec,ftar_rec,fgas_rec,time_rec,Tp_rec]=cpdheat(Input_matrix);

%% Initialize Annealing
% C  Generate initial number of active sites array for annealing
% C  Note: these active site numbers are normalized and sum to 1
bins=100;%number of bins with active sites

%initialize

p0;
HR=HR_i;
tf=45.5500001405387;
tr=299.1777554419302;
Tpeak=1950;%This is only an estimate
trunc_factor=tf;%This is the activation energy range in kcal/mol inside which the fraction of active sites is truncated
trunc_rat=tr;%This is the divisor for the bins to be truncated

%%%
if Tpeak<1500%Turn off the peak temperature effect if the ash isn't likely to melt at the estimated Tpeak value
    c=0;
end
   
%New annealing model
a=0.3559748784187;
b=1.5309495940722;
c=0.0365191139631;
LNSIGMA=0.6788563032197;
LNEDMEAN=a*p0+b+Tpeak*.001*c;
LNSIGMA=LNSIGMA/p0;
AD=exp(27.9661306234608);

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
%% Find ZONE1FAC and intial height
%Height coefficients are in_mat_2 1:7
HEIGHT=0;%initial meters of height from burner
Tp_rec(end+1,1)=Tp_rec(end);
for ii=1:max(size(time_rec))
    hr(ii,1)=HEIGHT;
    if ii==1
        DELT=time_rec(1,1);
    else
    DELT=time_rec(ii,1)-time_rec(ii-1,1);
    end
    vloc=@(HEIGHT) in_mat_2(1,1)*HEIGHT^6+in_mat_2(2,1)*HEIGHT^5+in_mat_2(3,1)*HEIGHT^4+...
        in_mat_2(4,1)*HEIGHT^3+in_mat_2(5,1)*HEIGHT^2+in_mat_2(6,1)*HEIGHT+in_mat_2(7,1);%in m/s
    HEIGHT=HEIGHT+vloc(HEIGHT)*DELT;%in meters
    [ T,DELT,NED,ZONE1FAC ]  =...
  DELTAANNEAL( Tp_rec(ii,1),DELT,NED,AD,EDS,bins );
    ZONE1FAC;
    HEIGHT;
end

NED_CPD=NED;
%% Complete in_mat_2 values
in_mat_2(c1,1)=HEIGHT;%HEIGHT;%initial particle height in meters
c1=c1+1;
in_mat_2(c1,1)=10;%maximum temperature step
c1=c1+1;
in_mat_2(c1,1)=time_rec(end);%initial residence time in seconds
c1=c1+1;
in_mat_2(c1,1)=0;%the fraction carbon already consumed when the code begins
%% Second in mat


c2=1;
in_mat_base(c2,1)=.1;%total time that the particle is in the system. Devolatilization is instantaneous, as is swelling
c2=c2+1;
in_mat_base(c2,1)=C;%COALC, the % of carbon in the raw coal
c2=c2+1;
in_mat_base(c2,1)=H;%COALH, the % of hydrogen in the raw coal
c2=c2+1;
in_mat_base(c2,1)=5.34;% percent ash on a dry basis from ASTM analysis
c2=c2+1;
in_mat_base(c2,1)=vol;% percent ASTM volatiles on a daf basis
c2=c2+1;
in_mat_base(c2,1)=HTVL_rec(end);% high heating rate volatiles loss, use -1 to use the correlation, but the CPD value should generally be available
c2=c2+1;
in_mat_base(c2,1)=1; %omega, the swelling coefficient
c2=c2+1;
in_mat_base(c2,1)=0.006642824900390e11;% XK3OI the initial preexponential factor of step 3
c2=c2+1;
in_mat_base(c2,1)=1e11;%XK7OI the initial preexponential factor of step 7
c2=c2+1;
in_mat_base(c2,1)=1.3;%FUELROC, initial apparent fuel density in g/cm^3 daf basis
c2=c2+1;
in_mat_base(c2,1)=100;%The initial particle diameter, in microns
c2=c2+1;
in_mat_base(c2,1)=200;%AC, the preexponential factor for computing CO/CO2 ratio
c2=c2+1;
in_mat_base(c2,1)=9000;%EC, the preexponential factor for computing CO/CO2 ratio
c2=c2+1;
in_mat_base(c2,1)=1; %ZN the intrinsic order for combustion step 2
c2=c2+1;
in_mat_base(c2,1)=.8;%Alpha, the mode of burning parameter
c2=c2+1;
in_mat_base(c2,1)=12;%TAUBYF, a random pore model parameter
c2=c2+1;
in_mat_base(c2,1)=4.6;%PSI, a random pore model parameter
c2=c2+1;
in_mat_base(c2,1)=.17;%TPORFILM, the porosity of the thick ash film layer
c2=c2+1;
in_mat_base(c2,1)=5;%DELMONO, the ash grain size in microns
c2=c2+1;
in_mat_base(c2,1)=.005;%XLAMBASH, the thermal conductivity of the ash
c2=c2+1;
in_mat_base(c2,1)=1;%P, the system total pressure in atm
c2=c2+1;
in_mat_base(c2,1)=Tp_rec(end);%Initial particle temperature in K, typcally high because devolatilization is already done, and the particle already hot
c2=c2+1;
in_mat_base(c2,1)=5e4;%XK2OBYK3O, The ratio of step 2 to step 3 prexponential factors in units of (mol/cm^3)^-1. At the default value, this causes the reaction to transition from 0 order to higher order at low T
c2=c2+1;
in_mat_base(c2,1)=1e-6;%XK3OBYK1O, The ratio of step 3 to step 1 prexponential factors in units of (mol/cm^3)^-1. This value can be adjusted as needed to fit for various temperature regimes
c2=c2+1;
in_mat_base(c2,1)=3.61499299e4;%E3
c2=c2+1;
in_mat_base(c2,1)=2.8e4;%E2
c2=c2+1;
in_mat_base(c2,1)=6e3;%E1
c2=c2+1;
in_mat_base(c2,1)=5.70230287e4;%E7
c2=c2+1;
in_mat_base(c2,1)=-1;%E4mE7
c2=c2+1;
in_mat_base(c2,1)=-1;%E4RmE7
c2=c2+1;
in_mat_base(c2,1)=-1;%E5mE7
c2=c2+1;
in_mat_base(c2,1)=-1;%E6mE7
c2=c2+1;
in_mat_base(c2,1)=-1;%E6RmE7
c2=c2+1;
in_mat_base(c2,1)=-1;%E8mE7
c2=c2+1;
in_mat_base(c2,1)=-1;%XK4OBYK7O
c2=c2+1;
in_mat_base(c2,1)=-1;%XK4ROBYK7O
c2=c2+1;
in_mat_base(c2,1)=-1;%XK5OBYK7O
c2=c2+1;
in_mat_base(c2,1)=-1;%XK6OBYK7O
c2=c2+1;
in_mat_base(c2,1)=-1;%XK6ROBYK7O
c2=c2+1;
in_mat_base(c2,1)=-1;%XK8OBYK7O
c2=c2+1;
in_mat_base(c2,1)=2.65;%RHOATRU, the true density of the ash in gm/cm^3
c2=c2+1;
in_mat_base(c2,1)=-1;%The annealing preexponential factor is now hardcoded
c2=c2+1;
in_mat_base(c2,1)=-1;%The natural log of the annealing mean activation energy
c2=c2+1;
in_mat_base(c2,1)=-1;%The natural log of the annealing activation energy variance
c2=c2+1;
in_mat_base(c2,1)=600;%TENV, the environmental temperature
c2=c2+1;
in_mat_base(c2,1)=.36;%O2
c2=c2+1;
in_mat_base(c2,1)=.50;%CO2
c2=c2+1;
in_mat_base(c2,1)=.14;%H2O
c2=c2+1;
in_mat_base(c2,1)=0;%H2
c2=c2+1;
in_mat_base(c2,1)=0;%CO
c2=c2+1;
in_mat_base(c2,1)=-1;%This is ZONE1FAC. If it is negative, it defaults to 1, otherwise it is as predicted from CPD with annealing
c2=c2+1;
in_mat_base(c2,1)=1;%This is a switch to turn swelling off. If it is equal to 1, then the diamater given in DP0 is post pyrolysis, so no additional swelling, but 0 uses Randy's swelling correlation
c2=c2+1;
in_mat_base(c2,1)=HR_i;%Initial particle heating rate
c2=c2+1;
in_mat_base(c2,1)=O;%O Oxygen in the raw coal on a daf basis
c2=c2+1;
in_mat_base(c2,1)=N;%N Nitrogen in the raw coal on a daf basis
c2=c2+1;
in_mat_base(c2,1)=S;%S Sulfur in the raw coal on a daf basis
c2=c2+1;
in_mat_base(c2,1)=Tpeak;%ESTIMATE of Tpeak of the particle, if this is substantially incorrect it should be itterated on to improve the annealing accuracy, but the effect appears to be minor
c2=c2+1;
in_mat_base(c2,1)=42.5;% The daf % of fixed carbon from the proximate and ultimate analysis
c2=c2+1;



%execute CCK
tic
[ CHARBO num_step TP time height] = CCK_func(in_mat_base,in_mat_2,NED_CPD);
toc