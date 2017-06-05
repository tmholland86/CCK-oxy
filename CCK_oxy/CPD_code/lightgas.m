 function [yygas,inside,lib,yyyy,yf,xoc,yhc]=...
                     lightgas(yygas,inside,lib,yyyy,yf,xoc,yhc,iii)
        %this function calculates the distribution of light gas species
        %based on a reference table look-up
        
        yf;
        xoc;
        yhc;
        % c *******************************************************************
        % c ****************LIGHT GAS DISTRIBUTION REFERENCE LIBRARY***********
        % c *******************************************************************
        % 
        % c  This library can be moved outside of submodel as long as
        % c  it is linked to the light gas sub-model
        % 
        % c  xz = The index used in correlation.  In main program it 
        % c  corresponds to variable "yf"
        % 
        % c  f*** = fraction of light gas that is species ***
        % 
        % c  the data is organized in the following order with 12 ordered
        % c  pairs for each species (ordered with xz)
        % 
        % c  each table is organized in rows in the following order 
        % c 	1 Lower Kittaning (Chen)
        % c	2 Pocahontas #3 (ANL)
        % c	3 Upper Freeport (ANL)
        % c	4 Pittsburgh (Chen)
        % c	5 Lewis Stockton (ANL)	
        % c	6 Utah Blind Canyon (ANL)
        % c	7 Illinois #6 (ANL)
        % c	8 Illinois #6 (Chen)
        % c	9 Wyodak (ANL)
        % c	10 Beulah Zap (ANL)
        % c	11 Dietz (Chen)
        % c	12 PSOC 1448 (Serio)
        % 
        
        % c  reference data for xz = yf, the fractional light gas released
        
        xz=[0.,.04,.11,.14,.21,.27,.34,.675,.9,1.,.0,.0;...
     	.0,.161,.442,.663,.777,.874,.921,.967,1.,.0,.0,.0;...
     	.0,.022,.20,.430,.526,.64,.787,.875,.927,.955,1.,.0;...
     	.0,.04,.12,.15,.23,.29,.36,.68,.9,1.,.0,.0;...
     	.0,.018,.058,.21,.417,.572,.696,.778,.821,.883,.932,1.;...
     	.0,.052,.144,.291,.498,.639,.746,.859,.925,.949,.966,1.;...
     	.0,.063,.178,.33,.506,.612,.706,.813,.895,.94,1.,.0;...
       .0,.04,.12,.15,.23,.29,.36,.68,.9,1.,.0,.0;...
     	.0,.061,.146,.374,.535,.622,.714,.8,.883,.931,.964,1.;...
     	.0,.034,.087,.179,.316,.472,.585,.694,.777,.872,.935,1.;...
     	.0,.04,.12,.16,.25,.31,.37,.68,.9,1.,.0,.0;...
     	.0,.02,.055,.17,.313,.434,.546,.716,.874,.935,.973,1]';
    
    %c  fraction of light gas that is water
    fh2o=[.772,.772,.738,.455,.371,.304,.290,.273,.218...
                   .218,.0,.0;...
     	.699,.632,.299,.269,.247,.249,.236,.225,.226,.0,.0,.0;...
     	.0,.0,.35,.297,.301,.299,.284,.291,.306,.297,.283,.0;...
     	.636,.636,.646,.550,.436,.320,.186,.199,.195,.195,.0,.0;...
     	1.,.983,.754,.488,.413,.385,.373,.382,.377,0.362,.367,.348;...
     	.665,.636,.604,.508,.435,.409,.383,.362,.351,.343,.342,.339;...
     	.763,.737,.698,.572,.527,.470,.438,.411,.411,.396,.378,.0;...
     	.748,.748,.637,.704,.490,.446,.348,.268,.266,.266,.0,.0;...
     	.0,.0,.385,.461,.396,.369,.344,.323,.292,.277,.266,.257;...
     	.0,.0,.197,.267,.26,.333,.361,.369,.346,.306,.285,.267;...
     	.521,.521,.55,.523,.511,.46,.414,.388,.313,0.313,.0,.0;...
     	.0,.0,.291,.335,.264,.271,.261,.211,.171,.160,.153,.149]';
    
    %c  fraction of light gas that is carbon dioxide
    fco2=[0,.0,.0,.174,.174,.167,.129,.102,.071,.071,.0,.0;...
     	.259,.234,.113,.086,.097,.109,.116,.118,.122,.0,.0,.0;...
     	.333,.327,.070,.052,.057,.06,.059,.062,.066,.08,0.115,.0;...
     	.194,.194,.152,.117,.116,.122,.081,.092,.065,.065,.0,.0;...
     	.0,.0,.0,.122,.103,.086,.083,.082,.085,.086,.093,.128;...
     	.332,.318,.165,.141,.120,.108,.105,.119,.120,.122,.125,.130;...
     	.229,.221,.125,.09,.07,.073,.083,.133,.132,.13,.147,.0;...
     	.111,.111,.142,.175,.149,.155,.136,.122,.133,.133,.0,.0;...
     	.98,.984,.55,.345,.317,.285,.286,.277,.273,.264,.254,.255;...
     	.993,.989,.786,.572,.519,.416,.375,.345,.335,.32,.303,.299;...
     	.363,.363,.353,.325,.321,.35,.318,.251,.249,.249,.0,.0;...
     	1.,.983,.448,.179,.104,.09,.104,.151,.166,.160,.158,.154]';
    
    %c  fraction of light gas that is methane
    
    fch4=[.203,.203,.078,.160,.180,.219,.258,.294,.320,...
                    .320,.0,.0;...
        .041,.037,.388,.389,.359,.332,.323,.307,.299,.0,.0,.0;...
     	.667,.655,.42,.454,.444,.419,.382,.353,.331,.321,.306,.0;...
     	.055,.055,.073,.088,.116,.124,.170,.15,.189,.189,.0,.0;...
     	.0,.0,.188,.195,.234,.243,.224,.21,.2,.186,.177,.167;...
     	.0,.0,.11,.155,.176,.172,.185,.173,.163,.159,.156,.151;...
     	.0,.0,.075,.136,.159,.178,.174,.157,.143,.141,.132,.0;...
     	.02,.02,.026,.042,.045,.049,.064,.1,.128,.128,.0,.0;...
     	.0,.0,.0,.029,.048,.067,.069,.072,.069,.066,.063,.061;...
    	.0,.0,.0,.0,.035,.05,.061,0.058,.057,.053,.049,.046;...
     	.01,.01,.011,.016,.011,.021,.023,.035,.06,.06,.0,.0;...
     	.0,.0,.216,.262,.362,.327,.307,.25,.203,.189,.182,.177]';
        
        
    %c  fraction of light gas that is carbon monoxide
    
    fco=[0,.0,.157,.121,.141,.112,.139,.085,.145,...
                   .145,.0,.0;...
     	.0,.0,.0,.057,.097,.109,.124,.15,.153,.0,.0,.0;...
        .0,.0,.0,.0,.0,.024,.078,.097,.099,.104,.099,.0;...
     	.083,.083,.038,.066,.032,.168,.286,.324,.313,.313,.0,.0;...
     	.0,.0,.0,.0,.055,.091,.124,.131,.142,.171,.168,.162;...
     	.0,.0,.0,.028,.093,.129,.142,.162,.181,.191,.193,.195;...
     	.0,.0,.0,.075,.099,.122,.139,.133,.148,.167,.177,.0;...
     	.101,.101,.173,.054,.219,.247,.335,.349,.28,.280,.0,.0;...
     	.0,.0,.055,.115,.151,.168,.172,.2,.236,.264,.287,.298;...
     	.0,.0,.0,.133,.142,.150,.15,.173,.206,.265,.307,.331;...
     	.096,.096,.066,.113,.123,.13,.2,.281,.334,.334,.0,.0;...
     	.0,.0,.0,.084,.078,.115,.130,.191,.262,.294,.311,.322]';
    
    % c	************************************************************
    % c	**********End of Reference library**************************
    % c	************************************************************
    % 
    % c  *********************************************************************	
    % C  *******DETERMINE THE APPROPRIATE TRIANGLE FOR INTERPOLATION**********
    % c  *********************************************************************
    
    %c define the equations of line, distance and area
    
    yyy=@(aa,xd,bb) aa*xd+bb;
    xxx=@(aa,yd,bb) (yd-bb)/aa;
    d=@(x2,x1,y2,y1) ((x2-x1)^2+(y2-y1)^2)^.5;
    at2=@(aa,bb,cc) 0.5*bb*cc*(1-((bb^2+cc^2-aa^2)/(2*bb*cc))^2)^.5;
    
    %initialize variables (use x1 and y1 to avoid cross-over with other
    %nested functions
    x1=xoc;
    y1=yhc;
    ind=yf;
    
    %c  look up table of the reference points of the triangular mesh
    xx=[.0177734,.0203654,.0659401,.0773465,.0893623,.1077369,...
     		.1305803,.1357569,.1803479,.2093441,.2603201,.0687]';

    yy=[.6717240,.5810955,.6550527,.8088697,.7575807,.8506428,...
     		.7671163,.8523190,.8499221,.7890888,.8572938,.863]';    
        
    %c  look up table for a and b of equations of all triangle sides
     a=[-34.965,1.6228,-.34612,2.3021,1.7337,1.1993,4.3774,...
            -4.2685,.23134,5.0647,1.3746,-3.6565,.059818,16.459,...
            1.6638,-.05375,.27897,-2.0979,.092179,1.3380,3.7559,...
            -6.2604,-.31655]';
        
     b=[1.2932,.54805,.67788,.63081,.54074,.65041,.36641,...
            1.1390,.73691,.30499,.70255,1.2446,.84420,-1.3821,...
            .54985,.85962,.73069,1.2283,.83330,.50899,.60497,...
            1.2931,.88475]';
    %c  look up table for the three sides that correspond to each triangle
    
    
    s1=[1,3,4,7,8,10,12,14,15,18,21,22]';
    s2=[2,7,6,5,10,9,14,15,17,20,4,11]';
    s3=[3,6,8,9,11,12,13,16,18,19,22,23]';
   
    %c  do loop to find the appropriate triangle for interpolation
    %c	if(iii.eq.1)then
    
   m=0;
   inside=true;
   for i=1:12
       z1=xxx(a(s1(i)),y1,b(s1(i)));
       z2=xxx(a(s2(i)),y1,b(s2(i)));
	   z3=yyy(a(s3(i)),x1,b(s3(i)));
       if (x1>=z1&&x1<=z2&&y1<=z3)
           m=i;
           break
       elseif (i==12&&m==0)
           print1='one or both ratios are out of bounds';
           inside=false;
       end
   end
   yyyy=true;    
   
    % c  *****************************************************************	
    % C  *****************TRIANGULAR INTERPOLATION************************
    % c  *****************************************************************
    
    
    if inside==true
        % c  This interpolation scheme is taken from Zhao et al., 25th Symp.
        % c  on Comb. (Int.), 1994/pp. 553-560. 
        % 
        % c  look up table for points 1,2, and 3 for each triangle
        p1=[2,3,1,3,5,5,7,7,7,10,1,4]';
        p2=[1,1,4,5,4,6,6,8,9,9,12,12]';
        p3=[3,5,5,7,6,7,8,9,10,11,4,6]';
        
        %calculate the length of each side
    
        ds1=d(xx(p1(i)),xx(p2(i)),yy(p1(i)),yy(p2(i)));
        ds2=d(xx(p3(i)),xx(p1(i)),yy(p3(i)),yy(p1(i)));
        ds3=d(xx(p3(i)),xx(p2(i)),yy(p3(i)),yy(p2(i)));
        ds4=d(x1,xx(p2(i)),y1,yy(p2(i)));
        ds5=d(xx(p1(i)),x1,yy(p1(i)),y1);
        ds6=d(xx(p3(i)),x1,yy(p3(i)),y1);
        
        % c	print*,' ds1,ds2,ds3 = ',ds1,ds2,ds3
        % 
        % c  calculate the area of each triangle used in interpolation scheme
        
        A1=at(ds1,ds2,ds3);
        A2=at(ds1,ds5,ds4);
        A3=at(ds5,ds2,ds6);

        % c	print*,' A1,A2,A3 = ',A1,A2,A3
        % 
        % c  calculate S and R, the weighted fraction of two of the points
        % c  the weighted fraction of other point will be 1-R-S
        S=A2/A1;
        R=A3/A1;
        % c	************************************************************
        % c	*************CALCULATE LIGHT GAS DISTRIBUTION***************
        % c	************************************************************
        
        %c  n is the number of order pairs of data for coals 1-12
        
        n=[10,9,11,10,12,12,11,10,12,12,10,12]';
        
        % c  do loop to calculate the light gas composition of each reference
        % c  coal (point) of triangle.  this is accomplished using linear 
        % c  interpolation between points in reference library
        
        %c  j specifies the point (1,2, or3) of the triangle selected above
        
        for j=1:3
            if j==1
                lib=p1(i);
            elseif j==2
                lib=p2(i);
            else
                lib=p3(i);
            end
        
        
    
    
        %c  do loop to find the two xz points that surround ind
        
        for ii=1:12
            if (ind>=xz(ii,lib)&&ind<=xz(ii+1,lib))
                break
            end
        end
    
        %c  linear interpolation to find reference values as a function of ind
         ygas(1,j)=((ind-xz(ii+1,lib))/(xz(ii,lib)-xz(ii+1,lib)))...
     			*fh2o(ii,lib)+((ind-xz(ii,lib))/(xz(ii+1,lib)...
                 -xz(ii,lib)))*fh2o(ii+1,lib);
        ygas(2,j)=((ind-xz(ii+1,lib))/(xz(ii,lib)-xz(ii+1,lib)))...
     			*fco2(ii,lib)+((ind-xz(ii,lib))/(xz(ii+1,lib)...
                 -xz(ii,lib)))*fco2(ii+1,lib);
        ygas(3,j)=((ind-xz(ii+1,lib))/(xz(ii,lib)-xz(ii+1,lib)))...
     			*fch4(ii,lib)+((ind-xz(ii,lib))/(xz(ii+1,lib)...
                 -xz(ii,lib)))*fch4(ii+1,lib);
        ygas(4,j)=((ind-xz(ii+1,lib))/(xz(ii,lib)-xz(ii+1,lib)))...
     			*fco(ii,lib)+((ind-xz(ii,lib))/(xz(ii+1,lib)...
                 -xz(ii,lib)))*fco(ii+1,lib);
        end
    end
    % c	************************************************************
    % c	*******CALCULATE GAS COMPOSITION FROM LIBRARY COALS*********
    % c	************************************************************
    
    if inside==true
        for k=1:4
            yygas(k)=(1-R-S)*ygas(k,1)+R*ygas(k,2)+S*ygas(k,3);
        end
    end
    
    % c	************************************************************
    % c	*****Estimate composition for coals outside mesh************
    % c	************************************************************
    
    if inside==false
        out=[0,.085,.835,1.5,12,.085,.12,.835,1.5,6,.12,.155,...
               .835,1.5,8,.155,.222,.835,1.5,9,.222,.285,.75,1.5,11,...
               .0,.089,.75,.835,4,.0,.05,.63,.75,1,.05,.175,.63,...
               .69,3,.066,.175,.69,.835,7,.175,.222,.0,.835,10,...
               .0,.175,.55,.63,2,.222,1.,.0,.75,10,.285,1,0.75,1.5,13,...
                .0,.175,.0,.55,14]';
        out=reshape(out,[5,14]);
        for kk=1:14
            if x1>out(1,kk)&&x1<=out(2,kk)
                if y1>=out(3,kk)&&y1<out(4,kk)
                    lib=out(5,kk);
                    if lib==13
                      yygas(1)=0.24;
                      yygas(2)=0.37;
                      yygas(3)=0.06;
                      yygas(4)=0.28;
                        break
                    end
                    if lib==14
                        yygas(1)=0.18;
                        yygas(2)=0.08;
                        yygas(3)=0.37;
                        yygas(4)=0.18;
                        break
                    end
        %c  do loop to find the two xz points that surround ind           
                    for ii=1:12
                        if ind>=xz(ii,lib)&&ind<=xz(ii+1,lib)
                            break
                        end
                    end
        yygas(1)=((ind-xz(ii+1,lib))/(xz(ii,lib)-xz(ii+1,lib)))...
     			*fh2o(ii,lib)+((ind-xz(ii,lib))/(xz(ii+1,lib)...
                 -xz(ii,lib)))*fh2o(ii+1,lib);
        yygas(2)=((ind-xz(ii+1,lib))/(xz(ii,lib)-xz(ii+1,lib)))...
     			*fco2(ii,lib)+((ind-xz(ii,lib))/(xz(ii+1,lib)...
                 -xz(ii,lib)))*fco2(ii+1,lib);
        yygas(3)=((ind-xz(ii+1,lib))/(xz(ii,lib)-xz(ii+1,lib)))...
     			*fch4(ii,lib)+((ind-xz(ii,lib))/(xz(ii+1,lib)...
                 -xz(ii,lib)))*fch4(ii+1,lib);
        yygas(4)=((ind-xz(ii+1,lib))/(xz(ii,lib)-xz(ii+1,lib)))...
     			*fco(ii,lib)+((ind-xz(ii,lib))/(xz(ii+1,lib)...
                 -xz(ii,lib)))*fco(ii+1,lib);   
             out(1,kk);
             out(2,kk);
             out(3,kk);
             out(4,kk);
             out(5,kk);
             print1='Light gas distribution is based on ref. #';, lib;
             x1;
             y1;
             break
                end
            end
        end
    end
    yygas(5)=1-yygas(1)-yygas(2)-yygas(3)-yygas(4);
                    
    end