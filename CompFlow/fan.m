function [P07,T07,cp7,gamma7] = fan(P02,T02,gamma2,pif,efff)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
P07=pif*P02;
T07=T02*(1+((pif^((gamma2-1)/gamma2)-1)/efff));
cp7=cpcalculator(T07);
gamma7=gammacalculator(T07);

end

