range=1:max(size(experimental_inputs));



bins=100;

%This ten column matrix represents the following 10 inputs, in order: C/H
%ratio, HR_R1, Tpeak_R1, soak_time_R1, HR_ref, Tpeak_ref, soak_time_ref,
%LNEDMEAN, LNSIGMA, and AD
parmat=experimental_inputs;
parmat(:,8)=a1;
parmat(:,9)=b1;
parmat(:,10)=AD_l;
parmat(:,11)=c1;%the Tpeak factor
parmat(:,12)=lnsig;%sigma

%loop through the runs in the input matrix
for i=range
tic
%define the input for the curent run
%pars=[CH_rat,HR_R1,Tpeak_R1,soak_time_R1,HR_ref,Tpeak_ref,soak_time_ref,LNEDMEAN,LNSIGMA,AD]
pars=parmat(i,:);

%execute the model
    i;
    [R1,R_ref]=Execute_annealing_func_6(pars,bins,tf,tr);
    if R1<1e-6
        R1=1e-6;
        end
    if R_ref<1e-6
        R_ref=1e-6;
    end
    R1_vec(i,1)=R1;
    R_ref_vec(i,1)=R_ref;
    
tstop=toc;
trec(i,1)=tstop;

end


%%%save([in_name])

