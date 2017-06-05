%this script drives the cpd heat model
%last updated 8/24/2016 by Troy Holland, LANL


%put in the NMR parameters
p0=p0;%		!p0		
c0=c0;%		!c0
sigp1=sigp1;%		!sig+1
mw1=MW;%		!mw
mdel=Mdel;%		!mdel (7 will be subtracted internally to the CPD model)

%Declare pressure(atm), initial temperature(K), heating rates(K/s), final
%temperature(K), and hold time(s).

%%%%NOTE: For anything other than one initial heating rate and one hold
%%%%time (as shown below), the changed needs to be hardcoded into cpdheat.

heating0=HR_i;
Tf0=1600;%This is the temperature that devolatilization more or less ends at. It is set here, but the initial temperature is buriedin cpdheat as 300 K
hold0=0;

heating1=0;
Tf1=1600;
hold1=.001;

P=1;

%add the nitrogen parameters 
fnit=0.0119;%         !fnit (daf mass fraction of nitrogen in unreacted coal)
fst=0.50;%		!fst  (fraction of nitrogen remaining in the char)
fhyd=0.0595;%		!fhyd (daf mass fraction of hydrogen in unreacted coal)
fcar=0.7406;%		!fcar (daf mass fraction of carbon in unreacted coal)
foxy=0.1841;%		!foxy (daf mass fraction of oxygen in unreacted coal)

%Build the input matrix. Note that there are additional inputs that
%shouldn't need to be changed in most cases. These are in cpdheat itself.

Input_matrix=[p0,c0,sigp1,mw1,mdel,heating0,Tf0,hold0,heating1,Tf1,hold1,...
    P,fnit,fst,fhyd,fcar,foxy];

[HTVL_rec,ftar_rec,fgas_rec,time_rec,Tp_rec]=cpdheat(Input_matrix);

