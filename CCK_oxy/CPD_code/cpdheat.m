

% % % C  THIS IS THE CPD-NLG MODEL
% % % C
% % % C  THIS MODEL WAS DEVELOPED BY SANDIA NATIONAL LABORATORIES UNDER 
% % % C  FWP 0709 FOR THE DEPARTMENT OF ENERGY'S PITTSBURGH ENERGY
% % % C  TECHNOLOGY CENTER AND THE DOE DIVISION OF ENGINEERING AND GEOSCIENCES
% % % C  THROUGH THE OFFICE OF BASIC ENERGY SCIENCES;
% % % C  AND BY THE UNIVERSITY OF UTAH THROUGH FUNDING FROM 
% % % C  THE ADVANCED COMBUSTION ENGINEERING RESEARCH CENTER (ACERC), WHICH 
% % % C  IS PRINCIPALLY SPONSORED BY THE NATIONAL SCIENCE FOUNDATION, THE
% % % C  STATE OF UTAH, AND BY A CONSORTIUM OF INDUSTRIAL COMPANIES.
% % % C  THE CODE WILL NOT BE FORMALLY LICENSED.  NEITHER THE U.S. OR THE 
% % % C  DOE, NOR ANY OF THEIR EMPLOYEES, MAKES ANY WARRANTY, EXPRESS OR IMPLIED, 
% % % C  OR ASSUMES ANY LEGAL LIABILITY OR RESPONSIBILITY FOR THE ACCURACY, 
% % % C  COMPLETENESS, OR USEFULNESS OF ANY INFORMATION, APPARATUS, PRODUCT, OR 
% % % C  PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD INFRINGE PRIVATELY 
% % % C  OWNED RIGHTS.
% % % c
% % % c  The CPD model is intended to solve pyrolysis rate equations
% % % c  based on a percolative bond-breaking scheme.  This version includes the 
% % % c  flash distillation program to distinguish between tar and metaplast.
% % % c  This program also includes a crosslinking scheme.  (January, 1991)
% % % c
% % % c
% % % c  Most recent modifications to this model include a (a) nitrogen release model
% % % c  and (b) a model to break the light gas into species based on a correlation.
% % % c  These modifications were made by Dominic Genetti in his M.S. Thesis work at
% % % c  BYU (1999).
% % % c
% % % c  This is the black liquor version of the cpd model that was made for a
% % % c  constant heating rate.  The self-adjusting time step was modified 
% % % c  (about January, 2004).  
% % % c

function [HTVL_rec,ftar_rec,fgas_rec,time_rec,Tp_rec]=cpdheat(Input_matrix)
format long
%code in the inputs
nmax=10;
nt=1;
intar=false;
idiff=false;
ftar0=0;
fgas0=0;
fchar0=1;
ip=30;
zero=0;
ftar=0;
fchar=0;
fmet=0;
fvol=0;
fvolold=0;
lib=0;
%these next arrays are possibly in need of modification for enhanced
%flexibility
y=zeros(4,1);
yp=zeros(4,1);
ypp=zeros(4,1);
ypred=zeros(4,1);
tim=zeros(50,1);
tem=zeros(50,1);
ft=zeros(35,1);
mt=zeros(35,1);
u0=0;
kkk=1;
umax=0;
yield=0;

g0=0;
g1=0;
g2=0;
% % % % %
% % % % %read in the situation specific inputs
% % % % %
 p0=Input_matrix(1);%		!p0		
 c0=Input_matrix(2);%		!c0
 sigp1=Input_matrix(3);%		!sig+1
 mw1=Input_matrix(4);%		!mw
 mdel=Input_matrix(5);%		!mdel (7 will be subtracted internally to the CPD model)
 fnit=Input_matrix(13);%         !fnit (daf mass fraction of nitrogen in unreacted coal)
 fst=Input_matrix(14);%		!fst  (fraction of nitrogen remaining in the char)
 fhyd=Input_matrix(15);%		!fhyd (daf mass fraction of hydrogen in unreacted coal)
 fcar=Input_matrix(16);%		!fcar (daf mass fraction of carbon in unreacted coal)
 foxy=Input_matrix(17);%		!foxy (daf mass fraction of oxygen in unreacted coal)
 
 
 
 ab=2.6e15;%	!ab
 eb0=55400;%		!eb
 ebsig=1800;% 		!ebsig
 ac=0.9;%		!ac=rho
 ec0=0;%		!ec
 ag=3.e15;%		!ag
 eg0=60000;%		!eg
 egsig=8100;%     	!egsig
 acr=3.e15;%		!Acr (pre-exponential factor for crosslinking rate)
 ecr=65000;%		!Ecr (Activation energy for crosslinking rate)
 an=9e17;%		!an (Pre-exponential factor for HCN release)
 en0=100000;%		!en (Activation energy for HCN release)
 ensig=17000;%		!ensig (deviation bound for dist en for HCN release)
 
 press=Input_matrix(12);%		!pressure (atm)
