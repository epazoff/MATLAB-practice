function [P0a,T0a,cpa,gammaa] = totals(Ma,Pa,Ta,gamma)
%NEED TO ACTUALLY FIGURE THIS OUT
T0a=Ta*(1+(Ma^2)*(gamma-1)/2);
P0a=Pa*((T0a/Ta)^(gamma/(gamma-1)));
cpa=cpcalculator(T0a);
gammaa=gammacalculator(T0a);
end

