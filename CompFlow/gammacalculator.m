function gamma = gammacalculator(T)
%uses formula y=1.42030014*exp(-0.0000568489698x)

a=1.42030014;
b=-0.0000568489698;
gamma=a*exp(b*T);

end

