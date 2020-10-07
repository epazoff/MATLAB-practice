function cp = cpcalculator(T)
%uses formula y=0.95887034243*exp(1.6776203574e-4x)

a=0.95887034243;
b=0.00016776203574;
cp=a*exp(b*T);

end

