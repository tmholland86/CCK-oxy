function [ CHARBO num_step TP time height] = CCK_func(in_mat,in_mat_2,NED_CPD)

%in_mat is in_mat_base from build_experiment.m, and in_mat_2 is created in
%initiate_input.m. Both contain some situation specific parameters.

dtl=in_mat_2(16);% this imposes a limit on the size of temperature jumps. .1 K consistently has a grid converged solution
cci=in_mat_2(18,1);%carbon fraction already consumed when the code initiates

%note that this code is modified because it is burning only char. OMEGA has
%been set adjusted to an artificial value which forces RHOCHAR to be
%correct. DPO is fed into DPCOAL, which takes the place of the dummy
%variable DPINIT in CBKBURN, so the initial DPO value should be such that
%DPO*OMEGA=the char diameter.

%This function is most useful when specific outputs are selected for a
%given case, otherwise results are best obtained from OUTFILECCK.txt and A

%This is a script to execute the CCK code written by Randy Shurtz and
%translated to MATLAB from FORTRAN by Troy Holland. August 25, 2014

%First, initialize with the program (lines 1-169 of FORTRAN CCK). Values
%that can/should be changed when data is available are set off with 3 rows
%of comments before and after. Those that are equal to themselves have been
%set as imputs in the function version of the CCK code.

time_elapsed=in_mat(1,1);%total time of burn in seconds
DELT=1e-9;%this is just the initial time step, and doesnt really matter any more	! time step, sec	
%INTSTEP=round(time_elapsed/DELT+1);%! Intstep, number of time steps	
%TG=zeros(INTSTEP,1);
%POX=zeros(INTSTEP,1);
%Q=zeros(INTSTEP,1);
%TP=zeros(INTSTEP,1);
%MMO=zeros(INTSTEP,1);
%MCMCO=zeros(INTSTEP,1);
%DP=zeros(INTSTEP,1);
%RHO=zeros(INTSTEP,1);
%DCARB=zeros(INTSTEP,1);
DPO=zeros(20,1);
MODPO=zeros(20,1);
%CLOSS=zeros(INTSTEP,1);
%GLMCMCO=zeros(INTSTEP,1);
%GLBO=zeros(INTSTEP,1);
%TAU=zeros(INTSTEP,1);
%CLOSSCOAL=zeros(INTSTEP,1);
%GLBOCOAL=zeros(INTSTEP,1);
%PCO2=zeros(INTSTEP,1);
%PH2O=zeros(INTSTEP,1);
%PH2=zeros(INTSTEP,1);
%PCO=zeros(INTSTEP,1);
%PNETO2=zeros(INTSTEP,1);
%PNETCO2=zeros(INTSTEP,1);
%PNETH2O=zeros(INTSTEP,1);
%PNETH2=zeros(INTSTEP,1);
%PNETCO=zeros(INTSTEP,1);
%PNETCH4=zeros(INTSTEP,1);
%CONSO2=zeros(INTSTEP,1);
%CONSH2O=zeros(INTSTEP,1);
%PRODCO2=zeros(INTSTEP,1);
%PRODCO=zeros(INTSTEP,1);
%PRODH2=zeros(INTSTEP,1);
%PRODCH4=zeros(INTSTEP,1);
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
COALC=in_mat(2,1);%67.87; 			
COALH=in_mat(3,1);%5.45;						
COALASH=in_mat(4,1);%8.36;	
XAO=COALASH/100;
ASTMVOL=in_mat(5,1);%38.49;			
HTVL=in_mat(6,1);%-1;
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%use cpd to compute HTVL unless there is insufficient proximate and
%ultimate analysis information
if HTVL<0 
    HTVL=1.2*ASTMVOL;
end
HTVL=HTVL/100;
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%OMEGA=in_mat(7,1);%! linear swelling factor d/d0, calculated from Randy Shurtz' correlation below		
XK3OI=in_mat(8,1);%-1;%		! mass-specific intrinsic reactivity (step 3 preex. fact, sec-1) 				
XK7OI=in_mat(9,1);%exp(XK7OI)%		! K7OI, pre-exponential for intrinsic step 7 (termination of H2O gasification), (s^-1), adjusted 1E9 is a good first guess for CO2 gasification				
FUELRHOC=in_mat(10,1);%.242;%		! initial fuel density, daf g/cc 			
NDPO=1;%		! number of particle size bins 
%%%%%%%%%%%% DEFINE THE ENTIRE ARRAYS OF DPO AND MODPO HERE 
DPO=zeros(NDPO,1); %! diameter  in microns				
MODPO=zeros(NDPO,1); %mass fraction (0-1) in diameter bins 
DPO(1,1)=in_mat(11,1);%64/OMEGA;%this gets multiplied by OMEGA, so enter char diameter/OMEGA 
MODPO(1,1)=1;%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%End inputs of particle sizes and bins


