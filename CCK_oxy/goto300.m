%This script circumvents the lack of a goto command in matlab for the
%specific case of the CCK code stating GOTO 300
%P300='300 START';

if ITSOLVE==0
    Q=0;
    goto500;
    return
end
%P300='300 END';
goto350;
return
