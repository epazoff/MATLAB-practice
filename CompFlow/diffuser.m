function [P02,T02,cp2,gamma2] = diffuser(P0a,T0a,pid)
%diffuser
P02=pid*P0a;
T02=T0a;
cp2=cpcalculator(T02);
gamma2=gammacalculator(T02);

end