AC=in_mat(12,1);%2.00E+02;%		! Ac					
EC=in_mat(13,1);%9.00E+03;%		! Ec					
ZN=in_mat(14,1);%1.00;%		! zn, intrinsic reaction order for step 2					
ALPHA=in_mat(15,1);%0.95;%		! alpha, mode of burning parameter (0.2 for combustion, 0.95 for gasification)				
TAUBYF=in_mat(16,1);%12.0;%		! TaubyF, parameter in effective diffusivity expression					
PSI=in_mat(17,1);%4.6;%		! PSI, structural parameter in random pore model of surface area evolution, negative value turns off random pore model, default should be 4.6					
TPORFILM=in_mat(18,1);%0.17;%		! TPorfilm, porosity of THICK ash film (and final ash particle)					
DELMONO=in_mat(19,1);%5.0;%		! ash grain size (um)					
XLAMBASH=in_mat(20,1);%0.005;%		! thermal conductivity of ash, cal/cm-s-C					
ITRAJ=1;%		! Itraj, a switch, 1 prints single particle trajectories, 0 not					
P=in_mat(21,1);%1.00;%		! total pressure, atm				
TPINIT=in_mat(22,1);%300;%			! initial particle temperature, K 
if TPINIT<300
    TPINIT=300;% Not sure why Randy has this line, but I'll keep it for now
end
    
%%%%%%%%%%% Input the following 7 arrays to give environmental conditions
%%%%%%%%%%% at each time step. The environmental variable are held
%%%%%%%%%%% constant throughtout this experiment, but may have to be
%%%%%%%%%%% modified in the future for variable profiles.
%! Tg(K) Pox (atm) Pco2 (atm) Ph2o (atm) Ph2 (atm) Pco (atm) Tenv (K)  
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%


% % % HEIGHT=0;%inches
% % % 
% % % for i=1:INTSTEP%vloc computes local velocity
% % %     vloc=-.0012567108*HEIGHT^6+.02346797*HEIGHT^5-.1769334133*HEIGHT^4+...
% % %         0.6860584*HEIGHT^3-1.4328*HEIGHT^2+1.4589*HEIGHT+.266;
% % %     HEIGHT=HEIGHT+vloc*DELT*25.4;%in inches
% % %     TG(i,1)=6.29612475*HEIGHT^3+(-56.22208703)*HEIGHT^2+33.32363672*HEIGHT+1802.83677641; %in Kelvin
% % % end


