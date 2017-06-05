%This script hardcodes the O2 oxidation data of interest into structures for use in the
%annealing codes. Each data point is named by the name of the Char
%deactivation data tab it came from (ie. Senneca2013...), the coal type,
%heating rate, treatment temperature, and treatment time. For example, a
%char data point taken from Senneca 2013 treated for 5 seconds, heated at a
%rate of 5000K/s, treated at 873 K from Gracem coal, would be named
%Senneca2013_Gr_5000_873_5. Each pair of data points (a test point and the
%reference point) constitute a comparison point, that I am trying to match
%my data to.


%create a list of names and an index so I don't have to manually rename
%all my fields every time I change the number of data points
for i=1:1000
names{i}=['precursor',num2str(i)];
names2{i}=['data',num2str(i)];
names3{i}=['mratio',num2str(i)];
end
index=0;
suspect_data_on=1;%turns on the suspect data if ==1

%Sample data with lables:
%Beeley1996_SAv1_1e4_1273_2=[300,1e4,0.0973,1,15.235;1273,0,2,1,0];
%name......................=[Tinitial,HR1,soak1,regime,C/H (daf);Theat_treatment,HR2,soak2,regime,place holder]

%Turn switches on/off
CJ=1%This switch turns on the 74 data points from Feng et al.
Shim_Ill=1
Shim_BL=1
Shim_Poc=1
BarZiv=1
Gale=1
sen_98R=1
sen_98L=1
O2dat=1
Jay=1%The on/of for the Jayamaran coal
% % % % % %
% % % % % %This section generates a structure containing all useable data
% from O2 oxidation with no reservations on use
% % % % % %
% % % % % %



    
% % % % % %
% % % % % %This section generates a structure containing all useable
%but suspect data from O2 oxidation
% % % % % %
% % % % % %

if O2dat==1%o2 data on/off switch
%% New Precursor

