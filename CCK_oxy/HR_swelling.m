function [ OMEGA ] = HR_swelling( HR,sigp1,Mdel,FC,ASTM_vol )
%This function accepts the heating rate (K/s), the coordination number
%(average bridges per cluster), Mdel (the average molecular weight of the side
%chains), the daf fixed carbon fraction, and the ASTM volatile fraction. It produces
% OMEGA=d/d0.

%The information and model used here is found in Randy Shurtz' dissertation
%pages 94-109, BYU, 2011

%Troy Holland, LANL, June 21, 2016

%Note: it is ambiguous from the dissertation if FC really means fixed
%carbon (because the fixed carbon values are not given), and if the ASTM
%volatiles and FC should be in % or a fraction (because the paper states
%fraction, but reports them in %). They should indeed be in some fraction
%less than 1, and FC is in fact the fixed carbon from the proximate
%analysis

s_min=(FC+ASTM_vol)^.333333;%Theoretical lower limit of swelling at infinitely high heating rate
HR_base=5.8e4;%K/s, the base heating rate that the correlation is tuned around;
f_of_P=1;%This correlation is not worrying about pressure effects, but it could in the future
crr=sigp1/Mdel;%coal rank ratio, used throughout this calculation

%Determine the s_var regime
if (0.018<=crr) && (crr<0.207)
    s_var=1.69*crr-0.0309;
elseif (0.207<=crr) && (crr<0.301)
    s_var=-3.37*crr+1.01;
else
    s_var=0;
end

%determine the c_HR regime
if (0.106<crr) && (crr<0.254)
    c_HR=-191*crr^2+68.9*crr-5.16;
else
    c_HR=0;
end

%Calculate HHR swelling
OMEGA_HHR=s_var*(HR_base/HR)^c_HR*f_of_P+s_min;%The high heating rate omega, also used to calculated low heating rate omega

%Calculate low heating rate swelling

%These next heating rates are in the high heating rate regime, and used to
%map to the lower regime
HHR_L=3.37e4;% K/s, The heating rate regime of lowest swelling for the low heating rate calculation
HHR_M=1.63e4;%The heating rate of mid swelling 
HHR_P=8.5e3;%The peak swelling heating rate

%Calculate the 3 associated OMEGA values
OMEGA_HHR_L=s_var*(HR_base/HHR_L)^c_HR*f_of_P+s_min;
OMEGA_HHR_M=s_var*(HR_base/HHR_M)^c_HR*f_of_P+s_min;
OMEGA_HHR_P=s_var*(HR_base/HHR_P)^c_HR*f_of_P+s_min;

%Interpolate in a piecewise manner over 3 regimes for lower heating rate.
%Use the swelling ratios found above for the low, mid, and high swelling,
%but use the equation shown below and the heating rate shown below to find
%m and b

LHR_L=1;%K/s The lowest possible swelling for low heating rate, which is OMEGA=1
LHR_M=1000;% the mid range for low heating rate
LHR_P=8.5e3;%The peak swelling for low heating rate, which crosses over at the peak to HHR swelling

%Find the slope and intercept of the second leg of the piecewise
%correlation (the first leg is m_p1=0, and b_p1=1, i.e. no swelling)
b_p2=OMEGA_HHR_L;%This is the intercept in the linear equation, because log10(1)=0
m_p2=(OMEGA_HHR_M-b_p2)/log10(LHR_M);

%Find the slope and intercept for the third leg of the piecewise
%correlation
rise=OMEGA_HHR_P-OMEGA_HHR_M;
run=log10(LHR_P)-log10(LHR_M);
m_p3=rise/run;
b_p3=OMEGA_HHR_P-m_p3*log10(LHR_P);

%Find where leg 1 begins.
HR_leg1=10^((1-b_p2)/m_p2);

%Calculate lower heating rate

if HR<=HR_leg1
    OMEGA_LHR=1;
elseif HR>HR_leg1 && HR<=LHR_M
    OMEGA_LHR=m_p2*log10(HR)+b_p2;
elseif HR>LHR_M && HR<=LHR_P
    OMEGA_LHR=m_p3*log10(HR)+b_p3;
end



%Set final OMEGA for conditions
if HR>8.5e3
    OMEGA=OMEGA_HHR;
else
    OMEGA=OMEGA_LHR;
end



end

