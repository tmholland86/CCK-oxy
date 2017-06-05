%This model accepts a coal daf elemental composition and the ASTM volatiles as weight %
%to predict Mdel (average molecular weight of aliphatic side chains), MW
%(average molecular weight of a cluster), p0, and sigp1

function [Mdel,MW,p0,sigp1,c0]=CPD_inputs(C,H,O,N,S,vol)

CPD_array=[421.957	1301.41	0.489809	-52.1054
-8.64692	16.3879	-0.00981566	1.63872
0.0463894	-0.187493	0.000133046	-0.0107548
-8.47272	-454.773	0.155483	-1.23688
1.18173	51.7109	-0.0243873	0.0931937
1.15366	-10.072	0.00705248	-0.165673
-0.0434024	0.0760827	0.000219163	0.00409556
0.556772	1.36022	-0.0110498	0.00926097
-0.00654575	-0.0313561	0.000100939	-8.26717E-05];

for ii=1:4
    c1=CPD_array(1,ii);
    c2=CPD_array(2,ii);
    c3=CPD_array(3,ii);
    c4=CPD_array(4,ii);
    c5=CPD_array(5,ii);
    c6=CPD_array(6,ii);
    c7=CPD_array(7,ii);
    c8=CPD_array(8,ii);
    c9=CPD_array(9,ii);
    
    output(ii,1)=c1+c2*C+c3*C^2+c4*H+c5*H^2+c6*O+c7*O^2+c8*vol+c9*vol^2;
end

%% compute c0
if C>89.5
    c0=0.1183*C-10.16;
    if c0>0.36
        c0=0.36;
    end
elseif O>12.5
    c0=0.014*O-0.175;
    if c0>0.15
        c0=0.15;
    end
else
    c0=0;
end

Mdel=output(1,1);
MW=output(2,1);
p0=output(3,1);
sigp1=output(4,1);
end
    