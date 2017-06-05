%This script calls the various subroutines/functions of the CCK code.

%Initialize the number of diameter bins (and initialize any uninitialized
%parameters at 0)
BOT=0;
IFLAGERR=0;
OUTFILE='OUTFILECCK.txt';
 for K=1:NDPO
 DPCOAL(K,1)=DPO(K,1);
 DPCOAL=DPO;
 %initialize location for each particle
 HEIGHT=in_mat_2(15);
 time_initial=in_mat_2(17);
 
[  TG,POX,TENV,P,E3,E2,E1,AC,EC,ZN,DPCOAL(K),...
        OMEGA,ALPHA,CHARXAO,RHOCO,Q,TP,MMO,MCMCO,DP,DCARB,...
        DELT,BOT,TPORFILM,DELMONO,IFLAGERR,XK3OI,...
        XK2OBYK3O,XK3OBYK1O,TAUBYF,ITRAJ,XLAMBASH,TPINIT,XK7OI,...
        XK4OBYK7O,XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
        E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,PCO2,PH2O,PH2,PCO,...
        CONSO2,CONSH2O,PRODCO2,PRODCO,PRODH2,PRODCH4,OUTFILE,PSI,time,height ] =...
  CBKBURN( POX,TENV,P,E3,E2,E1,AC,EC,ZN,DPCOAL(K),...
        OMEGA,ALPHA,CHARXAO,RHOCO,...
        DELT,BOT,TPORFILM,DELMONO,IFLAGERR,XK3OI,...
        XK2OBYK3O,XK3OBYK1O,TAUBYF,ITRAJ,XLAMBASH,TPINIT,XK7OI,...
        XK4OBYK7O,XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,...
        E7,E4mE7,E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7,PCO2,PH2O,PH2,PCO,...
        CONSO2,CONSH2O,PRODCO2,PRODCO,PRODH2,PRODCH4,OUTFILE,PSI,HEIGHT,...
        VC1,VC2,VC3,VC4,VC5,VC6,VC7,TC1,TC2,TC3,TC4,TC5,TC6,TC7,time_elapsed...
        ,dtl, time_initial,cci,Tpeak,HR,p0,ZONE1FAC,NED_CPD);
    
    PARTBO(K,1)=100*(1-MCMCO(end));
%These values should be unneccessary now that the time step is variable    
%     TCHECK(K,1)=DELT*(INTSTEP-1);
%     
%     if (BOT>0)&&(BOT<TCHECK(K,1));
%         MMO(INTSTEP)=XAO;
%         DP(INTSTEP)=DPO(K)*((XAO*COALRHO/RHOA)^(1/3));
%         MCMCO(INTSTEP)=0;
%     end
    
   %C  *** Update running computation of global properties ****
 
    GLMCMCO=GLMCMCO+MODPO(K)*MCMCO;
    PNETO2=PNETO2+MODPO(K)*(-CONSO2);
    PNETH2O=PNETH2O+MODPO(K)*(-CONSH2O);
    PNETCO2=PNETCO2+MODPO(K)*(PRODCO2);
    PNETH2=PNETH2+MODPO(K)*(PRODH2);
    PNETCO=PNETCO+MODPO(K)*(PRODCO);
    PNETCH4= PNETCH4+MODPO(K)*(PRODCH4);    
  
 end