%
%calculate mdel and other structure coefficiencets, values that should not be changed
%
mdel=mdel-7;
l0=p0-c0;
mb=2*mdel;
ma=mw1-sigp1*mdel;
beta = ma;
sig = sigp1-1;
finf = 1/(2*ma/(mb*sigp1*(1-c0))+1);
rba = mb/ma;

fnca0 = fnit*mw1/(mw1-sigp1*mdel);
    %c   calculate O/C and H/C ratios for light gas model
      xoc = (foxy/16)/(fcar/12);
      yhc = fhyd/(fcar/12);
    %c test to see if p0 is above percolation threshhold
      pthresh = 1/sig;
      if p0<=pthresh
          error('Error: value of p0 is below the percolation threshold')
      end
tim(1)=0;
%
%resume situation specific parameters
%
tem(1)=300;%		!initial temperature (K)
ntim=2;%		!number of time points; this needs to be an integer
 %
 %calculate the number of time spoints
 %
 ntim=ntim+1;
 %
 %resume situation specific parameters
 %
  
%The number of values below depend on the number of time points.
%They should begin at 2, and one value should be put in for each time point
%beyond 2. If the points become numerous and repetetive, this section can
%be recoded as a for loop.
     heat(2)=Input_matrix(6);%heating rate
     tem(2)=Input_matrix(7);%temperature
     tim(2)=Input_matrix(8);

     %
     %check the value of heat, and recalculate tim
     %
     if heat(2)~=0
         tim(2)=(tem(2)-tem(2-1))/heat(2)+tim(2-1);
     end
     %
     %resume situation specific inputs
     %
     
     heat(3)=Input_matrix(9);
     tem(3)=Input_matrix(10);
     tim(3)=Input_matrix(11);

     %
     %check the value of heat, and recalculate tim
     %
     if heat(3)~=0
         tim(3)=(tem(3)-tem(3-1))/heat(3)+tim(3-1);
     end
     %initialize the nt+1 value beyond the final input heat value
     heat=heat';
     heat=[heat;0];
     %
     %resume situation specific inputs
     %
 dt0=5e-4;%!dt (s)
 %
 %input the print increment
 %
 iprint=1;
 %
 %resume situation specific parameters
 %
 dtmax=1;
 timax=600;%		!timax (maximum residence time [s] for calculations)
 nmax=20;%		!nmax (maximum number of mers for tar molecular wt)
 %
 %input a logic value
 %
 inside=true;		%!true for Light Gas Calculation, otherwise false
% % % % %
% % % % %end of situation specific parameters
% % % % %

%initialize the data blocks
    ftold=zeros(35,1);
    metold=zeros(35,1);
    x3=.2;
    x2=.3;
    xmat=zeros(36,1);
    ymat=zeros(36,1);
    k=zeros(36,1);
    lmat=zeros(36,1);
    v=zeros(36,1);
    xmw=zeros(36,1);
    tarold=zeros(35,1);
    f=zeros(36,1);
    z=zeros(36,1);
    pv=zeros(36,1);
    fgas0=0;
    ip=30;
    ftart=0;
    fx=0;
    l=0;
    kc=0;
    kb=0;
    kg=0;
    kn=0;
    kp=0;
    ft=zeros(35,1);
    mt=zeros(35,1);
    mtot=0;
    sumu=zeros(200,1);
    VoL=0;
    Ltot=0;
    Vtot=0;
    xmwtot=0;
    mgas=0;
    fgas=0;
    fchar=0;
    fgas0old=0;
    
    




% initialize some more variables


breakcounter=0;
dtold=dt0;
itest=0;
sumy=0;
yygas=zeros(5,1);
y(1) = l0;
y(2) = 2.*(1.-c0-l0);
y(3) = c0;
y(4) = fnca0;
fnca=y(4);
aind0 = l0 + (1.-c0-l0);
siginv = 1./sig;
pstar = 0.5*siginv;
ynhcn = 0.0;
yntar = 0.0;
yytar = 0.0;
yf = 0.0;
yyyy=false;

%start the calculation loop
Rg=1.987;%(cal/mol)
iii=0;%initialize the count
fgas0 = 0;
fcross = 0.0;
fntar = 0.0;
fntd = 0.0;
fnt = 0.0;
cmw1 = 0.0;
smw1 = 0.0;
time=0;

