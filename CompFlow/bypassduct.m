function [P075,T075,cp75,gamma75] = bypassduct(P07,T07,piu)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
P075=piu*P07;
T075=T07;
cp75=cpcalculator(T075);
gamma75=gammacalculator(T075);

end

