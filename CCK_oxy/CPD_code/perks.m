function [yp,Tp,l0,l,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
                 ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
                 fst,fnca0,fnca,an,en0,ensig,fx,kg,kn,kp,ft,mt,kb]...
             =perks(y,Tp,l0,l,c0,g0,ma,rba,finf,sig,siginv,nmax,pstar,...
                 ab,eb0,ebsig,ac,ec0,ag,eg0,egsig,Rg,...
                 fst,fnca0,fnca,an,en0,ensig,fx,kg,kn,kp,ft,mt,kb,iii)
    % perks is the meat of the devolatilization model. It calculates key rates
    % including: destruction of labile bridges, formation of end/danglers,
    % formation of char
    
    %this is a nested function that uses y, c0, fx, eg0, egsig, fnca0, fst,
    %en0, ensig, l0, eb0, ebsig, ec0, ab, ac, ag, an, and yp as defined in
    %the parent function. y is an input from the call in the main
    %function, nad yp is the desired output
       
      
    %ecsig, fnca, and kn have been exluded as having no apparent function
    %outside this function

      l = y(1);
      del = y(2);
      c = y(3);
      fnca = y(4);
      p = l+c;
      g1 = 2.*(1-p)-del;
      g2 = 2.*(c-c0);
      g = g1+g2;
      %c  calculate current activation energy using error function solution
      if c0<1
          fx = g/(1-c0)/2;
      end
      x=inverf(fx,iii);%call
      eg = eg0 + x*egsig;
      
      if fnca0>0
          fx = 1.-(fnca-fst*fnca0)/(fst*fnca0);
      end
      x=inverf(fx,iii);%call
      en = en0 + x*ensig;
      
      if l0>0
          fx = 1.-l/l0;
      end
      x=inverf(fx,iii);%call
      
      
      eb = eb0+x*ebsig;
      ec = ec0;
%c  calculate rate constants
      rt = Rg*Tp;
      kb = ab*exp(-eb/rt);
      rho = ac*exp(-ec/rt);
      kg = ag*exp(-eg/rt);
      kn = an*exp(-en/rt);
%c  calculate rate of destruction of labile bridges
      yp(1) = -kb*l;
%c  calculate rate of formation of ends (danglers)
      yp(2) = 2.*rho*kb*l/(rho+1.) - kg*del;
%c  calculate rate of formation of char
      yp(3) = kb*l/(rho+1);
%c  calculate rate of nitrogen loss (as HCN)
      yp(4) = -kn*max((fnca-fst*fnca0),0);
    end