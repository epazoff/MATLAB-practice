%%%TURBOFAN
%inputs
M=0.75;
Pa=101300; %Pa
Ta=288; %K
mc=74.843; %kg/s
pic=15;
T04=1350; %K
dH= 41400; %kJ/kg
pid=0.92;
effc=0.88;
effb=0.91;
pib=0.95;
efft=0.85;
effm=0.995;
effn=0.96;
efff=0.9;
efffn=0.95;
%pif=1.6;
piu=0.98;
pim=0.97;
gamma=1.4;
alpha=3; %bypass ratio!
sigma=1;
R=287; %J/kg*K

type='conv';

%mc2=168; %lbm/s
%Nc2=12000; %rpm keep N fixed, change mc...

%[pic,effc] = comp_map_11_1(mc2, Nc2);

[P0a,T0a,cpa,gammaa]=totals(M,Pa,Ta,gamma);
fprintf('P0a= %2.3f Pa\n',P0a)
fprintf('T0a= %2.3f K\n',T0a)
[P02,T02,cp2,gamma2]=diffuser(P0a,T0a,pid);
fprintf('P02= %2.3f Pa\n',P02)
fprintf('T02= %2.3f K\n',T02)
[P03,T03,cp3,gamma3]=compressor(P02,T02,pic,effc,gamma2);
fprintf('P03= %2.3f Pa\n',P03)
fprintf('T03= %2.3f K\n',T03)

%tc=1+((pic^((gamma-1)/gamma)-1)/effc);
%mc3=mc2*sqrt(tc)/pic;
%ft=f/(T03/Ta);
%pib=burner_map_11_1(mc3, ft);

[P04,f,cp4,gamma4]=burner1(P03,T03,T04,dH,pib,effb,cp3);
fprintf('P04= %2.3f Pa\n',P04)
fprintf('T04= %2.3f K\n',T04)
fprintf('f= %2.6f\n',f)

%tb=T04/T03;
%mc4=(1+ft)*mc3*sqrt(tb)/pib;
%Nc4=Nc2/sqrt(tb*tc);
%[pit,efft] = turbine_map_11_1(mc4, Nc4);

pif=1.5;
minTSFC=100;
TSFC9=1000;
inc=true;

%while(TSFC9>=minTSFC && inc)
[P07,T07,cp7,gamma7]=fan(P02,T02,gamma2,pif,efff);
fprintf('P07= %2.3f Pa\n',P07)
fprintf('T07= %2.3f K\n',T07)

%THIS DOES NOT WORK, NEEDS TO BE FIXED!!
[P05,T05,cp5,gamma5]=turbinefan(P04,T02,T03,T04,T07,mc,cp3,cp4,cp7,effm,efft,f,alpha);
fprintf('P05= %2.3f Pa\n',P05)
fprintf('T05= %2.3f K\n',T05)

%if mixed, no bypass duct, assume P05=P07.5
[P075,T075,cp75,gamma75]=bypassduct(P07,T07,piu);
fprintf('P07.5= %2.3f Pa\n',P075)
fprintf('T07.5= %2.3f K\n',T075)

[T055,cp55,gamma55]=mixer(T05,T075,cp5,cp75,f,alpha,sigma);
fprintf('T05.5= %2.3f K\n',T055)

[v8,specT,TSFC,Pstar,cp8,gamma8,A8m] = nozzle(type,M,R,gammaa,Pa,Ta,P05,T05,f,cp5,effn);
[v9,specTmc,TSFC9,Pstar9,A9m,cp9,gamma9]=fannozzle(P07,T07,cp7,gamma7,M,Pa,Ta,gammaa,v8,Pstar,A8m,alpha,sigma,f,efffn,R);

%if(TSFC9<minTSFC)
%    minTSFC=TSFC9;
%    pif=pif+1;
%else
%    inc=false;
%    pif=pif-1;
%end

%end
fprintf('Pstar= %2.3f Pa\n',Pstar)
fprintf('specific thrust= %2.3f units\n',specT)
fprintf('TSFC= %2.8f units\n',TSFC)

fprintf('Pstar9= %2.3f Pa\n',Pstar9)
fprintf('specific thrust mc= %2.3f units\n',specTmc)
fprintf('TSFC9= %2.8f units\n',TSFC9)