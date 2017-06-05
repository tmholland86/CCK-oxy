function [mgas,ftar,ftart,fgas,fchar,ft,mt,intar,l0,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
      ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
      u0,beta,kkk,umax,yield,press,l,mb,kb,kc,kg,kp,mtot,sumu]=...
      perkp(y,mgas,ftar,ftart,fgas,fchar,intar,l0,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
      ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
      u0,beta,kkk,umax,yield,press,l,mb,kb,kc,kg,kp,ft,mt,mtot,sumu,iii)
  
    % perkp calculates fractions of tar, gas, and char from p, sig, l, and c.
    % It is the heart of the percolation code. 
    
    %It uses y,ftar, and intar as inputs, and modifies mgas, ftart,fgas,
    %fchar,ft, and mt as outputs. It also has rba, sig, pstar, siginv,c0, 
    %ftar, ma, fchar, intar, ipring, nmax, ft, and nt from the parent
    %directory

      
    l = y(1);
    del = y(2);
    c = y(3);
    p = l+c;
      if intar==true
        if p>0.9999
         delfac = 1;
        else
         delfac = del/(1-p);
        end
       a = 1+rba*(l/p + (sig-1)/4*delfac);
       b = (delfac/2-l/p);
       pstar0 = pstar;
       pinv = siginv+1e-4;
        if p>=.9999
            pstar=0;
        elseif p>=pinv
              err=1;
            for i=1:25
              f = pstar*(1-pstar)^(sig-1) - p*(1-p)^(sig-1);
              fp = (1-pstar)^(sig-1)-pstar*(sig-1)*(1-pstar)^(sig-2);
              ppstar = pstar - f/fp;
              err= abs(1-ppstar/pstar);
              if err<=1e-4
                  break
              end
              pstar=ppstar;
              
              if err>1e-4&&i==25
                  print1='warning--pstar did not converge'
                  p
                  sig
                  pstar
                  pstar0
              end
            end

        else
            pstar=p;
        end
            sfac=(sig+1)/(sig-1);
            fp=(pstar/p)^sfac;
            kp=(pstar/p)^sfac*(1-(sig+1)/2*pstar);
            %c  calculate wt fraction tar, gas, and char
            ftart = 2.*(a*fp+rba*b*kp)/(2.+rba*(1.-c0)*(sig+1.));
       %c  check to see if pstar is in the right range
        if pstar<0 | (p~=pstar&&pstar>=siginv)
          error('error--pstar out of acceptable ranges?')
        end      
        sfac = (sig+1)/(sig-1);
        fp = (pstar/p)^sfac;
        kp = (pstar/p)^sfac*(1-(sig+1)/2*pstar);
        %c  calculate wt fraction tar, gas, and char
        ftart = 2*(a*fp+rba*b*kp)/(2+rba*(1-c0)*(sig+1));        
      end
      tarfac = 1-ftar;
      g1 = (2*(1.0 - p) - del);
      g2 = 2*(c-c0);
      g = g1+g2; 
              
      mgas = rba*ma*g*(sig+1)/4*tarfac;
      mtot = ma + rba*ma*(sig+1)/2*(1-c0);
%       iii
%       g1
%       g2      
%       tarfac
%       if mod(iii,200)==0
%       pause
%       end
      fgas = mgas/mtot;
      fchar = 1-ftar-fgas;
      if intar==false
          return
      end
%      iprint=iprint+1;%this apears to do nothing in the CPD code
      ftsum=0;
      for n=1:nmax
         tn = n*(sig-1)+2;
         xm = n*sig+1;
         yk = n-1;
         xm1 = xm+1;
         %gamma is the gamma function
         fg1 = log(gamma(xm1));
         if fg1<=1e-10
            fgam = 0;
         else
           yk1 = yk+1;
           fg2 = log(gamma(yk1));
           xmyk = xm-yk+1;
           fg3 = log(gamma(xmyk));
           fgam = exp(fg1-fg2-fg3);
         end
         bnn = (sig+1)/(n*sig+1)*fgam;
         qn = bnn*(p^(n-1))*((1-p)^tn)/n;
         %c  ft(n) = weight fraction of each tar bin
         ft(n) = 2*(n*a*qn+rba*b*qn)/(2+rba*(1-c0)*(sig+1));
         ftsum = ftsum + ft(n);
         %c  check to not divide by zero
         if p<=1e-9
            fac = 0;
         else
            fac = l/p;
         end
         tst = 1-p;
         if tst<=1e-9
            fac1 = 0;
         else
            fac1 = del/(1-p);
         end
         %c  mt(n) = molecular weight of each tar bin
         mt(n) = n*ma+(n-1)*rba*ma*fac+tn*rba*ma/4*fac1;
              
      end

    end