function [ MOLF,P,TM,DO2,DH2O,DN2,DH2,DCO2,DCO ] =...
 DIFFUSE( MOLF,P,TM )
%This subroutine has been tested and demonstrated to match the original
%FORTRAN CCK

%This subroutine calculates the multicomponent gas diffusion

%Note that for the output in matlab functions, the name of the output value
%is designated in the CALL of the function, not by what I call my input and
%output arguments here. 

%Note that input arguments are locally defined by the name given here, and do not
%redefine anything in the main script, though they can be redefined within
%the function.

%Initialize all the input arguments at their own value so they have an
%output value if nothing reassigns them here.

MOLF=MOLF;
P=P;
TM=TM;


%C	Diffusion matrix setup (binary diffusivities without T and P dependence, cm^2/s

D=zeros(7,7);
D(1,2)=1.657E-5;% !N2,CH4
D(1,3)=5.424E-5; %!N2,H2
D(1,4)=1.191E-5; %!N2,CO2
D(1,5)=1.500E-5; %!N2,CO
D(1,6)=1.523E-5; %!N2,O2
D(1,7)=4.339E-7; %!N2,H2O (different T dependence)
D(2,1)=D(1,2);
D(2,3)=5.286E-5; %!CH4,H2
D(2,4)=1.365E-5; %!CH4,CO2
D(2,5)=1.669E-5; %!CH4,CO
D(2,6)=1.711E-5; %!CH4,O2
D(2,7)=4.059E-7; %!CH4,H2O
D(3,1)=D(1,3);
D(3,2)=D(2,3);
D(3,4)=4.713E-05; %!H2,CO2
D(3,5)= 5.487E-05; %!H2,CO
D(3,6)= 5.783E-05;% !H2,O2
D(3,7)=2.146E-6; %!H2,H2O
D(4,1)=D(1,4);
D(4,2)=D(2,4);
D(4,3)=D(3,4);
D(4,5)=1.199E-5; %!CO2,CO
D(4,6)=1.208E-5; %!CO2,O2
D(4,7)=2.726E-7;% !CO2,H2O
D(5,1)=D(1,5);
D(5,2)=D(2,5);
D(5,3)=D(3,5);
D(5,4)=D(4,5);
D(5,6)=1.537E-5; %!CO,O2
D(5,7)=4.272E-7; %!CO,H2O
D(6,7)=4.202E-7;% !O2,H2O
D(6,1)=D(1,6);%
D(6,2)=D(2,6);%
D(6,3)=D(3,6);%
D(6,4)=D(4,6);%
D(6,5)=D(5,6);%
D(7,1)=D(1,7);%
D(7,2)=D(2,7);%
D(7,3)=D(3,7);%
D(7,4)=D(4,7);%
D(7,5)=D(5,7);%
D(7,6)=D(6,7);%

%C  Calculate Diffusivities in mixture(cm^2/s)
DMIX=zeros(7,1);

for i=1:7
    for j=1:7
        if j==i
            DMIX(i)=DMIX(i);
        elseif j==7|i==7
            DMIX(i)=DMIX(i)+MOLF(j)/(D(i,j)*(TM^2.334));%Water has different temperature dependence
        else
            DMIX(i)=DMIX(i)+MOLF(j)/(D(i,j)*(TM^1.67));
        end
        
    end
    DMIX(i)=(1-MOLF(i))/(P*DMIX(i));
end

 DN2=DMIX(1);
 DCH4=DMIX(2);
 DH2=DMIX(3);
 DCO2=DMIX(4);
 DCO=DMIX(5);
 DO2=DMIX(6);
 DH2O=DMIX(7); 
 

end

