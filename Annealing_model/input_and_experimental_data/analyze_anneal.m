function [R1,Rref]=analyze_anneal(Thistory_R1,Thistory_Rref,AD,LNSIGMA,a,b,c,bins,tf,tr)


%After considerable testing, this code predicts char deactivation
%independantly of time step, and I have found that accurate predictions
%should include a 2 row Thistory in many cases. Row 1=conditions and times
%for the char particle to heat up to its treatment temperature. Row
%2=conditions for the actual heat treatment. No annealing treatment is
%computed for the reactivity measurement time or re-heating to reactive conditions on the grounds that the time
%is often unavailable, and competing effects of changing conversion are far
%greater than the relativley low temperature treatment during the
%reactivity test.



%execute model for char 1

Thistory=Thistory_R1;%(particle temperature, heating rate, soak time, and regime)
DELT(1:length(Thistory(:,3)),1)=1*10^-4;%s
for l=1:length(DELT)%adjust DELT to be reasonable for the soak time
    if Thistory(l,3)>1 && Thistory(l,2)~=0
        DELT(l,1)=.01/Thistory(l,2);
    elseif Thistory(l,3)>1 && Thistory(l,2)==0
        DELT(l,1)=.1;
    end
    if DELT(l,1)>.1%keep really slow heating rates from changing R1 too much
        DELT(l,1)=.1;
    end
    if Thistory(l,3)>100
        DELT(l,1)=1;
    end
end

[ R1 ] = match_reactivity( Thistory,AD,LNSIGMA,a,b,c,DELT,bins,tf,tr);
clear DELT
%execute model for char 2

Thistory=Thistory_Rref;%(particle temperature, heating rate, soak time, and regime)
DELT(1:length(Thistory(:,3)),1)=1e-4;%s
for l=1:length(DELT)%adjust DELT to be reasonable for the soak time
    if Thistory(l,3)>1 && Thistory(l,2)~=0
        DELT(l,1)=Thistory(l,3)/Thistory(l,2);
    elseif Thistory(l,3)>1 && Thistory(l,2)==0
        DELT(l,1)=.1;
    end
    if DELT(l,1)>.1%keep really slow heating rates from changing R1 too much
        DELT(l,1)=.1;
    end
    if Thistory(l,3)>100
        DELT(l,1)=1;
    end
end

[ Rref ] = match_reactivity( Thistory,AD,LNSIGMA,a,b,c,DELT,bins,tf,tr);

end