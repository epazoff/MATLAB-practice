function [P04,f,cp4,gamma4] = burner1(P03,T03,T04,dH,pib,effb,cp3)
%given T04, calculating f
P04=pib*P03;
cp4=cpcalculator(T04);
gamma4=gammacalculator(T04);
f=((cp4*T04-cp3*T03)/(effb*dH-cp4*T04));

end

