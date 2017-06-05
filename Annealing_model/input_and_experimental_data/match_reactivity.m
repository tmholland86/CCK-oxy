function [ FACTOR ] = match_reactivity( Thistory,AD,LNSIGMA,a,b,c,DELT,bins,tf,tr)
%This code accepts inputs of Thistory (a 4 column matrix containing 
%particle temperature, heating rate, treatment time, and combustion regime),
%AD (preexponential factor for annealing),
%LNSIGMA (natural log of the std deviation of the activation energy in a 
%log-normal distribution),
%LNEDMEAN (the natural log of the mean of the activation energy), DELT (the
%time step in seconds), and bins (the number of divisions for the activation energy)


%initialize
FACTOR=1;%The initial ratio of A/Ao
Mdel=Thistory(1,5);
HR=Thistory(1,2);
Tpeak=Thistory(2,1);
trunc_factor=tf;%This is the activation energy range in kcal/mol inside which the fraction of active sites is truncated
trunc_rat=tr;%This is the divisor for the bins to be truncated

%%%
if Tpeak>1500%Turn off the peak temperature if the conditions are so intense it doesn't matter
    c=0;
end

if sum(Thistory(:,3))<6%This gets rid of a discontinuity in the end of the system
    DELT(:,1)=1e-4;
end

LNEDMEAN=a*Mdel+b+Tpeak*.001*c;
LNSIGMA=LNSIGMA/Mdel;

if HR>=1e4
    AD=Mdel*AD/(log(1e4));
else
    AD=Mdel*AD/(log(HR+2.7));
end
%%%
LNEMIN=LNEDMEAN-3*LNSIGMA;%set min and max bounds for the distribution
LNEMAX=LNEDMEAN+6*LNSIGMA;
DELLNE=(LNEMAX-LNEMIN)/bins;
t=0;%initialize time
for ii=1:2
    if Thistory(ii,3)<DELT(ii)
        DELT(ii)=Thistory(ii,3)/100;
    end
end
tfinal=sum(Thistory(:,3));
nsteps=Thistory(:,3)./DELT;
scounter=2;%initialize the step counter
regime=Thistory(:,4);

%generate the initial log-normal annealing activation energy bin distribution
for i=1:bins
    LNED=LNEMIN+(i-0.5)*DELLNE;
    ED=exp(LNED);
    EDS(i,1)=ED;
    if i==1
        DELE(i,1)=0;
    else
        DELE(i,1)=EDS(i,1)-EDS(i-1,1);
    end
 NED(i)=DELE(i)/ED*(1/(LNSIGMA*2.506))*(exp(-((LNEDMEAN-LNED)^2)/(2*LNSIGMA^2)));
%The above line of code is the log normal PDF multiplied by the range of
%activation energy that the density function covers, resulting in a
%probability of sites having a deactivation activation energy in that
%range, which is the same as the number of sites in question divide by the
%total number of sites, which sums to N/No

end

%Truncate the first part of the log normal distribution to eliminate
%activation energies that are too low, and cause an excessively rapid
%decline in reactivity
trunc_center=exp(LNEDMEAN);
tlb=trunc_center-tf;
tub=trunc_center+tf;
for ii=1:max(size(NED))
if tlb<EDS(ii,1) && EDS(ii,1)<tub
    NED(ii)=NED(ii)/trunc_rat;
end
end
NED=NED/sum(NED);


% % % plot(EDS,NED,'*')
% % % xlabel('Activation energy in kcal')
% % % ylabel('Fraction of initial sites')
% % % pause
counter=1;%%%%%%
fr(1,1)=1;%%%%%%
Tr(1,1)=300;%%%%%%
tr(1,1)=0;%%%%%%
for j=1:length(Thistory(:,1))
    T=Thistory(j,1);%set initial particle temperature for this phase of annealing
    HR=Thistory(j,2);%set heating rate for this phase of annealing
    scounter=2;
while scounter<nsteps(j,1)+2
if regime(j)==1
    for i=scounter:nsteps(j,1)+2
    [ T,DELT(j,1),NED,FACTOR ] =...
    DELTAANNEAL_R1( T,DELT(j,1),NED,AD,EDS,bins );
    scounter=scounter+1;
    counter=counter+1;%%%%%%
    Tr(counter,1)=T;%%%%%%
    fr(counter,1)=FACTOR;%%%%%%
    tr(counter,1)=t;%%%%%%    
    T=T+HR*DELT(j,1);
    t=t+DELT(j,1);

    end
else
    for i=2:nsteps(j,1)+2
    [ T,DELT(j,1),NED,FACTOR ] =...
    DELTAANNEAL_R2( T,DELT(j,1),NED,FACTOR,AD,LNEDMEAN,LNSIGMA,bins );
    scounter=scounter+1;
    T=T+HR*DELT(j,1);
    t=t+DELT(j,1);
    end
end
end
end
% close all
%  plot(tr,fr,tr,Tr/Thistory(2,1))
%  pause



end

