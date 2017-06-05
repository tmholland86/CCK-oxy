function [R1,Rref]=Execute_annealing_func_6(pars,bins,tf,tr)

%Initialize the model

CH_rat=pars(1,1);
HR_R1=pars(1,2);
Tpeak_R1=pars(1,3);
soak_time_R1=pars(1,4);
HR_ref=pars(1,5);
Tpeak_ref=pars(1,6);
soak_time_ref=pars(1,7);
a=pars(1,8);
b=pars(1,9);
c=pars(1,11);
%c=pars(1,10);
LNSIGMA=pars(1,12);
AD=pars(1,10);

%build the input matrices Thistory for Thistory_test and Thistory_ref
Thistory_R1=[300,HR_R1,(Tpeak_R1-300)/HR_R1,1,CH_rat;Tpeak_R1,0,soak_time_R1,1,0];
Thistory_Rref=[300,HR_ref,(Tpeak_ref-300)/HR_ref,1,CH_rat;Tpeak_ref,0,soak_time_ref,1,0];

[R1,Rref]=analyze_anneal(Thistory_R1,Thistory_Rref,AD,LNSIGMA,a,b,c,bins,tf,tr);%the predicted ratio

    
end