path(pathdef)
clear all
close all
clc


%%

%a1,b1,c1,lnsig,tr,tf,log(AD)
opt_array = 100*[   0.004560968475567
   0.017738594687027
   0.000731631389293
   0.006477587879040
   1.766408458222123
   0.455500000602342
   0.276020707761541]

% % % 100*[   0.001556366998122
% % %    0.013437080742735
% % %    0.001867101753777
% % %    0.007117003786692
% % %    2.987292238510671
% % %    0.158480108029563
% % %    0.183036802916095]


a1=opt_array(1,1);%med_t(1,1); The Mdel factor
b1=opt_array(2,1);%med_t(1,2); THe constant
c1=opt_array(3,1);%The tpeak factor
AD_l=exp(opt_array(7,1))%10^16;
lnsig=opt_array(4,1);
tr=opt_array(5,1);
tf=opt_array(6,1);


   

addpath('/Users/tholland/Desktop/oxy_annealing/O2_annealing/relearn/CO2_O2_annealing/Best_fit_bimodal/input_and_experimental_data/')
extractdata

clear R1_vec R_ref_vec

col_counter=0;

clear sse sse_r mse mse_r

range=1:size(experimental_inputs,1);
Driver_emulator_10inputs
rr=R1_vec./R_ref_vec;
hp1=plot(range,rr(range),'b*')
hold on
hp2=plot(range,measured_ratio(range),'dr')
%%%
%title('Predicted and Measured Relative Reactivities','FontSize',24)
set(gca, 'FontSize', 24)
xlabel('Data Point #')
ylabel('Particle Reactivity/Reference')
h_legend=legend([hp1,hp2],'Predicted Relative Reactivity','Measured Relative Reactivity');
set(h_legend,'FontSize',14);
%%%


%legend('predicted','measured')
axis([0 (max(range)+10) 0 10])
hold on
% n=4
sse_nf=sum((rr(range)-measured_ratio(range)).^2)
% % % for ii=range
% % %     if measured_ratio(ii)>10
% % %         measured_ratio(ii)=rr(ii);
% % %     end
% % % end
% % % 
% % % sse=sum((rr(range)-measured_ratio(range)).^2)

test_vec=[measured_ratio./rr,1./(measured_ratio./rr)];
for ii=range %This causes the optimization to ignore the unusually high values and just fit the more reasonable values
    if max(test_vec(ii,:))>10000
        measured_ratio(ii)=rr(ii);
    end
end

%sre%The summ of the ratio of predicted to measured, which is possible a better criterion here
test_vec=[measured_ratio./rr,1./(measured_ratio./rr)];%rec
for ii=range
sum_vec(ii,1)=max(test_vec(ii,:));
end
sre=sum(sum_vec)


for ii=1:length(name_cell)
    name_cell{ii,2}=ii;
end

% % figure
% % 
% % plot(1:length(sum_vec),sum_vec,'*')