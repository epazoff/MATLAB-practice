function [P04,T04,cp4,gamma4] = burner2(P03,T03,f,dH,pib,effb,cp3)
%burner given f, find T04
P04=pib*P03;

T04i=(f*effb*dH+cp3*T03)/(cp3*(1+f));
cp4i=cpcalculator(T04i);

T04o=(f*effb*dH+cp3*T03)/(cp4i*(1+f));
cp4o=cpcalculator(T04o);
while (abs(cp4i-cp4o)>0.0001)
    T04i=T04o;
    cp4i=cp4o;
    T04o=(f*effb*dH+cp3*T03)/(cp4i*(1+f));
    cp4o=cpcalculator(T04o);
end

T04=T04o;
cp4=cp4o;

gamma4=gammacalculator(T04);
%cpb=(cp3+cp4)/2;
%T04=(f*effb*dH+cpb*T03)/(cpb*(1+f));
%cp4=cpb;
end

