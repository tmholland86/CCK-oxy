%this script read=Thistory_ref(1,2);s a data file and strips out the relevant data to create
%an nX7 matrix with  C/H ratio, HR_R1, Tpeak_R1, soak_time_R1, HR_ref, Tpeak_ref, soak_time_ref
%in the 7 columns

clear experimental_inputs O2_data measured_ratio

%read in the data file

%% Changes Needed
O2_and_CO2_data_script
data_set='all_data';
%% Changes Needed
counter=1;
MMW=3;%Turn on the CPD predictor loop, which will replace the C/H ratio 
%with the a more appropiate value from the CPD correlation
%% Changes Needed
                         % CO2_data
for i=1:length(fieldnames(all_data))%identify and loop through the number of precursors
    datastring=[data_set,'.precursor',num2str(i)];
    CPD_in_mat=(eval([data_set,'.precursor',num2str(i),'.prox_ult']))';%get the proximate and ultimate analysis for the precursor
    [Mdel,MW,p0,sigp1]=CPD_inputs(CPD_in_mat(1,1),CPD_in_mat(2,1),CPD_in_mat(3,1),CPD_in_mat(4,1),CPD_in_mat(5,1),CPD_in_mat(6,1));
 %%   
    for j=1:(length(fieldnames(eval(datastring)))-2)/2%identify and loop through each data point in the precursor
        %extract the Thistory of the data point
        datastring=[data_set,'.precursor',num2str(i),'.data',num2str(j)];
        Thistory_R1=eval(datastring);
        CH_rat=Thistory_R1(1,5);
        HR_R1=Thistory_R1(1,2);
        Tpeak_R1=Thistory_R1(2,1);
        soak_time_R1=Thistory_R1(2,3);
        %extract the name of the data precursor
        datastring=[data_set,'.precursor',num2str(i),'.name'];
        pre_name=eval(datastring);
        %extract the Thistory of the reference sample
        datastring=[data_set,'.precursor',num2str(i),'.dataref'];
        Thistory_ref=eval(datastring);
        HR_ref=Thistory_ref(1,2);
        Tpeak_ref=Thistory_ref(2,1);
        soak_time_ref=Thistory_ref(2,3);
        %extract the measured ratio for this data point
        datastring=[data_set,'.precursor',num2str(i),'.mratio',num2str(j)];
        mratio=eval(datastring);
        
        %record the extracted information in a an input matrix
        experimental_inputs(counter,1)=CH_rat;
        experimental_inputs(counter,2)=HR_R1;
        experimental_inputs(counter,3)=Tpeak_R1;
        experimental_inputs(counter,4)=soak_time_R1;
        experimental_inputs(counter,5)=HR_ref;
        experimental_inputs(counter,6)=Tpeak_ref;
        experimental_inputs(counter,7)=soak_time_ref;
        
        name_cell{counter,1}=[pre_name,' ',num2str(j)];
        
        measured_ratio(counter,1)=mratio;
        
       %change the CH_rat column to a better quantification of coal type
       if MMW==1
           experimental_inputs(counter,1)=Mdel;
       elseif MMW==2
           experimental_inputs(counter,1)=MW;
       elseif MMW==3
           experimental_inputs(counter,1)=p0;
       elseif MMW==4
           experimental_inputs(counter,1)=sigp1;
       end
         %increase the counter
        counter=counter+1;
    end
end

save('experimental_inputs')

% % % n=1
% % % plot(1:20,experimental_inputs(73:92,n)/max(experimental_inputs(73:92,n)),'*')
% % % pause
% % % close all
% % % plot(1:146,experimental_inputs(1:146,n)/max(experimental_inputs(1:146,n)),'*')
