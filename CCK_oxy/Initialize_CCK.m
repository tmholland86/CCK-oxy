%Start with the comments

% C  This code, entitled CCK, was developed in 2010-2011 at BYU and is intended to be as similar as possible to the CBK-G code described in
% C  Liu, G.-S. and S. Niksa, Progress in Energy and Combustion Science, 30(6), 679-717 (2004)
% C  and also the CBK-E code described in
% C  Niksa, S., G. S. Liu and R. H. Hurt, Progress in Energy and Combustion Science, 29(5), 425-477 (2003).
% C  The CBK-E code was the starting point for this BYU code.
% C  Further changes will most likely be made, but the published rank-dependent kinetic correlations and other parameters should be useful in this version.
% C  The original CBK6 code and the more recent CBK8 code are also useful references (nth-order models):
% C  Hurt, R., J.-K. Sun and M. Lunden, Combustion and Flame, 113(1-2), 181-197 (1998) (includes statistical kinetics)
% C  Sun, J.-K. and R. H. Hurt, Proceedings of the Combustion Institute, 28(2), 2205-2213 (2000) (includes transition to Zone I)
% C  Corrections to typographic errors in the published articles and the previous versions of the CBK code have been made,
% C  namely the evaluation of effectiveness factors, the random pore model surface area ratio, and the implementation of the log-normal distribution
% C  in the annealing model. Multicomponent diffusion was implemented using a pseudo-binary approach with mixture diffusivities as described in
% C  Fairbanks, D. F. and C. R. Wilke, Industrial & Engineering Chemistry, 42(3), 471-475 (1950).
% C  Most of the thermodynamic properties were updated using the correlations from
% C  McBride, B. J., M. Zehe and S. Gordon, "NASA Glenn Coefficients for Calculating Thermodynamic Properties of Individual Species," NASA TP-2002-215556 (2002).
% C  The blowing factor calculation was redone based on the definitions found in
% C  Bird, R. B., W. E. Stewart and E. N. Lightfoot, Transport Phenomena, New York, John Wiley & Sons (2002);
% C  the use of a mixture heat capacity and the total flux in the previous version is not valid for this multicomponent system with fluxes to and from the surface.


MOLFRAC=(max(POX)+max(PCO2)+max(PH2O)+max(PH2)+max(PCO))/P;
 if MOLFRAC>1.001 
         warning('Gas mole fraction may be greater than 1 in the script Initialize_CCK')
         beep
         POX=POX/P/MOLFRAC*P;
         PCO2=PCO2/P/MOLFRAC*P;
         PH2O=PH2O/P/MOLFRAC*P;
         PH2=PH2/P/MOLFRAC*P;
         PCO=PCO/P/MOLFRAC*P;
         MOLFRAC=(max(POX)+max(PCO2)+max(PH2O)+max(PH2)+max(PCO))/P;
 end

% % % %More initialization
% % % 
IFLAGGER=0;
RHOA=RHOATRU*(1-TPORFILM);

Q(:,1)=0.0;
TP(:,1)=TPINIT;
MCMCO(:,1)=1.0;
DP(:,1)=DPO(1,1);
MMO(:,1)=1.0;
RHOCO=0.0;
%%%%%%%%%%%%%
RHO(:,1)=RHOCO;
PNETO2(:,1)=0.0;
PNETH2O(:,1)=0.0;
PNETCO2(:,1)=0.0;
PNETH2(:,1)=0.0;
PNETCO(:,1)=0.0;
PNETCH4(:,1)=0.0;
CONSO2(:,1)=0.0;
CONSH2O(:,1)=0.0;
PRODCO2(:,1)=0.0;
PRODH2(:,1)=0.0;
PRODCO(:,1)=0.0;
PRODCH4(:,1)=0.0;

GLMCMCO(:,1)=0.0;