if Shim_BL==1
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Beulah_Lignite_Shim1999';
all_data.(names{index}).prox_ult=[73.2,4.4,20.6,1,.82,42]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Beulah_Lignite_Shim1999 markme
Shim1999_BL_1e5_1514_2=[300,1e5,(1514-300)/1e5,1,16.636;1514,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_BL_1e5_1514_2;
all_data.(names{index}).(names3{index2})=25.73;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Beulah_Lignite_Shim1999 markme
Shim1999_BL_1e5_1735_2=[300,1e5,(1735-300)/1e5,1,16.636;1735,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_BL_1e5_1735_2;
all_data.(names{index}).(names3{index2})=22.28;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Beulah_Lignite_Shim1999
Shim1999_BL_1e5_1925_2=[300,1e5,(1925-300)/1e5,1,16.636;1925,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_BL_1e5_1925_2;
all_data.(names{index}).(names3{index2})=15.02;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor Beulah_Lignite_Shim1999
Shim1999_BL_1e5_2086_2=[300,1e5,(2086-300)/1e5,1,16.636;2086,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_BL_1e5_2086_2;
all_data.(names{index}).(names3{index2})=6.70;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%Beulah_Lignite_Shim1999
Shim1999_BL_1e5_2295_2=[300,1e5,(2295-300)/1e5,1,16.636;2295,0,2,1,0];
all_data.(names{index}).dataref=Shim1999_BL_1e5_2295_2;
end

%% New Precursor
if Shim_Poc==1
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Pocahontas_Shim1999';
all_data.(names{index}).prox_ult=[89.8,5,3.4,1.2,.78,19.2]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Pocahontas_Shim1999 markme
Shim1999_Ps_1e5_1606_2=[300,1e5,(1606-300)/1e5,1,17.960;1606,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_Ps_1e5_1606_2;
all_data.(names{index}).(names3{index2})=22.69;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Pocahontas_Shim1999
Shim1999_Ps_1e5_1809_2=[300,1e5,(1809-300)/1e5,1,17.960;1809,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_Ps_1e5_1809_2;
all_data.(names{index}).(names3{index2})=6.12;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Pocahontas_Shim1999
Shim1999_Ps_1e5_1903_2=[300,1e5,(1903-300)/1e5,1,17.960;1903,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_Ps_1e5_1903_2;
all_data.(names{index}).(names3{index2})=2.68;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor Pocahontas_Shim1999
Shim1999_Ps_1e5_2032_2=[300,1e5,(2032-300)/1e5,1,17.960;2032,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_Ps_1e5_2032_2;
all_data.(names{index}).(names3{index2})=1.43;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor Pocahontas_Shim1999
Shim1999_Ps_1e5_2152_2=[300,1e5,(2152-300)/1e5,1,17.960;2152,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_Ps_1e5_2152_2;
all_data.(names{index}).(names3{index2})=1.0553;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 6 for the precursor Pocahontas_Shim1999
Shim1999_Ps_1e5_2315_2=[300,1e5,(2315-300)/1e5,1,17.960;2315,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_Ps_1e5_2315_2;
all_data.(names{index}).(names3{index2})=1;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref

%reference data point, typically with the most severe heat treatment for the precursor
%Pocahontas_Shim1999
Shim1999_Ps_1e5_2388_2=[300,1e5,(2388-300)/1e5,1,17.960;2388,0,2,1,0];
all_data.(names{index}).dataref=Shim1999_Ps_1e5_2388_2;
end

%% New Precursor
if Shim_Ill==1
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Illinois_6_Shim1999';
all_data.(names{index}).prox_ult=[78.2,5.5,9.8,1.3,5.4,45.5]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Illinois_6_Shim1999 markme
Shim1999_I6_1e5_1585_2=[300,1e5,(1585-300)/1e5,1,14.218;1585,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_I6_1e5_1585_2;
all_data.(names{index}).(names3{index2})=42.517;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 2 for the precursor Illinois_6_Shim1999 markme
Shim1999_I6_1e5_1731_2=[300,1e5,(1731-300)/1e5,1,14.218;1731,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_I6_1e5_1731_2;
all_data.(names{index}).(names3{index2})=31.34;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 3 for the precursor Illinois_6_Shim1999
Shim1999_I6_1e5_1857_2=[300,1e5,(1857-300)/1e5,1,14.218;1857,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_I6_1e5_1857_2;
all_data.(names{index}).(names3{index2})=15.567;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 4 for the precursor Illinois_6_Shim1999
Shim1999_I6_1e5_1957_2=[300,1e5,(1957-300)/1e5,1,14.218;1957,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_I6_1e5_1957_2;
all_data.(names{index}).(names3{index2})=6.943;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 5 for the precursor Illinois_6_Shim1999
Shim1999_I6_1e5_2006_2=[300,1e5,(2006-300)/1e5,1,14.218;2006,0,2,1,0];
all_data.(names{index}).(names2{index2})=Shim1999_I6_1e5_2006_2;
all_data.(names{index}).(names3{index2})=2.683;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%Illinois_6_Shim1999
Shim1999_I6_1e5_2155_2=[300,1e5,(2155-300)/1e5,1,14.218;2155,0,2,1,0];
all_data.(names{index}).dataref=Shim1999_I6_1e5_2155_2;
end
%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='South_African_Senneca2004';
all_data.(names{index}).prox_ult=[80.66,4.51,12.69,1.46,.73,27.4]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor South_African_Senneca2004
Senneca2004_SA_16p7_1514_120=[300,16.7,(1514-300)/16.7,1,17.895;1514,0,120,1,0];
all_data.(names{index}).(names2{index2})=Senneca2004_SA_16p7_1514_120;
all_data.(names{index}).(names3{index2})=2.08;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 2 for the precursor South_African_Senneca2004
Senneca2004_SA_16p7_1465_1800=[300,16.7,(1465-300)/16.7,1,17.895;1465,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Senneca2004_SA_16p7_1465_1800;
all_data.(names{index}).(names3{index2})=1.29;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 3 for the precursor South_African_Senneca2004
Senneca2004_SA_16p7_1438_1800=[300,16.7,(1438-300)/16.7,1,17.895;1438,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Senneca2004_SA_16p7_1438_1800;
all_data.(names{index}).(names3{index2})=1.61;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 4 for the precursor South_African_Senneca2004
Senneca2004_SA_16p7_1173_1800=[300,16.7,(1173-300)/16.7,1,17.895;1173,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Senneca2004_SA_16p7_1173_1800;
all_data.(names{index}).(names3{index2})=6.02;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 5 for the precursor South_African_Senneca2004
Senneca2004_SA_16p7_1173_60=[300,16.7,(1173-300)/16.7,1,17.895;1173,0,60,1,0];
all_data.(names{index}).(names2{index2})=Senneca2004_SA_16p7_1173_60;
all_data.(names{index}).(names3{index2})=10.40;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%South_African_Senneca2004
Senneca2004_SA_16p7_1503_1800=[300,16.7,(1503-300)/16.7,1,17.895;1503,0,1800,1,0];
all_data.(names{index}).dataref=Senneca2004_SA_16p7_1503_1800;



%% New Precursor

if CJ==1
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Cerrejon_Feng2002';
all_data.(names{index}).prox_ult=[81.76,5.15,11.91,1.82,.75,40.13]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1173_0p51=[300,1e4,(1173-300)/1e4,1,15.875;1173,0,0.51,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1173_0p51;
all_data.(names{index}).(names3{index2})=0.7488;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1173_0p75=[300,1e4,(1173-300)/1e4,1,15.875;1173,0,0.75,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1173_0p75;
all_data.(names{index}).(names3{index2})=0.74;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1173_0p9=[300,1e4,(1173-300)/1e4,1,15.875;1173,0,0.9,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1173_0p9;
all_data.(names{index}).(names3{index2})=0.7350;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1173_1p12=[300,1e4,(1173-300)/1e4,1,15.875;1173,0,1.12,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1173_1p12;
all_data.(names{index}).(names3{index2})=0.7250;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1173_1p35=[300,1e4,(1173-300)/1e4,1,15.875;1173,0,1.35,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1173_1p35;
all_data.(names{index}).(names3{index2})=0.6480;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 6 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1173_1p65=[300,1e4,(1173-300)/1e4,1,15.875;1173,0,1.65,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1173_1p65;
all_data.(names{index}).(names3{index2})=0.4920;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 7 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p17=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,.17,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p17;
all_data.(names{index}).(names3{index2})=1.1450;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 8 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p17_2=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.17,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p17_2;
all_data.(names{index}).(names3{index2})=0.5300;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 9 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p13=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.13,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p13;
all_data.(names{index}).(names3{index2})=0.9533;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 10 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p13_2=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.13,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p13_2;
all_data.(names{index}).(names3{index2})=1.0142;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 11 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p20=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.20,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p20;
all_data.(names{index}).(names3{index2})=0.8950;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 12 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p20_2=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.20,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p20_2;
all_data.(names{index}).(names3{index2})=0.7900;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 13 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p23=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.23,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p23;
all_data.(names{index}).(names3{index2})=0.7300;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 14 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p30=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.30,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p30;
all_data.(names{index}).(names3{index2})=0.5620;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 15 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p36=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.36,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p36;
all_data.(names{index}).(names3{index2})=0.4849;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 16 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p12=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.12,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p12;
all_data.(names{index}).(names3{index2})=0.4800;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 17 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p431=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.431,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p431;
all_data.(names{index}).(names3{index2})=0.3720;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 18 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p439=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.439,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p439;
all_data.(names{index}).(names3{index2})=0.5000;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 19 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p54=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.54,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p54;
all_data.(names{index}).(names3{index2})=0.3340;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 20 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p65=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.65,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p65;
all_data.(names{index}).(names3{index2})=0.3090;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 21 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p79=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.79,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p79;
all_data.(names{index}).(names3{index2})=0.3060;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 22 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1273_0p96=[300,1e4,(1273-300)/1e4,1,15.875;1273,0,0.96,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1273_0p96;
all_data.(names{index}).(names3{index2})=0.3019;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 23 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p12=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.12,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p12;
all_data.(names{index}).(names3{index2})=1.0232;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 24 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p16=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.16,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p16;
all_data.(names{index}).(names3{index2})=1.0075;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 25 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p19=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.19,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p19;
all_data.(names{index}).(names3{index2})=0.9809;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 26 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p15=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p15;
all_data.(names{index}).(names3{index2})=0.9811;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 27 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p12_2=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.12,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p12_2;
all_data.(names{index}).(names3{index2})=0.9594;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 28 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p16_2=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.16,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p16_2;
all_data.(names{index}).(names3{index2})=0.9459;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 29 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p13=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.13,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p13;
all_data.(names{index}).(names3{index2})=0.4582;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 30 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p23=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.23,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p23;
all_data.(names{index}).(names3{index2})=0.4003;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 31 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p40=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.40,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p40;
all_data.(names{index}).(names3{index2})=0.3286;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 32 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p33=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.33,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p33;
all_data.(names{index}).(names3{index2})=0.2126;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 33 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p49=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.49,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p49;
all_data.(names{index}).(names3{index2})=0.1893;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 34 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p59=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.59,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p59;
all_data.(names{index}).(names3{index2})=0.1797;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 35 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p73=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.73,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p73;
all_data.(names{index}).(names3{index2})=0.1961;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 36 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1373_0p89=[300,1e4,(1373-300)/1e4,1,15.875;1373,0,0.89,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1373_0p89;
all_data.(names{index}).(names3{index2})=0.1553;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 37 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p22=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.22,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p22;
all_data.(names{index}).(names3{index2})=0.3410;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 38 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p26=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.26,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p26;
all_data.(names{index}).(names3{index2})=0.3187;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 39 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p31=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.31,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p31;
all_data.(names{index}).(names3{index2})=0.1974;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 40 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p34=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.34,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p34;
all_data.(names{index}).(names3{index2})=0.1708;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 41 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p40=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.40,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p40;
all_data.(names{index}).(names3{index2})=0.1527;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 42 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p46=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.46,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p46;
all_data.(names{index}).(names3{index2})=0.1391;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 43 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p57=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.57,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p57;
all_data.(names{index}).(names3{index2})=0.1271;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 44 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p68=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.68,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p68;
all_data.(names{index}).(names3{index2})=0.1130;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 45 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p84=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.84,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p84;
all_data.(names{index}).(names3{index2})=0.1117;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 46 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_1p03=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,1.03,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_1p03;
all_data.(names{index}).(names3{index2})=0.1167;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 47 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_1p25=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,1.25,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_1p25;
all_data.(names{index}).(names3{index2})=0.1040;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 48 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1473_0p17=[300,1e4,(1473-300)/1e4,1,15.875;1473,0,0.17,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1473_0p17;
all_data.(names{index}).(names3{index2})=0.3876;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 49 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p15=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p15;
all_data.(names{index}).(names3{index2})=0.7460;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 50 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p20=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.20,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p20;
all_data.(names{index}).(names3{index2})=0.6467;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 51 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p15_2=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p15_2;
all_data.(names{index}).(names3{index2})=0.6229;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 52 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p23=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.23,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p23;
all_data.(names{index}).(names3{index2})=0.5629;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 53 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p23_2=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.23,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p23_2;
all_data.(names{index}).(names3{index2})=0.5299;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 54 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p28=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.28,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p28;
all_data.(names{index}).(names3{index2})=0.2922;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 55 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p34=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.34,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p34;
all_data.(names{index}).(names3{index2})=0.1774;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 56 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p42=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.42,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p42;
all_data.(names{index}).(names3{index2})=0.1437;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 57 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p51=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.51,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p51;
all_data.(names{index}).(names3{index2})=0.1078;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 58 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p63=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.63,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p63;
all_data.(names{index}).(names3{index2})=0.1200;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 59 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p75=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.75,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p75;
all_data.(names{index}).(names3{index2})=0.0883;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 60 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_0p92=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,0.92,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_0p92;
all_data.(names{index}).(names3{index2})=0.0935;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 61 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1573_1p12=[300,1e4,(1573-300)/1e4,1,15.875;1573,0,1.12,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1573_1p12;
all_data.(names{index}).(names3{index2})=0.1226;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 62 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p15=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p15;
all_data.(names{index}).(names3{index2})=0.3482;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 63 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p14=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.14,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p14;
all_data.(names{index}).(names3{index2})=0.3131;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 64 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p21=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.21,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p21;
all_data.(names{index}).(names3{index2})=0.2356;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 65 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p17=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.17,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p17;
all_data.(names{index}).(names3{index2})=0.2161;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 66 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p22=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.22,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p22;
all_data.(names{index}).(names3{index2})=0.1630;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 67 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p24=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.24,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p24;
all_data.(names{index}).(names3{index2})=0.1167;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 68 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p30=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.30,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p30;
all_data.(names{index}).(names3{index2})=0.1008;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 69 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p37=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.37,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p37;
all_data.(names{index}).(names3{index2})=0.1024;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 70 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p67=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.67,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p67;
all_data.(names{index}).(names3{index2})=0.0780;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 71 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_0p82=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,0.82,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_0p82;
all_data.(names{index}).(names3{index2})=0.0481;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 72 for the precursor Cerrejon_Feng2002
Feng2002_CJ_1e4_1748_1p01=[300,1e4,(1748-300)/1e4,1,15.875;1748,0,1.01,1,0];
all_data.(names{index}).(names2{index2})=Feng2002_CJ_1e4_1748_1p01;
all_data.(names{index}).(names3{index2})=0.0378;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%Cerrejon_Feng2002
Feng2002_CJ_1e4_973_1=[300,1e4,(973-300)/1e4,1,15.875;973,0,1,1,0];
all_data.(names{index}).dataref=Feng2002_CJ_1e4_973_1;
end
%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Pocahontas_Russell1999';
all_data.(names{index}).prox_ult=[91.81,4.48,1.66,1.34,0.51,19.54]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_2073_0p15=[300,1e4,(2073-300)/1e4,1,20.493;2073,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_2073_0p15;
all_data.(names{index}).(names3{index2})=1.6804;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_2073_0p5=[300,1e4,(2073-300)/1e4,1,20.493;2073,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_2073_0p5;
all_data.(names{index}).(names3{index2})=1.1259;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 3 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1273_0p15=[300,1e4,(1273-300)/1e4,1,20.493;1273,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1273_0p15;
all_data.(names{index}).(names3{index2})=2.9200;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 4 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1273_0p5=[300,1e4,(1273-300)/1e4,1,20.493;1273,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1273_0p5;
all_data.(names{index}).(names3{index2})=2.1540;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 5 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1273_2=[300,1e4,(1273-300)/1e4,1,20.493;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1273_2;
all_data.(names{index}).(names3{index2})=1.6104;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 6 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1273_5=[300,1e4,(1273-300)/1e4,1,20.493;1273,0,5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1273_5;
all_data.(names{index}).(names3{index2})=1.5503;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 7 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1673_0p15=[300,1e4,(1673-300)/1e4,1,20.493;1673,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1673_0p15;
all_data.(names{index}).(names3{index2})=1.7970;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 8 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1673_0p5=[300,1e4,(1673-300)/1e4,1,20.493;1673,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1673_0p5;
all_data.(names{index}).(names3{index2})=1.4082;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 9 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1673_2=[300,1e4,(1673-300)/1e4,1,20.493;1673,0,2,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1673_2;
all_data.(names{index}).(names3{index2})=1.3925;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 10 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1673_5=[300,1e4,(1673-300)/1e4,1,20.493;1673,0,5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1673_5;
all_data.(names{index}).(names3{index2})=1.3050;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 11 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1873_0p15=[300,1e4,(1873-300)/1e4,1,20.493;1873,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1873_0p15;
all_data.(names{index}).(names3{index2})=2.1158;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 12 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1873_0p5=[300,1e4,(1873-300)/1e4,1,20.493;1873,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1873_0p5;
all_data.(names{index}).(names3{index2})=1.3375;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 13 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1873_2=[300,1e4,(1873-300)/1e4,1,20.493;1873,0,2,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1873_2;
all_data.(names{index}).(names3{index2})=1.2013;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 14 for the precursor Pocahontas_Russell1999
Russell1999_Po3_1e4_1873_5=[300,1e4,(1873-300)/1e4,1,20.493;1873,0,5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_Po3_1e4_1873_5;
all_data.(names{index}).(names3{index2})=1.0936;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%Pocahontas_Russell1999
Russell1999_Po3_1e4_2073_2=[300,1e4,(2073-300)/1e4,1,20.493;2073,0,2,1,0];
all_data.(names{index}).dataref=Russell1999_Po3_1e4_2073_2;


%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Pitt_8_Russell1999';
all_data.(names{index}).prox_ult=[84.95,5.43,6.9,1.68,.91,41.70]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_2073_0p15=[300,1e4,(2073-300)/1e4,1,15.645;2073,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_2073_0p15;
all_data.(names{index}).(names3{index2})=1.4945;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_2073_0p5=[300,1e4,(2073-300)/1e4,1,15.645;2073,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_2073_0p5;
all_data.(names{index}).(names3{index2})=1.1183;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 3 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1273_0p15=[300,1e4,(1273-300)/1e4,1,15.645;1273,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1273_0p15;
all_data.(names{index}).(names3{index2})=5.4641;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 4 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1273_0p5=[300,1e4,(1273-300)/1e4,1,15.645;1273,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1273_0p5;
all_data.(names{index}).(names3{index2})=4.5324;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 5 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1273_2=[300,1e4,(1273-300)/1e4,1,15.645;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1273_2;
all_data.(names{index}).(names3{index2})=2.7802;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 6 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1273_5=[300,1e4,(1273-300)/1e4,1,15.645;1273,0,5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1273_5;
all_data.(names{index}).(names3{index2})=2.7865;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 7 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1673_0p15=[300,1e4,(1673-300)/1e4,1,15.645;1673,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1673_0p15;
all_data.(names{index}).(names3{index2})=3.0837;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 8 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1673_0p5=[300,1e4,(1673-300)/1e4,1,15.645;1673,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1673_0p5;
all_data.(names{index}).(names3{index2})=2.3270;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 9 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1673_2=[300,1e4,(1673-300)/1e4,1,15.645;1673,0,2,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1673_2;
all_data.(names{index}).(names3{index2})=2.0792;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 10 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1673_5=[300,1e4,(1673-300)/1e4,1,15.645;1673,0,5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1673_5;
all_data.(names{index}).(names3{index2})=2.0283;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 11 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1873_0p15=[300,1e4,(1873-300)/1e4,1,15.645;1873,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1873_0p15;
all_data.(names{index}).(names3{index2})=2.8371;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 12 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1873_0p5=[300,1e4,(1873-300)/1e4,1,15.645;1873,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1873_0p5;
all_data.(names{index}).(names3{index2})=2.0260;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 13 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1873_2=[300,1e4,(1873-300)/1e4,1,15.645;1873,0,2,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1873_2;
all_data.(names{index}).(names3{index2})=1.3893;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 14 for the precursor Pitt_8_Russell1999
Russell1999_P8_1e4_1873_5=[300,1e4,(1873-300)/1e4,1,15.645;1873,0,5,1,0];
all_data.(names{index}).(names2{index2})=Russell1999_P8_1e4_1873_5;
all_data.(names{index}).(names3{index2})=1.3044;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%Pitt_8_Russell1999
Russell1999_P8_1e4_2073_2=[300,1e4,(2073-300)/1e4,1,15.645;2073,0,2,1,0];
all_data.(names{index}).dataref=Russell1999_P8_1e4_2073_2;

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Tillmanstone_Cai1994';
all_data.(names{index}).prox_ult=[91.4,4.4,2.2,1.3,.7,18.1]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Tillmanstone_Cai1994
Cai1999_Tms_5_1223_5=[300,5,(1223-300)/5,1,20.7727;1223,0,5,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_Tms_5_1223_5;
all_data.(names{index}).(names3{index2})=0.6281;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Tillmanstone_Cai1994
Cai1999_Tms_1000_1223_5=[300,1000,(1223-300)/1000,1,20.7727;1223,0,5,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_Tms_1000_1223_5;
all_data.(names{index}).(names3{index2})=0.8958;%the measured value of the reactivity of (names2{index2}) to dataref R1/

%reference data point, typically with the most severe heat treatment for the precursor
%Tillmanstone_Cai1994
Cai1999_Tms_5000_1223_5=[300,5000,(1223-300)/5000,1,20.7727;1223,0,5,1,0];
all_data.(names{index}).dataref=Cai1999_Tms_5000_1223_5;

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Pitt_8_Cai1999';
all_data.(names{index}).prox_ult=[83.2,5.3,9,1.6,.9,41.7]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Pitt_8_Cai1999
Cai1999_P8_1e3_973_2=[300,1e3,(973-300)/1e3,1,15.645;973,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_P8_1e3_973_2;
all_data.(names{index}).(names3{index2})=3.3386;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Pitt_8_Cai1999
Cai1999_P8_1e3_1173_2=[300,1e3,(1173-300)/1e3,1,15.645;1173,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_P8_1e3_1173_2;
all_data.(names{index}).(names3{index2})=2.1695;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 3 for the precursor Pitt_8_Cai1999
Cai1999_P8_1e3_1273_2=[300,1e3,(1273-300)/1e3,1,15.645;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_P8_1e3_1273_2;
all_data.(names{index}).(names3{index2})=0.7964;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 4 for the precursor Pitt_8_Cai1999
Cai1999_P8_1e3_1473_2=[300,1e3,(1473-300)/1e3,1,15.645;1473,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_P8_1e3_1473_2;
all_data.(names{index}).(names3{index2})=0.3423;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 5 for the precursor Pitt_8_Cai1999
Cai1999_P8_1e3_1773_2=[300,1e3,(1773-300)/1e3,1,15.645;1773,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_P8_1e3_1773_2;
all_data.(names{index}).(names3{index2})=0.1372;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 6 for the precursor Pitt_8_Cai1999
Cai1999_P8_5_1273_2=[300,5,(1273-300)/5,1,15.645;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_P8_5_1273_2;
all_data.(names{index}).(names3{index2})=0.6820;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 7 for the precursor Pitt_8_Cai1999
Cai1999_P8_50_1273_2=[300,50,(1273-300)/50,1,15.645;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_P8_50_1273_2;
all_data.(names{index}).(names3{index2})=0.7747;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%Pitt_8_Cai1999
Cai1999_P8_5e3_1273_2=[300,5e3,(1273-300)/5e3,1,15.645;1273,0,2,1,0];
all_data.(names{index}).dataref=Cai1999_P8_5e3_1273_2;

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Linby_Cai1994';
all_data.(names{index}).prox_ult=[81,5.3,11,1.7,1,37.5]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Linby_Cai1994
Cai1999_Lin_1e3_973_2=[300,1e3,(973-300)/1e3,1,15.283;973,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_Lin_1e3_973_2;
all_data.(names{index}).(names3{index2})=2.6711;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Linby_Cai1994
Cai1999_Lin_1e3_1173_2=[300,1e3,(1173-300)/1e3,1,15.283;1173,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_Lin_1e3_1173_2;
all_data.(names{index}).(names3{index2})=1.9243;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 3 for the precursor Linby_Cai1994
Cai1999_Lin_1e3_1273_2=[300,1e3,(1273-300)/1e3,1,15.283;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_Lin_1e3_1273_2;
all_data.(names{index}).(names3{index2})=0.9712;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 4 for the precursor Linby_Cai1994
Cai1999_Lin_1e3_1473_2=[300,1e3,(1473-300)/1e3,1,15.283;1473,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_Lin_1e3_1473_2;
all_data.(names{index}).(names3{index2})=0.4662;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 5 for the precursor Linby_Cai1994
Cai1999_Lin_1e3_1773_2=[300,1e3,(1773-300)/1e3,1,15.283;1773,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_Lin_1e3_1773_2;
all_data.(names{index}).(names3{index2})=0.0976;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 6 for the precursor Linby_Cai1994
Cai1999_Lin_2_1273_2=[300,2,(1273-300)/2,1,15.283;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_Lin_2_1273_2;
all_data.(names{index}).(names3{index2})=0.5033;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 7 for the precursor Linby_Cai1994
Cai1999_Lin_50_1273_2=[300,50,(1273-300)/50,1,15.283;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_Lin_50_1273_2;
all_data.(names{index}).(names3{index2})=0.8555;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%Linby_Cai1994
Cai1999_Lin_5e3_1273_2=[300,5e3,(1273-300)/5e3,1,15.283;1273,0,2,1,0];
all_data.(names{index}).dataref=Cai1999_Lin_5e3_1273_2;

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Illinois_6_APCS_Cai1999';
all_data.(names{index}).prox_ult=[77.7,5,13.5,1.4,2.4,47.4]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Illinois_6_APCS_Cai1999
Cai1999_I6A_1e3_973_2=[300,1e3,(973-300)/1e3,1,15.5400;973,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6A_1e3_973_2;
all_data.(names{index}).(names3{index2})=18.4130;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Illinois_6_APCS_Cai1999
Cai1999_I6A_1e3_1123_2=[300,1e3,(1123-300)/1e3,1,15.5400;1123,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6A_1e3_1123_2;
all_data.(names{index}).(names3{index2})=7.0617;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Illinois_6_APCS_Cai1999
Cai1999_I6A_1e3_1273_2=[300,1e3,(1273-300)/1e3,1,15.5400;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6A_1e3_1273_2;
all_data.(names{index}).(names3{index2})=4.9573;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref

%reference data point, typically with the most severe heat treatment for the precursor
%Illinois_6_APCS_Cai1999
Cai1999_I6A_1e3_1773_2=[300,1e3,(1773-300)/1e3,1,15.540;1773,0,2,1,0];
all_data.(names{index}).dataref=Cai1999_I6A_1e3_1773_2;

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Illinois_6_SBN_Cai1999';
all_data.(names{index}).prox_ult=[75.6,5.8,14.5,1.4,2.7,47]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Illinois_6_SBN_Cai1999
Cai1999_I6S_1e3_973_2=[300,1e3,(973-300)/1e3,1,13.0345;973,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6S_1e3_973_2;
all_data.(names{index}).(names3{index2})=3.2986;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Illinois_6_SBN_Cai1999
Cai1999_I6S_1e3_1123_2=[300,1e3,(1123-300)/1e3,1,13.0345;1123,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6S_1e3_1123_2;
all_data.(names{index}).(names3{index2})=1.1962;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 3 for the precursor Illinois_6_SBN_Cai1999
Cai1999_I6S_1e3_1273_2=[300,1e3,(1273-300)/1e3,1,13.0345;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6S_1e3_1273_2;
all_data.(names{index}).(names3{index2})=0.9477;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 4 for the precursor Illinois_6_SBN_Cai1999
Cai1999_I6S_1e3_1473_2=[300,1e3,(1473-300)/1e3,1,13.0345;1473,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6S_1e3_1473_2;
all_data.(names{index}).(names3{index2})=0.3965;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 5 for the precursor Illinois_6_SBN_Cai1999
Cai1999_I6S_1e3_1773_2=[300,1e3,(1773-300)/1e3,1,13.0345;1773,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6S_1e3_1773_2;
all_data.(names{index}).(names3{index2})=0.1401;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 6 for the precursor Illinois_6_SBN_Cai1999
Cai1999_I6S_2_1273_2=[300,2,(1273-300)/2,1,13.0345;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6S_2_1273_2;
all_data.(names{index}).(names3{index2})=.2569;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 7 for the precursor Illinois_6_SBN_Cai1999
Cai1999_I6S_50_1273_2=[300,50,(1273-300)/50,1,13.0345;1273,0,2,1,0];
all_data.(names{index}).(names2{index2})=Cai1999_I6S_50_1273_2;
all_data.(names{index}).(names3{index2})=0.7955;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref

%reference data point, typically with the most severe heat treatment for the precursor
%Illinois_6_SBN_Cai1999
Cai1999_I6S_5e3_1273_2=[300,5e3,(1273-300)/5e3,1,13.0345;1273,0,2,1,0];
all_data.(names{index}).dataref=Cai1999_I6S_5e3_1273_2;

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='South_African_Barziv2000';
all_data.(names{index}).prox_ult=[80.66,4.51,12.69,1.46,.73,27.4]; %C,H,O,N,S,astm volatiles daf

if BarZiv==1
%data point 1 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_15_773_600=[300,15,(773-300)/15,1,17.8947;773,0,600,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_15_773_600;
all_data.(names{index}).(names3{index2})=18.7208;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_15_973_1200=[300,15,(973-300)/15,1,17.8947;973,0,1200,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_15_973_1200;
all_data.(names{index}).(names3{index2})=11.5053;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;
end

%data point 3 for the precursor South_African_Barziv2000
Barziv2000_SA_15_1173_60=[300,15,(1173-300)/15,1,17.8947;1173,0,60,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_15_1173_60;
all_data.(names{index}).(names3{index2})=6.5816;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor South_African_Barziv2000
Barziv2000_SA_167_1473_1800=[300,167,(1473-300)/167,1,17.8947;1473,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_167_1473_1800;
all_data.(names{index}).(names3{index2})=4.1921;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor South_African_Barziv2000
Barziv2000_SA_167_1673_1800=[300,167,(1673-300)/167,1,17.8947;1673,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_167_1673_1800;
all_data.(names{index}).(names3{index2})=3.3163;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref

%reference data point, typically with the most severe heat treatment for the precursor
%South_African_Barziv2000
Barziv2000_SA_1p67e4_2273_2=[300,1.67e4,(2273-300)/1.67e4,1,17.8947;2273,0,2,1,0];
all_data.(names{index}).dataref=Barziv2000_SA_1p67e4_2273_2;

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='HVB_Naredi2008';
all_data.(names{index}).prox_ult=[80.33,5.95,10.97,1.44,.96,44.43]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor HVB_Naredi2008
Naredi2008_HVB_0p833_1123_5400=[300,0.833,(1123-300)/0.833,1,13.4942;1123,0,5400,1,0];
all_data.(names{index}).(names2{index2})=Naredi2008_HVB_0p833_1123_5400;
all_data.(names{index}).(names3{index2})=0.8273;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor HVB_Naredi2008
Naredi2008_HVB_5e4_1173_0p5=[300,5e4,(1173-300)/5e4,1,13.4942;1173,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Naredi2008_HVB_5e4_1173_0p5;
all_data.(names{index}).(names3{index2})=1.8360;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor HVB_Naredi2008
Naredi2008_HVB_5e4_1373_op5=[300,5e4,(1373-300)/5e4,1,13.4942;1373,0,0.5,1,0];
all_data.(names{index}).(names2{index2})=Naredi2008_HVB_5e4_1373_op5;
all_data.(names{index}).(names3{index2})=1.9624;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%HVB_Naredi2008
Naredi2008_HVB_5e4_1673_0p5=[300,5e4,(1673-300)/5e4,1,13.4942;1673,0,0.5,1,0];
all_data.(names{index}).dataref=Naredi2008_HVB_5e4_1673_0p5;

%% New Precursor
if Gale==1
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Pitt_8_Gale1994';
all_data.(names{index}).prox_ult=[84.95,5.43,6.9,1.68,.91,41.70]; %C,H,O,N,S,astm volatiles daf


%data point 1 for the precursor Pitt_8_Gale1994 markme
Gale1994_P8_3p29e4_1106_0p49=[300,3.29e4,(1106-300)/3.29e4,1,15.6445;1106,0,0.49,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_P8_3p29e4_1106_0p49;
all_data.(names{index}).(names3{index2})=1.8033;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%data point 2 for the precursor Pitt_8_Gale1994
Gale1994_P8_5p38e4_1333_0p28=[300,5.38e4,(1333-300)/5.38e4,1,15.6445;1333,0,0.28,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_P8_5p38e4_1333_0p28;
all_data.(names{index}).(names3{index2})=0.8033;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Pitt_8_Gale1994 markme
Gale1994_P8_3p53e4_986_0p15=[300,3.53e4,(986-300)/3.53e4,1,15.6445;986,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_P8_3p53e4_986_0p15;
all_data.(names{index}).(names3{index2})=3.4426;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor Pitt_8_Gale1994
Gale1994_P8_3p53e4_986_0p15_2=[300,3.53e4,(986-300)/3.53e4,1,15.6445;986,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_P8_3p53e4_986_0p15_2;
all_data.(names{index}).(names3{index2})=3.7705;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor Pitt_8_Gale1994
Gale1994_P8_3p53e4_986_0p15_3=[300,3.53e4,(986-300)/3.53e4,1,15.6445;986,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_P8_3p53e4_986_0p15_3;
all_data.(names{index}).(names3{index2})=3.7705;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%Pitt_8_Gale1994
Gale1994_P8_6p61e4_1627_0p135=[300,6.61e4,(1627-300)/6.61e4,1,15.6445;1627,0,0.135,1,0];
all_data.(names{index}).dataref=Gale1994_P8_6p61e4_1627_0p135;

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Blind_Canyon_Gale1994';
all_data.(names{index}).prox_ult=[81.32,5.81,10.88,1.59,.37,48.11]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Blind_Canyon_Gale1994
Gale1994_BC_2p98e4_1097_0p49=[300,2.98e4,(1097-300)/2.98e4,1,14.0000;1097,0,0.49,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_BC_2p98e4_1097_0p49;
all_data.(names{index}).(names3{index2})=8.9583;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Blind_Canyon_Gale1994
Gale1994_BC_2p42e4_1002_0p294=[300,2.42e4,(1002-300)/2.42e4,1,14.0000;1002,0,0.294,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_BC_2p42e4_1002_0p294;
all_data.(names{index}).(names3{index2})=15.0000;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Blind_Canyon_Gale1994
Gale1994_BC_5p34e4_1333_0p49=[300,5.34e4,(1333-300)/5.34e4,1,14.0000;1333,0,0.49,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_BC_5p34e4_1333_0p49;
all_data.(names{index}).(names3{index2})=4.1667;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref

%reference data point, typically with the most severe heat treatment for the precursor
%Blind_Canyon_Gale1994
Gale1994_BC_6p56e4_1625_0p135=[300,6.56e4,(1625-300)/6.56e4,1,14.0000;1625,0,0.135,1,0];
all_data.(names{index}).dataref=Gale1994_BC_6p56e4_1625_0p135;

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Beulah_Lignite_Gale1994';
all_data.(names{index}).prox_ult=[74.05,4.9,19.13,1.17,.71,49.78]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Beulah_Lignite_Gale1994
Gale1994_BL_3p05e4_1027_0p294=[300,3.05e4,(1027-300)/3.05e4,1,15.1122;1027,0,0.294,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_BL_3p05e4_1027_0p294;
all_data.(names{index}).(names3{index2})=0.6316;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Beulah_Lignite_Gale1994
Gale1994_BL_3p41e4_1095_0p49=[300,3.41e4,(1095-300)/3.41e4,1,15.1122;1095,0,0.49,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_BL_3p41e4_1095_0p49;
all_data.(names{index}).(names3{index2})=0.5263;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Beulah_Lignite_Gale1994
Gale1994_BL_5p9e4_1334_0p49=[300,5.9e4,(1334-300)/5.9e4,1,15.1122;1334,0,0.49,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_BL_5p9e4_1334_0p49;
all_data.(names{index}).(names3{index2})=0.28947;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor Beulah_Lignite_Gale1994
Gale1994_BL_4p02e4_972_0p15=[300,4.02e4,(972-300)/4.02e4,1,15.1122;972,0,0.15,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_BL_4p02e4_972_0p15;
all_data.(names{index}).(names3{index2})=0.2636;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor Beulah_Lignite_Gale1994
Gale1994_BL_4p02e4_1095_0p49=[300,4.02e4,(1095-300)/4.02e4,1,15.1122;1095,0,0.49,1,0];
all_data.(names{index}).(names2{index2})=Gale1994_BL_4p02e4_1095_0p49;
all_data.(names{index}).(names3{index2})=0.6579;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref

%reference data point, typically with the most severe heat treatment for the precursor
%Beulah_Lignite_Gale1994
Gale1994_BL_7p47e4_1625_0p135=[300,7.47e4,(1625-300)/7.47e4,1,15.1122;1625,0,0.135,1,0];
all_data.(names{index}).dataref=Gale1994_BL_7p47e4_1625_0p135;

%Sample data with lables:
%Beeley1996_SAv1_1e4_1273_2=[300,1e4,0.0973,1,15.235;1273,0,2,1,0];
%name......................=[Tinitial,HR1,soak1,regime,C/H (daf);Theat_treatment,HR2,soak2,regime,place holder]
end
end%02 data off switch
% % % % % %
% % % % % %This section generates a structure containing all useable data
% from CO2 reactivity of annealed char
% % % % % %
% % % % % %

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='SA_Senneca_1996';
all_data.(names{index}).prox_ult=[82.5,4.6,13.2,1.46,0.73,27.43]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor SA_Senneca_1996
Senneca1996_SA_16p66_1173_1800=[300,16.66,(1173-300)/16.66,1,17.895;1173,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1996_SA_16p66_1173_1800;
all_data.(names{index}).(names3{index2})=1/1.2603;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor SA_Senneca_1996
Senneca1996_SA_16p66_1173_1800=[300,16.66,(1173-300)/16.66,1,17.895;1173,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1996_SA_16p66_1173_1800;
all_data.(names{index}).(names3{index2})=1/1.2096;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor SA_Senneca_1996
Senneca1996_SA_16p66_1173_1800=[300,16.66,(1173-300)/16.66,1,17.895;1173,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1996_SA_16p66_1173_1800;
all_data.(names{index}).(names3{index2})=1/1.1276;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor SA_Senneca_1996
Senneca1996_SA_16p66_1173_18000=[300,16.66,(1173-300)/16.66,1,17.895;1173,0,18000,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1996_SA_16p66_1173_18000;
all_data.(names{index}).(names3{index2})=1/1.4545;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor SA_Senneca_1996
Senneca1996_SA_16p66_1173_18000=[300,16.66,(1173-300)/16.66,1,17.895;1173,0,18000,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1996_SA_16p66_1173_18000;
all_data.(names{index}).(names3{index2})=1/1.2716;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 6 for the precursor SA_Senneca_1996
Senneca1996_SA_16p66_1173_18000=[300,16.66,(1173-300)/16.66,1,17.895;1173,0,18000,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1996_SA_16p66_1173_18000;
all_data.(names{index}).(names3{index2})=1/1.2980;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref

%reference data point, typically with the most severe heat treatment for the precursor
%SA_Senneca_1996
Senneca1996_SA_16p66_1173_60=[300,16.66,(1173-300)/16.66,1,17.895;1173,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Senneca1996_SA_16p66_1173_60;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='SA_Senneca_1999';
all_data.(names{index}).prox_ult=[82.66,4.51,12.69,1.46,0.73,27.40]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor SA_Senneca_1999
Senneca1999_SA_1p5_1173_60=[300,1.5,(1173-300)/1.5,1,17.895;1173,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_1p5_1173_60;
all_data.(names{index}).(names3{index2})=3.5792;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor SA_Senneca_1999
Senneca1999_SA_1p5_1173_60=[300,1.5,(1173-300)/1.5,1,17.895;1173,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_1p5_1173_60;
all_data.(names{index}).(names3{index2})=3.9237;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor SA_Senneca_1999
Senneca1999_SA_1p5_1173_60=[300,1.5,(1173-300)/1.5,1,17.895;1173,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_1p5_1173_60;
all_data.(names{index}).(names3{index2})=3.3075;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor SA_Senneca_1999
Senneca1999_SA_1p5_1173_1800=[300,1.5,(1173-300)/1.5,1,17.895;1173,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_1p5_1173_1800;
all_data.(names{index}).(names3{index2})=2.9223;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor SA_Senneca_1999
Senneca1999_SA_1p5_1173_1800=[300,1.5,(1173-300)/1.5,1,17.895;1173,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_1p5_1173_1800;
all_data.(names{index}).(names3{index2})=3.1431;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 6 for the precursor SA_Senneca_1999
Senneca1999_SA_1p5_1173_1800=[300,1.5,(1173-300)/1.5,1,17.895;1173,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_1p5_1173_1800;
all_data.(names{index}).(names3{index2})=2.8102;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 7 for the precursor SA_Senneca_1999
Senneca1999_SA_167_1473_1800=[300,167,(1473-300)/167,1,17.895;1473,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_167_1473_1800;
all_data.(names{index}).(names3{index2})=1.5455;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 8 for the precursor SA_Senneca_1999
Senneca1999_SA_167_1473_1800=[300,167,(1473-300)/167,1,17.895;1473,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_167_1473_1800;
all_data.(names{index}).(names3{index2})=2.0524;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 9 for the precursor SA_Senneca_1999
Senneca1999_SA_167_1473_1800=[300,167,(1473-300)/167,1,17.895;1473,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_167_1473_1800;
all_data.(names{index}).(names3{index2})=2.1934;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 10 for the precursor SA_Senneca_1999
Senneca1999_SA_16667_1873_1=[300,16667,(1873-300)/16667,1,17.895;1873,0,1,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_16667_1873_1;
all_data.(names{index}).(names3{index2})=1.8254;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 11 for the precursor SA_Senneca_1999
Senneca1999_SA_16667_1873_1=[300,16667,(1873-300)/16667,1,17.895;1873,0,1,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_16667_1873_1;
all_data.(names{index}).(names3{index2})=2.4651;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 12 for the precursor SA_Senneca_1999
Senneca1999_SA_16667_1873_1=[300,16667,(1873-300)/16667,1,17.895;1873,0,1,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_16667_1873_1;
all_data.(names{index}).(names3{index2})=2.6440;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 13 for the precursor SA_Senneca_1999
Senneca1999_SA_16667_2273_0p2=[300,16667,(2273-300)/16667,1,17.895;2273,0,0.2,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_16667_2273_0p2;
all_data.(names{index}).(names3{index2})=2.4003;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 14 for the precursor SA_Senneca_1999
Senneca1999_SA_16667_2273_0p2=[300,16667,(2273-300)/16667,1,17.895;2273,0,0.2,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_16667_2273_0p2;
all_data.(names{index}).(names3{index2})=2.8878;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 15 for the precursor SA_Senneca_1999
Senneca1999_SA_16667_2273_0p2=[300,16667,(2273-300)/16667,1,17.895;2273,0,0.2,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1999_SA_16667_2273_0p2;
all_data.(names{index}).(names3{index2})=3.1021;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref


%reference data point, typically with the most severe heat treatment for the precursor
%SA_Senneca_1999
Senneca1999_SA_16667_2273_80=[300,16667,(2273-300)/16667,1,17.895;2273,0,80,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Senneca1999_SA_16667_2273_80;


%% New Precursor

%Note that the gasification was at two different temperatures, so even
%though there is only one precursor, the so called "R2" depends on the
%gasification temperature because there is an obvious impact in rate as
%gasifcation temperature changes. Also, gassification time was included
%(estimated) for additional annealing

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Shenfu_2008';
all_data.(names{index}).prox_ult=[80.14,5.52,12.29,1.83,0.22,40.64]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Shenfu_2008                     %24
Shenfu2008_0p1_1223_1200=[300,0.1,(1223-300)/0.1,1,14.51;1223,0,1200,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Shenfu2008_0p1_1223_1200;
all_data.(names{index}).(names3{index2})=1.2993;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Shenfu_2008                     %24
Shenfu2008_0p1_1273_1200=[300,0.1,(1273-300)/0.1,1,14.51;1273,0,1200,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Shenfu2008_0p1_1273_1200;
all_data.(names{index}).(names3{index2})=1.2015;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Shenfu_2008
Shenfu2008_0p1_1673_1200=[300,0.1,(1673-300)/0.1,1,14.51;1673,0,1200,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Shenfu2008_0p1_1673_1200;
all_data.(names{index}).(names3{index2})=0.2042;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor Shenfu_2008
Shenfu2008_0p1_1673_1200=[300,0.1,(1673-300)/0.1,1,14.51;1673,0,1200,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Shenfu2008_0p1_1673_1200;
all_data.(names{index}).(names3{index2})=0.3060;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor Shenfu_2008
Shenfu2008_1000_1223_2=[300,1000,(1223-300)/1000,1,14.51;1223,0,1202,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Shenfu2008_1000_1223_2;
all_data.(names{index}).(names3{index2})=1.9013;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 6 for the precursor Shenfu_2008
Shenfu2008_1000_1273_2=[300,1000,(1273-300)/1000,1,14.51;1273,0,1202,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Shenfu2008_1000_1273_2;
all_data.(names{index}).(names3{index2})=0.5293;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Shenfu_2008
Shenfu2008_1000_1773_2=[300,1000,(1773-300)/1000,1,14.51;1773,0,1202,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Shenfu2008_1000_1773_2;



%% New Precursor
if sen_98R==1
%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='R_Senneca_1998';
all_data.(names{index}).prox_ult=[81.03,5.03,10.48,2.1,1.2,32.91]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor R_Senneca_1998
Senneca1998_R_16p7_1473_60=[300,16.7,(1473-300)/16.7,1,16.1;1473,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_16p7_1473_60;
all_data.(names{index}).(names3{index2})=4.32;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor R_Senneca_1998
Senneca1998_R_16p7_1473_60=[300,16.7,(1473-300)/16.7,1,16.1;1473,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_16p7_1473_60;
all_data.(names{index}).(names3{index2})=5.36;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor R_Senneca_1998
Senneca1998_R_16p7_1473_60=[300,16.7,(1473-300)/16.7,1,16.1;1473,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_16p7_1473_60;
all_data.(names{index}).(names3{index2})=5.50;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor R_Senneca_1998
Senneca1998_R_16p7_1473_1800=[300,16.7,(1473-300)/16.7,1,16.1;1473,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_16p7_1473_1800;
all_data.(names{index}).(names3{index2})=3.11;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor R_Senneca_1998
Senneca1998_R_16p7_1473_1800=[300,16.7,(1473-300)/16.7,1,16.1;1473,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_16p7_1473_1800;
all_data.(names{index}).(names3{index2})=3.82;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 6 for the precursor R_Senneca_1998
Senneca1998_R_16p7_1473_1800=[300,16.7,(1473-300)/16.7,1,16.1;1473,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_16p7_1473_1800;
all_data.(names{index}).(names3{index2})=4.01;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 7 for the precursor R_Senneca_1998
Senneca1998_R_16p7_1673_60=[300,16.7,(1673-300)/16.7,1,16.1;1673,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_16p7_1673_60;
all_data.(names{index}).(names3{index2})=4.32;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 8 for the precursor R_Senneca_1998
Senneca1998_R_16p7_1673_60=[300,16.7,(1673-300)/16.7,1,16.1;1673,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_16p7_1673_60;
all_data.(names{index}).(names3{index2})=5.36;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 9 for the precursor R_Senneca_1998
Senneca1998_R_16p7_1673_60=[300,16.7,(1673-300)/16.7,1,16.1;1673,0,60,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_16p7_1673_60;
all_data.(names{index}).(names3{index2})=5.50;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%R_Senneca_1998
Senneca1998_R_16p7_1673_1800=[300,16.7,(1673-300)/16.7,1,16.1;1673,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Senneca1998_R_16p7_1673_1800;
end

%% New Precursor
if sen_98L==1
%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='R_Senneca_1998_L';
all_data.(names{index}).prox_ult=[81.03,5.03,10.48,2.1,1.2,32.91]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor R_Senneca_1998_L
Senneca1998_R_5_1173_1800=[300,5,(1173-300)/5,1,16.1;1173,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_5_1173_1800;
all_data.(names{index}).(names3{index2})=5.73;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor R_Senneca_1998_L
Senneca1998_R_5_1173_1800=[300,5,(1173-300)/5,1,16.1;1173,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_5_1173_1800;
all_data.(names{index}).(names3{index2})=6.61;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor R_Senneca_1998_L
Senneca1998_R_5_1173_1800=[300,5,(1173-300)/5,1,16.1;1173,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_5_1173_1800;
all_data.(names{index}).(names3{index2})=7.05;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor R_Senneca_1998_L
Senneca1998_R_5_1473_1800=[300,5,(1473-300)/5,1,16.1;1473,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_5_1473_1800;
all_data.(names{index}).(names3{index2})=3.41;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor R_Senneca_1998_L
Senneca1998_R_5_1473_1800=[300,5,(1473-300)/5,1,16.1;1473,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_5_1473_1800;
all_data.(names{index}).(names3{index2})=3.92;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 6 for the precursor R_Senneca_1998_L
Senneca1998_R_5_1473_1800=[300,5,(1473-300)/5,1,16.1;1473,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Senneca1998_R_5_1473_1800;
all_data.(names{index}).(names3{index2})=4.55;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%R_Senneca_1998_L
Senneca1998_R_5_1673_1800=[300,5,(1673-300)/5,1,16.1;1673,0,1800,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Senneca1998_R_5_1673_1800;
end

%% New Precursor
%name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='South_African_Barziv2000';
all_data.(names{index}).prox_ult=[80.66,4.51,12.69,1.46,.73,27.4]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_15_1173_60=[300,15,(1173-300)/15,1,17.8947;1173,0,60,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_15_1173_60;
all_data.(names{index}).(names3{index2})=5.1739;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_15_1173_60=[300,15,(1173-300)/15,1,17.8947;1173,0,60,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_15_1173_60;
all_data.(names{index}).(names3{index2})=4.495;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_167_1473_1800=[300,167,(1473-300)/167,1,17.8947;1473,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_167_1473_1800;
all_data.(names{index}).(names3{index2})=2.307;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 4 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_167_1473_1800=[300,167,(1473-300)/167,1,17.8947;1473,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_167_1473_1800;
all_data.(names{index}).(names3{index2})=2.305;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 5 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_167_1473_1800=[300,167,(1473-300)/167,1,17.8947;1473,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_167_1473_1800;
all_data.(names{index}).(names3{index2})=2.093;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 6 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_167_1673_1800=[300,167,(1673-300)/167,1,17.8947;1673,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_167_1673_1800;
all_data.(names{index}).(names3{index2})=1.118523294;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 7 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_167_1673_1800=[300,167,(1673-300)/167,1,17.8947;1673,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_167_1673_1800;
all_data.(names{index}).(names3{index2})=0.9280648773;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 8 for the precursor South_African_Barziv2000 markme
Barziv2000_SA_167_1673_1800=[300,167,(1673-300)/167,1,17.8947;1673,0,1800,1,0];
all_data.(names{index}).(names2{index2})=Barziv2000_SA_167_1673_1800;
all_data.(names{index}).(names3{index2})=0.9534118286;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;


%reference data point, typically with the most severe heat treatment for the precursor
%South_African_Barziv2000
Barziv2000_SA_1p67e4_2273_2=[300,1.67e4,(2273-300)/1.67e4,1,17.8947;2273,0,2,1,0];
all_data.(names{index}).dataref=Barziv2000_SA_1p67e4_2273_2;

if Jay==1
%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_CO2_1';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1173_300=[300,0.667,(1173-300)/0.667,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1173_300;
all_data.(names{index}).(names3{index2})=0.8095;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1173_300=[300,1.667,(1173-300)/1.667,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1173_300;
all_data.(names{index}).(names3{index2})=0.9487;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1173_300=[300,8.33,(1173-300)/8.33,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1173_300;
all_data.(names{index}).(names3{index2})=1.1026;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1173_300=[300,13.3,(1173-300)/13.3,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1173_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_CO2_2';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1223_300=[300,0.667,(1223-300)/0.667,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1223_300;
all_data.(names{index}).(names3{index2})=0.8413;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1223_300=[300,1.667,(1223-300)/1.667,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1223_300;
all_data.(names{index}).(names3{index2})=0.8862;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1223_300=[300,8.33,(1223-300)/8.33,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1223_300;
all_data.(names{index}).(names3{index2})=0.8919;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1223_300=[300,13.3,(1223-300)/13.3,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1223_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_CO2_3';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1273_300=[300,13.3,(1273-300)/13.3,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1273_300;

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1273_300=[300,0.667,(1273-300)/0.667,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1273_300;
all_data.(names{index}).(names3{index2})=0.8250;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1273_300=[300,1.667,(1273-300)/1.667,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1273_300;
all_data.(names{index}).(names3{index2})=0.8809;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1273_300=[300,8.33,(1273-300)/8.33,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1273_300;
all_data.(names{index}).(names3{index2})=0.9694;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1273_300=[300,13.3,(1273-300)/13.3,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1273_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_steam_1';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1173_300=[300,0.667,(1173-300)/0.667,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1173_300;
all_data.(names{index}).(names3{index2})=0.9058;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1173_300=[300,1.667,(1173-300)/1.667,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1173_300;
all_data.(names{index}).(names3{index2})=0.9459;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1173_300=[300,8.33,(1173-300)/8.33,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1173_300;
all_data.(names{index}).(names3{index2})=0.9479;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1173_300=[300,13.3,(1173-300)/13.3,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1173_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_steam_2';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1223_300=[300,0.667,(1223-300)/0.667,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1223_300;
all_data.(names{index}).(names3{index2})=0.9504;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1223_300=[300,1.667,(1223-300)/1.667,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1223_300;
all_data.(names{index}).(names3{index2})=0.9752;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1223_300=[300,8.33,(1223-300)/8.33,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1223_300;
all_data.(names{index}).(names3{index2})=1.0055;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1223_300=[300,13.3,(1223-300)/13.3,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1223_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_steam_3';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1273_300=[300,0.667,(1273-300)/0.667,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1273_300;
all_data.(names{index}).(names3{index2})=0.9510;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1273_300=[300,1.667,(1273-300)/1.667,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1273_300;
all_data.(names{index}).(names3{index2})=1.0490;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1273_300=[300,8.33,(1273-300)/8.33,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1273_300;
all_data.(names{index}).(names3{index2})=1.0858;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1273_300=[300,13.3,(1273-300)/13.3,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1273_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_CO2_60_1';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1173_300=[300,0.667,(1173-300)/0.667,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1173_300;
all_data.(names{index}).(names3{index2})=1.4766;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1173_300=[300,1.667,(1173-300)/1.667,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1173_300;
all_data.(names{index}).(names3{index2})=1.1589;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1173_300=[300,8.33,(1173-300)/8.33,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1173_300;
all_data.(names{index}).(names3{index2})=1.0981;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1173_300=[300,13.3,(1173-300)/13.3,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1173_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_CO2_60_2';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1223_300=[300,0.667,(1223-300)/0.667,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1223_300;
all_data.(names{index}).(names3{index2})=0.9982;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1223_300=[300,1.667,(1223-300)/1.667,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1223_300;
all_data.(names{index}).(names3{index2})=1.0678;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1223_300=[300,8.33,(1223-300)/8.33,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1223_300;
all_data.(names{index}).(names3{index2})=1.0971;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1223_300=[300,13.3,(1223-300)/13.3,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1223_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_CO2_60_3';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1273_300=[300,0.667,(1273-300)/0.667,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1273_300;
all_data.(names{index}).(names3{index2})=1.0202;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1273_300=[300,1.667,(1273-300)/1.667,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1273_300;
all_data.(names{index}).(names3{index2})=1.0640;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1273_300=[300,8.33,(1273-300)/8.33,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1273_300;
all_data.(names{index}).(names3{index2})=0.9868;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1273_300=[300,13.3,(1273-300)/13.3,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1273_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_CO2_500_1';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1173_300=[300,0.667,(1173-300)/0.667,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1173_300;
all_data.(names{index}).(names3{index2})=0.8284;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1173_300=[300,1.667,(1173-300)/1.667,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1173_300;
all_data.(names{index}).(names3{index2})=0.7929;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1173_300=[300,8.33,(1173-300)/8.33,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1173_300;
all_data.(names{index}).(names3{index2})=0.7515;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1173_300=[300,13.3,(1173-300)/13.3,1,15.66;1173,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1173_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_CO2_500_2';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1223_300=[300,0.667,(1223-300)/0.667,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1223_300;
all_data.(names{index}).(names3{index2})=0.8978;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1223_300=[300,1.667,(1223-300)/1.667,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1223_300;
all_data.(names{index}).(names3{index2})=0.9665;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1223_300=[300,8.33,(1223-300)/8.33,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1223_300;
all_data.(names{index}).(names3{index2})=1.0486;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1223_300=[300,13.3,(1223-300)/13.3,1,15.66;1223,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1223_300;

%% New Precursor

%Name the precursor in the structure
index=index+1;
index2=1;%be sure to restart this at every precursor
all_data.(names{index}).name='Ind_Jayaraman_2015_CO2_500_3';
all_data.(names{index}).prox_ult=[72.82,4.65,19.91,1.79,0.83,50.03]; %C,H,O,N,S,astm volatiles daf

%data point 1 for the precursor Ind_Jayaraman_2015
Jayaraman2015_0p667_1273_300=[300,0.667,(1273-300)/0.667,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_0p667_1273_300;
all_data.(names{index}).(names3{index2})=0.7018;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 2 for the precursor Ind_Jayaraman_2015
Jayaraman2015_1p667_1273_300=[300,1.667,(1273-300)/1.667,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_1p667_1273_300;
all_data.(names{index}).(names3{index2})=0.9092;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%data point 3 for the precursor Ind_Jayaraman_2015
Jayaraman2015_8p33_1273_300=[300,8.33,(1273-300)/8.33,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).(names2{index2})=Jayaraman2015_8p33_1273_300;
all_data.(names{index}).(names3{index2})=1.0177;%the measured value of the reactivity of (names2{index2}) to dataref R1/Rref
index2=index2+1;

%reference data point, typically with the most severe heat treatment for the precursor
%Ind_Jayaraman_2015
Jayaraman2015_13p3_1273_300=[300,13.3,(1273-300)/13.3,1,15.66;1273,0,300,1,0];%[initial TP,HR_1,time_1,regime_1,C/H (not used anymore),TP soak,HR_soak,time_soak,regime_soak,place holder
all_data.(names{index}).dataref=Jayaraman2015_13p3_1273_300;
end

