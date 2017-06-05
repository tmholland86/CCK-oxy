clear
close all
clc
format long

%% 400x10 matrix for Mdel coal type quantification Expanded data set and model form mu=a*Mdel+b*log(HR)+c*Tpeak

%generate the 7 x's (Mdel, HR_R1, Tpeak_R1, soak_time_R1, HR_ref, Tpeak_ref,
%soak_time_ref) and three original thetas (ln(mu), ln(sigma), and ln(A)). In the
%actual GPMSA front end, use min values a bit lower than these, and range 
%values a bit higher. This will ensure that all the values generated here
%will be away from the 0 and 1 values (which could cause numerical
%diffiulty) when the GPMSA code is run. Note that the log values on the
%boundaries weight the points towards the lower and more interesting values
%of heating rate and soak time.

%the new mu must be limited to it's previous ranges. For this I need to
%find the range on Mdel, Tpeak, and log(HR) that will be allowed, set
%relatively large bounds on a, b, and c, and then reject anything that
%doesn't work out based on multiplying it by the extreme values of log(HR,
%Mdel, and Tpeak

parmat=lhsdesign(1000,7,'criterion','maximin','iterations',15);  

%set initial guesses for minimum and maximum a, b, and c


%a1,b1,c1,lnsig,tr,tf,AD
lb=[0.01;.1;.01;0.2;1;1;log(4000)];%lower bound array
ub=[0.8;3.6;0.65;1.25;300;100;log(1e24)];

xmin=lb'; %lower bounds for
xrange=ub'-lb';%ranges;
 
%transform initial lhs design from [0,1] to desired ranges
parmat=bsxfun(@times, parmat, xrange); 
parmat=bsxfun(@plus, parmat, xmin);


