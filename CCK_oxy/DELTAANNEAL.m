function [ T,DELT,NED,ZONE1FAC ] =...
  DELTAANNEAL( T,DELT,NED,AD,EDS,bins )
%This function tracks annealing with time and temperature.
%This function has been verified agains the original FORTRAN CCK code

% C  This routine alters the char reactivity dynamically as a 
% C  function of the heat treatment history, T(t).  It is based on 
% C  the distributed activation energy annealing model proposed by 
% C  Suuberg and applied to combustion in Hurt et al., 
% C  Combustion and Flame XXX, 1998.
% C  The parameters used in this model are those found in the above
% C  Combustion and Flame article: 
% C     Preexp. Factor: 8.863E7
% C     Nat. log of mean activation energy, Ea, for annealing: 2.8
% C     Nat. log of standard deviation of the Ea distribution: 0.46
% C
% C  This code segment calculates the current deactivation factor, 
% C  ZONE1FAC, given a starting distribution of active sites, a  
% C  particle temp, and a duration.  ZONE1FAC is the ratio of actual 
% C  intrinsic reactivity to the initial intrinsic reactivity - i.e. 
% C  that of the young unannealed char (NOT the reactivity in the  
% C  previous time step at the start of this call).  In other words 
% C  ZONE!FAC is not an incremental annealing factor, but the
% C  total extent of annealing up to this point. The full information
% C  on the state of the particle is passed in and out of DELTAANNEAL
% C  in the form of the NED(I), a 30 length vector expressing the 
% C  current number distribution of active sites as a function of 
% C  their deactivation activation energies, ED. 

%Note that for the output in matlab functions, the name of the output value
%is designated in the CALL of the function, not by what I call my input and
%output arguments here. 

%Note that input arguments are locally defined by the name given here, and do not
%redefine anything in the main script, though they can be redefined within
%the function.



%C Initializations


NEDSUM=0;

for i=1:bins
          ED = EDS(i);
          NED(i)=NED(i)*exp(-DELT*AD*exp(-ED*1000/(1.987*T)));
          NEDSUM = NEDSUM+NED(i);   
end
ZONE1FAC=NEDSUM;

end

