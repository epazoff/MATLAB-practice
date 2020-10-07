function [v8,specT,TSFC,Pstar,cp8,gamma8,A8m] = nozzle(type,Ma,R,gammaa,Pa,Ta,P06,T06,f,cp6,effn)
%nozzle
va=Ma*sqrt(gammaa*R*Ta);
Pstar=P06*(1+(1-gammaa)/(effn*(1+gammaa)))^(gammaa/(gammaa-1));
if strcmp(type,'conv-div')
    v8=sqrt(2*cp6*effn*T06*(1-(Pa/P06)^((gammaa-1)/gammaa)));
    specT=v8-2*va;
else
    if Pstar<Pa
        v8=sqrt(2*cp6*1000*effn*T06*(1-(Pa/P06)^((gammaa-1)/gammaa)));
        specT=v8-2*va;
        A8m=0;
    else
        v8=sqrt(2*cp6*1000*effn*T06*(1-(Pstar/P06)^((gammaa-1)/gammaa)));
        T8=T06*(2/(gammaa+1));
        rho=Pstar/(R*T8);
        A8m=(1+f)/(rho*v8);
        specT=(1+f)*v8-va+(Pstar-Pa)*A8m;
    end
end
TSFC=f/specT;
cp8=cpcalculator(T06); %WRONG
gamma8=gammacalculator(T06); %WRONG
end

