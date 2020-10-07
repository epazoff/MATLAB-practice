function [P03,T03,cp3,gamma3] = compressor(P02,T02,pic,effc,gamma2)
%compressor
T03=T02*(1+(((pic^((gamma2-1)/gamma2))-1)/effc));
P03=pic*P02;
cp3=cpcalculator(T03);
gamma3=gammacalculator(T03);

end

