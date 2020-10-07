function [P05,T05,cp5,gamma5] = turbinefan(P04,T02,T03,T04,T07,mc,cp3,cp4,cp7,effm,efft,f,alpha)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
T05=T04-(((cp3*(T03-T02))+(alpha*cp7*(T07-T02)))/(effm*(1+f)*cp4));
cp5=cpcalculator(T05);
gamma5=gammacalculator(T05);

P05=P04*((1-(1-(T05/T04))/efft)^(gamma5/(gamma5-1)));

end

