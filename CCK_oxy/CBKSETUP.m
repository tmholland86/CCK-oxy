function [ COALC,COALH,OMEGA,HTVL,RHOA,...
     XK3OI,FUELRHOC,XAO,CHARXAO,RHOCO,P,FUELRHO,XK7OI,XK4OBYK7O,...
     XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,E7,E4mE7,...
     E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7 ] = CBKSETUP( COALC,COALH,OMEGA,HTVL,RHOA,...
      XK3OI,FUELRHOC,XAO,P,XK7OI,XK4OBYK7O,...
      XK4ROBYK7O,XK5OBYK7O,XK6OBYK7O,XK6ROBYK7O,XK8OBYK7O,E7,E4mE7,...
      E4RmE7,E5mE7,E6mE7,E6RmE7,E8mE7 )
%This function sets up the CBK calculation and outputs all of its results
%for further use in calculations

%This function has been verified agains the orgininal FORTRAN CCK code.

%Note that for the output in matlab functions, the name of the output value
%is designated in the CALL of the function, not by what I call my input and
%output arguments here. 

%Note that input arguments are locally defined by the name given here, and do not
%redefine anything in the main script, though they can be redefined within
%the function.

%Initialize all the input arguments at their own value so they have an
%output value if nothing reassigns them here.



% C
% C  Calculate "hydrogen departure function" 
% C  used to make a correction to reactivity and swelling
% C  factor for high-inertinite (hydrogen-poor) coals
% C

HEXP=171.9-(7.025*COALC)+(.09762*(COALC^2))-(.0004472*(COALC^3));
HDEPART=COALH-HEXP;

   

% % % % % C   Use extended (inertinite) correlation 
% % % % % C    to reduce swelling factor, if appropriate
% % % % % C
% % % % 
% % % % XINERT=19.98-29.04*HDEPART;
% % % % if XINERT>100 
% % % %     XINERT=100;
% % % % end
% % % % if XINERT<0 
% % % %     XINERT=0;
% % % % end
% % % % OMEGA=OMEGA-(OMEGA-1)*(XINERT-19.98)/(100-19.98); Replaced with
% Randy's correlation for OMEGA

%C  Estimate effect of P on swelling

ENHANCE=1;
if (P>1)&&(P<8) 
    ENHANCE=.7143+.2857*P;
end
if (P>8)&&(P<40) 
    ENHANCE=3.5-.0625*P;
end
OMEGA=OMEGA^ENHANCE;


%C  Fuel density setup

if FUELRHOC<0
    if COALC>80
        FUELRHOC=.92902+.0026753*COALC;
    elseif COALC>76
        FUELRHOC=.14325*COALC-10.317;
    else
        FUELRHOC=.57;
    end
end

FUELRHO=1/((XAO/RHOA)+((1-XAO)/FUELRHOC));
RHOCHAR=FUELRHO*(XAO+(1-HTVL)*(1-XAO))/OMEGA^3;

%Compute initial char ash content

CHARXAO=XAO/(XAO+((1-XAO)*(1-HTVL)));

%C  Calculate the initial char carbon density

RHOCO=(1-CHARXAO)/((1/RHOCHAR)-(CHARXAO/RHOA));

%Reactivity setup

if XK3OI<0
    if P<1
        XK3OI=10^(14.38-(.0764*COALC));
    else
        XK3OI=10^(12.22-(.0535*COALC));
    end
end

if XK7OI<0.0 
    XK7OI=10^((0.1*COALC)-0.64);
end
if XK4OBYK7O<0.0 
    XK4OBYK7O=(1.84E+3)*exp(-0.073*COALC);
end
if XK4ROBYK7O<0.0 
    XK4ROBYK7O=(3.47E-5)*COALC-1.73E-3;
end
if XK5OBYK7O<0.0
    XK5OBYK7O=1/692;
end
if XK6OBYK7O<0.0
    if COALC<90.6
        XK6OBYK7O=.05;
    else
        XK6OBYK70=.021*COALC-1.86;
    end
end

if XK6ROBYK7O<0
    XK6ROBYK7O=(-3.68e-8)*COALC+3.2E-6;
end
if XK8OBYK7O<0
    XK8OBYK7O=(7.9E-5);
end

%Setup Activation Energy

if E7==-1
    E7=(3.52*COALC-131.1)*1987/8.314;%why are only two of these positive?
end
if E4mE7==-1
    E4mE7=(54)*1987/8.314;
end
if E4RmE7==-1
    E4RmE7=(-53.9)*1987/8.314;
end
if E5mE7==-1
    E5mE7=(-50)*1987/8.314;
end
if E6mE7==-1
    E6mE7=(-16)*1987/8.314;
end
if E6RmE7==-1
    E6RmE7=(-156)*1987/8.314;
end
if E8mE7==-1
    E8mE7=(-26)*1987/8.314;
end


end

