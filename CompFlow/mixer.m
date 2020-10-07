function [T055,cp55,gamma55] = mixer(T05,T075,cp5,cp75,f,alpha,sigma)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
T055=(((1+f)*cp5*T05)+(sigma*alpha*cp75*T075))/(((1+f)*cp5)+(sigma*alpha*cp75));
cp55=cpcalculator(T055);
gamma55=gammacalculator(T055);

end