if heat(2)~=0
    dt0=tim(2)/1000;
end
    dt=min(dt0,dtmax);
    ntmax=100*(timax/dt+1);
    for iii=1:ntmax
        time=time+dt;
        
% CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
% C
% C PREDICTOR
% C
% CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
  time_rec(iii,1)=time; 

        while 0==0 %this formulation is to translate the "go to" command in fortran
        if time<=tim(nt+1)

              Tp=tem(nt)+(time-tim(nt))*(tem(nt+1)-tem(nt))/(tim(nt+1)-tim(nt));
        break
        elseif nt<ntim
              nt=nt+1;
              if heat(nt+1)~=0
                  dt=(tem(nt+1)-tem(nt))/heat(nt+1)/10;
              end
              
        else

            print1='reached end of gas temperature correlation';
            if inside==false&&yyyy==true
                print1='warning';
                print1='O/C and H/C ratios are outside the bounds of the library coals';
                print1='estimation of light gas distribution is based on library coal';
                lib;
            end
                breakcounter=1;
                break
        end
        end
        if breakcounter==1
            break
        end
    if Tp>4000
        print1='warning, gas temp is too high'
        Tp
    end
    %C--    DEVOLATILIZATION RATES 

    Tp_rec(iii,1)=Tp;
    while 0==0%this formulation allows a more direct translation from a 'goto'
        %statement in the fortran version

    
        [ypp,Tp,l0,l,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
                 ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
                 fst,fnca0,fnca,an,en0,ensig,fx,kg,kn,kp,ft,mt,kb]...
             =perks(y,Tp,l0,l,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
                 ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
                 fst,fnca0,fnca,an,en0,ensig,fx,kg,kn,kp,ft,mt,kb,iii);%call
             
             
        for j=1:4
            ypred(j)=y(j)+dt*ypp(j);
            ypred(j)=max(ypred(j),zero);
        end
        [yp,Tp,l0,l,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
                 ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
                 fst,fnca0,fnca,an,en0,ensig,fx,kg,kn,kp,ft,mt,kb]...
             =perks(ypred,Tp,l0,l,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
                 ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
                 fst,fnca0,fnca,an,en0,ensig,fx,kg,kn,kp,ft,mt,kb,iii);%call
          
        dtold=dt;
        dymax=0;
        dymin=1;
        for j=1:4

            if y(j)>5e-3
                dy1=abs(dt*0.5*(yp(j)+ypp(j)));
                dymax=max(dymax,dy1);
            end
        end

        dm=fvol-fvolold;
        bigdm=max(dymax,dm);
        if bigdm<.0001
            itest=1;
            dt=dt*1.2;

        elseif bigdm>.0005
            itest=2;
            dt=dtold/2;
            dy1;
        end
        dt=min(dt,dtmax);
     if dtold==dt | itest>=1
         break
     end
    end
    fvolold=fvol;
    dtn=dt;
    
    for j=1:4
           y(j) = y(j) + dt*0.5*(yp(j)+ypp(j));
           y(j) = max(zero,y(j));
    end
    fracr=1;

    if (fmet>1e-5)&&(acr>0)
           ratecr = acr*exp(-ecr/Rg/Tp)*fmet*dt;
           fracr = 1.-ratecr/fmet;
           fmet = fmet-ratecr;
           fcross = fcross+ratecr;
           if fmet<0
             fcross = fcross-ratecr+fmet+ratecr;
             fmet = 0.0;
             fracr = 0;
           end
    end
    %c print data
    if y(1)>1e-5
        intar=true;
    end

    [mgas,ftar,ftart,fgas,fchar,ft,mt,intar,l0,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
      ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
      u0,beta,kkk,umax,yield,press,l,mb,kb,kc,kg,kp,mtot,sumu]...
      =perkp(y,mgas,ftar,ftart,fgas,fchar,intar,l0,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
      ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
      u0,beta,kkk,umax,yield,press,l,mb,kb,kc,kg,kp,ft,mt,mtot,sumu,iii);%call

  fgas_rec(iii,1)=fgas;
  ftar_rec(iii,1)=ftar;
  HTVL_rec(iii,1)=ftar+fgas;
  
    intar=false;
    tms=time*1e3;

    if idiff==true
          fdift = ftar-ftar0;
          ftar0 = ftar;
          fdifg = fgas-fgas0;
          fdifc = -(fchar-fchar0);
          fchar0 = fchar;
    else
        gasmw=rba*ma/2;
        if fgas>=1e-5
            fgasd=fgas-fgas0;
            fgas0=fgas;
            imolw=false;
            if mod(iii,iprint)==0
                imolw=true;
            end

            [fgas,gasmw,ft,mt,fracr,ftar,fmet,...
                      Tp,press,nmax,imolw,sumy,tms,time,ftold,metold,x3,x2,...
                      xmat,ymat,k,lmat,v,xmw,tarold,f,z,pv,fgas0old,ip,VoL,Ltot,...
                      Vtot,xmwtot...
                      ]=flash(fgas,gasmw,ft,mt,fracr,ftar,fmet,...
                      Tp,press,nmax,imolw,sumy,tms,time,...
                       ftold,metold,x3,x2,xmat,ymat,k,lmat,v,xmw,tarold,f,z,...
                       pv,fgas0old,ip,VoL,Ltot,Vtot,xmwtot,iii);

           
        elseif fgas<1e-5
            fmet=ftart;
            ftar=0;
        end
        intar=false;
        fvol=fgas+ftar;
        fchar=1-fvol;
        if fvol>.995
            return
        end
