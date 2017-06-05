function [fgas,gasmw,ft,mt,fracr,ftar,fmet,...
                      Tp,press,nmax,imolw,sumy,tms,time,ftold,metold,x3,x2,...
                      xmat,ymat,k,lmat,v,xmw,tarold,f,z,pv,fgas0old,ip,VoL,Ltot,...
                      Vtot,xmwtot...
                      ]=flash(fgas,gasmw,ft,mt,fracr,ftar,fmet,...
                      Tp,press,nmax,imolw,sumy,tms,time,...
                       ftold,metold,x3,x2,xmat,ymat,k,lmat,v,xmw,tarold,f,z,...
                       pv,fgas0old,ip,VoL,Ltot,Vtot,xmwtot,iii)
                   
    %c  flash distillation of metaplast to form liquid and tar vapor
     
    %It uses fgas,gasmw,ft,mt,fracr,ftar,temp,press,nmax, and imolw as
    %inputs, and modifies ftar, fmet, and sumy as outputs. It also has 
    
    % c
    % c  metold(i) = mass fraction of coal contained in metaplast of mer size i
    % c  fracr = fraction to account for reduction of metaplast by crosslinking
    % c          in latest time step
    % c  
    % c  renormalize in tar fragment data to molar basis
    % c  f(i) = moles of mer i
    % c  ft(i) = mass of mer i
    % c  

      
    %initialize variables
    small=1e-3;
    a=87058;
    b=299;
    g=.5903;
    zero=0;
    fgas0=fgas0old;

    Ftot=0;
    for i=1:nmax
        i1=i+1;
        xmw(i1)=mt(i);
        dif = ft(i)-ftold(i);
        dif = max(dif,zero);
        f(i1) = (dif+metold(i)*fracr)/mt(i);
        ftold(i) = ft(i);
        Ftot = Ftot + f(i1);
        if f(i1)>1
            i1
            f(i1)
            ft(i)
            ftold(i)
            metold(i)
        end
    end

      ntot = nmax + 1;
      f(1) = (fgas-fgas0)/gasmw;
      f(1) = max(f(1),0);
      fgas0 = max(fgas,fgas0);
      xmw(1) = gasmw;
      Ftot = Ftot + f(1);
    % c  get mole fraction of components in the feed stream
    % c  and compute equilibrium contants k(i) from vapor pressure and
    % c  Raoults law expression

    sum=0;
    for ii=1:ntot
        sum=sum+f(ii);
        pv(ii)=a*exp(-b*xmw(ii)^g/Tp);
        k(ii) = pv(ii)/press;
        if k(ii)<.001
            k(ii)=0;
        end
    end
    if sum<=1e-8
        return
    end
    for ii=1:ntot
        z(ii)=f(ii)/(sum);
    end

    % c  use the Rachford-Rice formulation for flash distillation
    % c  x = V/F, first guess
    x1=x3;
    %c  calculate sum (Eq. 11-24, Separation Processes, by King, 1971)
    f1=0;
    for ii=1:ntot
        f1 = f1 + z(ii)*(k(ii)-1)/((k(ii)-1)*x1+1);
    end

    %c  Secant Method for convergence
    test=x2-x1;
    if test<.005
        x2=x1+.005;
    end
    for iter=1:101
        %c  calculate sum (Eq. 11-24, Separation Processes, by King, 1971)
        f2=0;
        for ii=1:ntot
            f2=f2 + z(ii)*(k(ii)-1)/((k(ii)-1)*x2+1);
        end

        if abs(f2)<=small | abs(f2-f1)<=small^2
            break
        end
        x3 = x2-f2*(x2-x1)/(f2-f1);
 
        if x3>1
            x3=1-small^2;
        end
        if x3<0
            x3=small^2;
        end
        if x3==x2
            print1='problem--f(V/F) not converged, but x3=x2'
            x3
            x2
            if x2>=small
                x3=x2-small;
            else
                x3=x2+small;
            end
        end
       if (x2<=1e-5&&x1<=1e-5)
            x2=1e-7;
            break
        end
        if (x2>=.9999&&x1>=.9999)
            x2=.9999;
            break
        end
        f1=f2;
        x1=x2;
        %c  under-relax solution (especially near the V/F=1 limit
        x2 = 0.2*x2+0.8*x3;

        if iter==101
            
            Print1='convergence not achieved in Flash distillation'
            Print1='last two guesses for V/F were:'
            x1
            x3
            error('convergence not achieved in Flash distillation')
        end
            
    end
    % c  now calculate molecular weight distributions on a
    % c  light-gas free basis, wt fractions   
    Vtot = Ftot*x2;
    Ltot = Ftot-Vtot;
    VoL = Vtot/Ltot;
    sumx = 0.0;
    sumy = 0.0;
    xmwtot = 0.0;
    ttot = 0.0;
    for ii=2:ntot
          i = ii-1;
          lmat(ii) = f(ii)/(1+k(ii)*VoL);
          v(ii) = f(ii)-lmat(ii);
          xmat(ii) = lmat(ii)*xmw(ii);
          ymat(ii) = v(ii)*xmw(ii);
          metold(i) = max(xmat(ii),zero);
          tarold(i) = tarold(i)+ymat(ii);
          xmwtot = xmwtot+tarold(i)*xmw(ii);
          ttot = ttot+tarold(i);
          sumx = sumx + xmat(ii);
          sumy = sumy + ymat(ii);
    end

    if ttot>0
        xmwtot=xmwtot/ttot;
    end

    for ii=2:ntot
        if sumx>1e-28
            xmat(ii)=xmat(ii)/sumx;
        end
        if sumy>1e-28
            ymat(ii)=ymat(ii)/sumy;
        end
    end
    ftar=ftar+sumy;
    fmet=sumx;


    if imolw==true
        ip=ip+1;
    end
fgas0old=fgas0;

    end
