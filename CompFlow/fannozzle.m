function [v9,specTmc,TSFC9,Pstar9,A9m,cp9,gamma9] = fannozzle(P07,T07,cp7,gamma7,Ma,Pa,Ta,gammaa,v8,Pstar,A8m,alpha,sigma,f,efffn,R)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
va=Ma*sqrt(gammaa*R*Ta);
v9=sqrt(2000*cp7*T07*(1-((Pa/P07)^((gamma7-1)/gamma7))));
Pstar9=P07*(1+(1-gammaa)/(efffn*(1+gammaa)))^(gammaa/(gammaa-1));
if Pstar9<Pa
    specTmc=(1+f+sigma*alpha)*v8-(1+alpha)*va+(1-sigma)*alpha*(v9);
    A9m=0;
else
    T9=T07*(2/(gammaa+1));
    rho=Pstar9/(R*T9);
    A9m=(1+f)/(rho*v9);
    specTmc=(1+f+sigma*alpha)*v8-(1+alpha)*va+(1-sigma)*alpha*(v9)+(Pstar-Pa)*A8m+(Pstar9-Pa)*A9m;
end

TSFC9=f/specTmc;
cp9=cpcalculator(T07); %WRONG
gamma9=gammacalculator(T07); %WRONG

end

