%%%TURBOJET
%inputs
M=0.75;
Pa=101352.9; %Pa
Ta=288; %K
%mc=74.843; %kg/s
%pic=15;
f=0.03;
dH= 41402.8; %kJ/kg
pid=0.92;
%effc=0.88;
effb=0.91;
%pib=0.95;
%efft=0.85;
effm=0.995;
effn=0.96;
efff=0.9;
efffn=0.95;
pif=1.6;
piu=0.98;
gamma=1.4;
alpha=3;
sigma=0.25;
R=287; %J/kg*K

type='conv';

mc2=166; %lbm/s
Nc2=11800; %rpm keep N fixed, change mc...

[pic,effc] = comp_map_11_1(mc2, Nc2);

[P0a,T0a,cpa,gammaa]=totals(M,Pa,Ta,gamma);
fprintf('P0a= %2.3f Pa\n',P0a)
fprintf('T0a= %2.3f K\n',T0a)
[P02,T02,cp2,gamma2]=diffuser(P0a,T0a,pid);
fprintf('P02= %2.3f Pa\n',P02)
fprintf('T02= %2.3f K\n',T02)
[P03,T03,cp3,gamma3]=compressor(P02,T02,pic,effc,gamma2);
fprintf('P03= %2.3f Pa\n',P03)
fprintf('T03= %2.3f K\n',T03)

tc=1+((pic^((gamma-1)/gamma)-1)/effc);
mc3=mc2*sqrt(tc)/pic;
ft=f/(T03/Ta);
pib=burner_map_11_1(mc3, ft);

[P04,T04,cp4,gamma4] = burner2(P03,T03,f,dH,pib,effb,cp3);
fprintf('P04= %2.3f Pa\n',P04)
fprintf('T04= %2.3f K\n',T04)
fprintf('f= %2.6f\n',f)

tb=T04/T03;
mc4=(1+ft)*mc3*sqrt(tb)/pib;
Nc4=Nc2/sqrt(tb*tc);
[pit,efft] = turbine_map_11_1(mc4, Nc4);



%[P07,T07,cp7,gamma7]=fan(P02,T02,gamma2,pif,efff);
%fprintf('P07= %2.3f Pa\n',P07)
%fprintf('T07= %2.3f K\n',T07)

%THIS DOES NOT WORK, NEEDS TO BE FIXED!!
[P05,T05,cp5,gamma5] = turbine(P04,T04,cp3,cp4,f,T02,T03,effm,efft);
fprintf('P05= %2.3f Pa\n',P05)
fprintf('T05= %2.3f K\n',T05)

%if mixed, no bypass duct, assume P05=P07.5
%[P075,T075,cp75,gamma75]=bypassduct(P07,T07,piu);
%fprintf('P07.5= %2.3f Pa\n',P075)
%fprintf('T07.5= %2.3f K\n',T075)

%[T055,cp55,gamma55]=mixer(T05,T075,cp5,cp75,f,alpha,sigma);
%fprintf('T05.5= %2.3f K\n',T055)

[v8,specT,TSFC,Pstar,A8m,cp8,gamma8]=nozzle(type,M,R,gammaa,Pa,Ta,P05,T05,f,cp5,effn);
%[v9,specT9,TSFC9,Pstar9,cp9,gamma9]=fannozzle(P07,T07,cp7,gamma7,M,Pa,Ta,gammaa,v8,Pstar,A8m,alpha,f,efffn,R);
fprintf('Pstar= %2.3f Pa\n',Pstar)
fprintf('specific thrust= %2.3f units\n',specT)
fprintf('TSFC= %2.8f units\n',TSFC)

%fprintf('Pstar9= %2.3f Pa\n',Pstar9)
%fprintf('specific thrust 9= %2.3f units\n',specT9)
%fprintf('TSFC9= %2.8f units\n',TSFC9)