%input coefficients for the polynomial fits of TG and v(x) starting at the
%coefficients for the highest order (ie. VC1 is the coefficient of HEIGHT^6
VC1=in_mat_2(1,1);
VC2=in_mat_2(2,1);
VC3=in_mat_2(3,1);
VC4=in_mat_2(4,1);
VC5=in_mat_2(5,1);
VC6=in_mat_2(6,1);
VC7=in_mat_2(7,1);
TC1=in_mat_2(8,1);
TC2=in_mat_2(9,1);
TC3=in_mat_2(10,1);
TC4=in_mat_2(11,1);
TC5=in_mat_2(12,1);
TC6=in_mat_2(13,1);
TC7=in_mat_2(14,1);
%The constant value for each bulk gas works here, but the code would have
%to be modified to accept a dynamically generated value based on location
%for more complicated scenarios
POX=in_mat(46,1)*P;
PCO2=in_mat(47,1)*P;
PH2O=in_mat(48,1)*P;
PH2=in_mat(49,1)*P;
PCO=in_mat(50,1)*P;

%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%


%Now input the contents of KINETIC.inp
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
XK2OBYK3O=in_mat(23,1);%5.0000E+04;%	! K2OBYK3O, ratio of step 2 to step 3 preex. factors. Units: (mol/cm3)-N: Default Causes transition from zero order to higher order as temperature drops below ~627 degrees C.
XK3OBYK1O=in_mat(24,1);%1.0000E-06;%	! K3OBYK1O, ratio of step 3 to step 1 preex. factors.  Units: (mol/cm3)-1: Default can be increased as needed if data present evidence of higher orders at higher temperatures
E3=in_mat(25,1);%3.2000E+04;%	! E3, intrinsic step 3 activation energy, cal/mol: Default makes numbers reasonable at both high and low temperatures
E2=in_mat(26,1);%2.8000E+04;%	! E2, intrinsic step 2 activation energy, cal/mol: Default value based on 2 chars. Primary function to fit lower temperature data at the tail end of the flame
E1=in_mat(27,1);%6.0000E+03;%	! E1, intrinsic step 1 activation energy, cal/mol: Adsorption step. Only adjust if there is evidence of adsorption control at high Temp. and parameter #2 adjustments aren't sufficient
E7=in_mat(28,1);%-1;%	! E7, intrinsic step 7 (termination of H2O gasification) activation energy, literature 42000 cal/mol. -1 means use correlation
E4mE7=in_mat(29,1);%-1.0000E+00;%	! E4mE7, intrinsic step 4 (CO2 gasification) activation energy minus E7, cal/mol, -1 means use correlation
E4RmE7=in_mat(30,1);%-1.0000E+00;%	! E4RmE7, intrinsic reverse step 4 activation energy minus E7, cal/mol, -1 means use correlation
E5mE7=in_mat(31,1);%-1.0000E+00;%	! E5mE7, intrinsic step 5 (CO2 termination) activation energy minus E7, cal/mol, -1 means use correlation
E6mE7=in_mat(32,1);%-1.0000E+00;%	! E6mE7, intrinsic step 6 (H2O gasification) activation energy minus E7, cal/mol, -1 means use correlation
E6RmE7=in_mat(33,1);%-1.0000E+00;%	! E6RmE7, intrinsic reverse step 6 activation energy minus E7, cal/mol, -1 means use correlation
E8mE7=in_mat(34,1);%-1.0000E+00;%	! E8mE7, intrinsic step 8 (H2 gasification) activation energy minus E7, cal/mol, -1 means use correlation
XK4OBYK7O=in_mat(35,1);%-1.0000E+00;%	! K4OBYK7O, ratio of step 4 to step 7 pre-exponential factors (1/atm),-1 means use correlation
XK4ROBYK7O=in_mat(36,1);%-1.0000E+00;%	! K4ROBYK7O, ratio of reverse step 4 to step 7 pre-exponential factors (1/atm),-1 means use correlation
XK5OBYK7O=in_mat(37,1);%-1.0000E+00;%	! K5OBYK7O, ratio of step 5 to step 7 pre-exponential factors (unitless),-1 means use correlation
XK6OBYK7O=in_mat(38,1);%-1.0000E+00;%	! K6OBYK7O, ratio of step 6 to step 7 pre-exponential factors (1/atm),-1 means use correlation
XK6ROBYK7O=in_mat(39,1);%-1.0000E+00;%	! K6ROBYK7O, ratio of reverse step 6 to step 7 pre-exponential factors (1/atm),-1 means use correlation
XK8OBYK7O=in_mat(40,1);%-1.0000E+00;%	! K8OBYK7O, ratio of step 8 to step 7 pre-exponential factors (1/atm),-1 means use correlation

%More initialization

RHOATRU=in_mat(41,1);%2.65;

AD=in_mat(42,1);%8.863E7;%values needed for the annealing process
LNEDMEAN=in_mat(43,1);%2.8;
LNSIGMA=in_mat(44,1);%0.46;

TENV=in_mat(45,1);%500;

%get annealing inputs including a non-unity ZONE1FAC if CPD is turned on

ZONE1FAC=in_mat(51);
HR=in_mat(53,1);

O=in_mat(54,1);
N=in_mat(55,1);
S=in_mat(56,1);
[Mdel,MW,p0,sigp1,c0]=CPD_inputs(COALC,COALH,O,N,S,ASTMVOL);

Tpeak=in_mat(57,1);%Estimated particle peak temperature

FC=in_mat(58,1);%The % of fixed carbon in the coal
%Calculate OMEGA
if in_mat(52,1)==0
[ OMEGA ] = HR_swelling( HR,sigp1,Mdel,FC/100,ASTMVOL/100);
else 
    OMEGA=1;
end


Initialize_CCK

%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%

%Second, setup the calculations (lines 170-295 of FORTRAN CCK)

Setup_Calculations

%main CCK call

main_CCK_call

%display results
%Results_block;


%%%CHARBO is recalculated below to make it conveniently available to
%%%compute the sum squared of error in an optimization program
CHARBO(1:length(TP),1)=1-MCMCO(1:length(TP),1);
CHARBO_end=CHARBO(end);
num_step=length(CHARBO);

end

