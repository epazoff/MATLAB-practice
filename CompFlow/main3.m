%%%MATCHING
%inputs
M=0.5;
Pa=101300; %Pa
Ta=289; %K
%mc=74.843; %kg/s
%pic=15;
f=0.013;
dH= 41840; %kJ/kg
pid=1;
%effc=0.88;
effb=0.91;
%pib=0.95;
%efft=0.85;
effm=1;
effn=0.98;
%efff=0.9;
%efffn=0.95;
%pif=1.6;
%piu=0.98;
gamma=1.4;
%alpha=3;
%sigma=0.25;
R=287; %J/kg*K
A8min=.2089;

type='conv';

mc2=50.091;
Nc2=6000;

%mc2=50.458; %lbm/s
%Nc2=6100; %rpm keep N fixed, change mc...

%mc2=49.24; %what brandon got
%Nc2=5979; 
c=0;
%while (c==0 || abs(mc5-mc51)>.001)
%c=c+1;    
%count=0;
%while (count==0 || abs(pit-pit1)>.0001) 
%count=count+1;    
[pic,effc] = comp_map_11_11(mc2, Nc2);

[P0a,T0a,cpa,gammaa]=totals(M,Pa,Ta,gamma);
fprintf('P0a= %2.3f Pa\n',P0a)
fprintf('T0a= %2.3f K\n',T0a)
[P02,T02,cp2,gamma2]=diffuser(P0a,T0a,pid);
fprintf('P02= %2.3f Pa\n',P02)
fprintf('T02= %2.3f K\n',T02)
[P03,T03,cp3,gamma3]=compressor(P02,T02,pic,effc,gamma2);
fprintf('P03= %2.3f Pa\n',P03)
fprintf('T03= %2.3f K\n',T03)

tc=1+((pic^((gamma2-1)/gamma2)-1)/effc);
mc3=mc2*sqrt(tc)/pic;
ft=f/(T03/Ta);
pib=burner_map_11_11(mc3, ft);

[P04,T04,cp4,gamma4] = burner2(P03,T03,f,dH,pib,effb,cp3);
fprintf('P04= %2.3f Pa\n',P04)
fprintf('T04= %2.3f K\n',T04)
fprintf('f= %2.6f\n',f)

tb=T04/T03;
mc4=(1+ft)*mc3*sqrt(tb)/pib;
Nc4=Nc2/sqrt(tb*tc);
[pit,efft] = turbine_map_11_11(mc4, Nc4);

%[P07,T07,cp7,gamma7]=fan(P02,T02,gamma2,pif,efff);
%fprintf('P07= %2.3f Pa\n',P07)
%fprintf('T07= %2.3f K\n',T07)

%THIS DOES NOT WORK, NEEDS TO BE FIXED!!
[P05,T05,cp5,gamma5] = turbine(P04,T04,cp3,cp4,f,T02,T03,effm,efft);
fprintf('P05= %2.3f Pa\n',P05)
fprintf('T05= %2.3f K\n',T05)

pit1=P05/P04;

%if((pit-pit1)>.0001)
%    mc2=mc2+.0001;
%elseif ((pit1-pit)>.0001)
%    mc2=mc2-.0001;
%end

%end

%if mixed, no bypass duct, assume P05=P07.5
%[P075,T075,cp75,gamma75]=bypassduct(P07,T07,piu);
%fprintf('P07.5= %2.3f Pa\n',P075)
%fprintf('T07.5= %2.3f K\n',T075)

%[T055,cp55,gamma55]=mixer(T05,T075,cp5,cp75,f,alpha,sigma);
%fprintf('T05.5= %2.3f K\n',T055)

[v8,specT,TSFC,Pstar,cp8,gamma8]=nozzle(type,M,R,gamma,Pa,Ta,P05,T05,f,cp5,effn);
%[v9,specT9,TSFC9,Pstar9,cp9,gamma9]=fannozzle(P07,T07,cp7,gamma7,M,Pa,Ta,gammaa,v8,Pstar,A8m,alpha,f,efffn,R);
fprintf('Pstar= %2.3f Pa\n',Pstar)
fprintf('specific thrust= %2.3f units\n',specT)
fprintf('TSFC= %2.8f units\n',TSFC)

T8=T05*(1-(1-(Pa/P05)^((gamma5-1)/gamma5))*effn);
rho8=Pa/(R*T8);
m5=rho8*v8*A8min;
mc5=(m5*sqrt(T05/Ta))/(P05/Pa);
mc51=(mc4*sqrt(T05/T04))/(pit);

%if((mc5-mc51)>.001)
%    Nc2=Nc2+.1;
%elseif ((pit1-pit)>.001)
%    Nc2=Nc2-.1;
%end

%end

M8=v8/sqrt(gamma8*R*T8);
A8=A8min*(1/M8)*sqrt((gamma8+1)/(2+(gamma8-1)*(M8^2)))*(effn*(1+(1-gamma8)/(effn*(1+gamma8)))/((1/(1+((gamma8-1)/2)*(M8^2)))-1+effn))^(gamma8/(gamma8-1));


va=M*sqrt(gammaa*R*Ta);
thrust=m5*((1+f)*v8-va);

%thrust=mc*(1+f)*v8-mc*va
%different groups doing different fuel to air ratios (f values) we are
%f=0.013!!
%as f decreases, N decreases, same with mc
%N ranges between 5700 and 110000 for a f range of 0.01 to 0.023

%fprintf('Pstar9= %2.3f Pa\n',Pstar9)
%fprintf('specific thrust 9= %2.3f units\n',specT9)
%fprintf('TSFC9= %2.8f units\n',TSFC9)