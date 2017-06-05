 function x=inverf(y,iii)
    % c  this program calculates the inverse of the area under the normal curve.
    % c  if y=area(x), then given y, this program will calculate x.
    % c  A table lookup is performed.
    
    % y is the input from the call, and x is the output, while yp2 is a
    % strictly local value used in some calculations. It is used instead of
    % yp to avoid passing new values for yp back to the parent function
    
    %this is a nested function called by perks. It uses no global inputs
    %from the parent function.

    xx=[3.4,3.2,3.,2.8,2.6,2.4,2.2,2.,1.8,1.6,1.4,...
            1.2,1.,.8,.6,.4,.2,0.]';
    yy=[.9997,.9993,.9987,.9974,.9953,.9918,.9861,.9772,.9641,...
             .9452,.9192,.8849,.8413,.7881,.7257,.6554,.5793,.5]';
         
    fac=1;
    %c  check to see if y is within range
      if y<0.0228
         x = -2.0;
         return
      elseif y<0.5
        yp = 1-y;
        fac = -1;
      elseif y>=0.9993
        x = 3.5;
        return
      else
        yp = y;
      end
      %now search the range of xx and yy
      for i=17:-1:0
          if yp<=yy(i+1)
              x=xx(i)+(yp-yy(i))*(xx(i+1)-xx(i))/(yy(i+1)-yy(i));
              x=fac*x;
              return
          end
      end
         
    end