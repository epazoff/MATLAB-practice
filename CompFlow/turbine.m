function [P05,T05,cp5,gamma5] = turbine(P04,T04,cp3,cp4,f,T02,T03,effm,efft)
%turbine
T05=T04-(cp3*(T03-T02)/(effm*(1+f)*cp4));
cp5=cpcalculator(T05);
gamma5=gammacalculator(T05);
P05=P04*((1-(1-(T05/T04))/efft)^(gamma5/(gamma5-1)));

end