%               if(iii.eq.1)then
%       write(6,201)
%       write(2,202)
% 201   format(' time(ms)      temp     fcross     labile    ftar    ',
%      x'fgas   fsolid     ftot    fmet')
% 202   format('c time(ms)      temp     fcross     labile   ftar    ',
%      x'fgas   fsolid   ftot   fmet')
%       endif
    end            

      
      l = y(1);
      del = y(2);
      c = y(3);
      fnca = y(4);
      p = l+c;
      tarfac = 1;
      g1 = (2.*(1-p)-del);
      g2 = 2.*(c-c0);
      g = g1+g2;
      del2 = del/2;
      aind = del2 + l;
      g12 = g1/2;
      g22 = g2/2;
      gtot = g/2;
           
%   c
% c     
% C  NITROGEN RELEASE CALCULATIONS
% 
% c  new average molecular weight
       cmw1 = ma + (c0 + l + del2)*sigp1*mdel;
% c  nitrogen content of char and tar 
       fnt = y(4)*ma/cmw1;
% c  differential mass of nitrogen released with tar
       yntd = fnt*sumy;
% c  total nitrogen released with tar
       yntar = yntar + yntd;
% c  nitrogen remaining in char
       ynchar = fchar*fnt;
% c  differential mass of nitrogen released as light gas     
       ynhcnd = fchar*dt*(-0.5)*(yp(4)+ypp(4))*ma/cmw1;
% c  total mass of nitrogen released as light gas 
       ynhcn = ynhcn + ynhcnd;
% c  mass of nitrogen released with tar by difference
       yntar = fnit - ynhcn - ynchar;
% c  fraction of original nitrogen remaining in char
       fnchar = ynchar/fnit;
% c  fraction of original nitrogen released as tar
       fntar = yntar/fnit;
% c  fraction of original nitrogen released as light gas
       fnhcn = ynhcn/fnit;
% c  total fractional release of nitrogen
       fntot = (fnit - fnt*fchar)/fnit;
% 
%     
% c  DISTRIBUTE LIGHT GAS INTO H20, CO2, CO, CH4, & other HC's
% 
% c  yf is a CPD indicator of the fraction of total light gas
% c   that has been released. The look up table on light gas 
% c   composition is based on yf. 
    
    if inside==true
        yf=1-aind/aind0;
    
    
    [yygas,inside,lib,yyyy,yf,xoc,yhc]=...
                     lightgas(yygas,inside,lib,yyyy,yf,xoc,yhc,iii);%call

    % c  calculate fraction of total mass release that is h2o, co2, ch4,
    % c   co, and other light gases
    
    for ik=1:5
        ffgas(ik)=fgas*yygas(ik);
    end
    
    end
    
% c  PRINT RESULTS IN OUTPUT FILES
% c

%       if(mod(iii-1,iprint).eq.0)then
%         write(20,220)tms,l,c,del2,g12,g22,gtot,p
%         write(21,221)tms,tp,cmw1,y(4),fnt,fnchar,fntar,fnhcn,fntot
%         if(inside)
%      x    write(22,222)tms,fgas,ffgas(1),ffgas(2),ffgas(3),ffgas(4),
%      x                ffgas(5),yygas(1),yygas(2),yygas(3),yygas(4),
%      x                yygas(5),yf
%       endif
% 220   format(' ',1pe10.3,2x,7(0pf7.5,2x),0pf12.9,0pf9.7,0pf10.5,0pf12.9)
% 221   format(' ',2(1pe10.3),0pf8.2,6(0pf10.6))
% 222   format(' ',1pe10.3,0pf9.4,11(0pf9.4))
    end
    intar=false;
    fvol=fgas+ftar;
    fchar=1-fvol;
    if fvol>.995
        return
    end

end
