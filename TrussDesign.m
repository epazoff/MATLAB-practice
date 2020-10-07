clear
clc

C = [1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 1 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 1 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 1 1 0 1 1 0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 1 1 0 1 1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 1 1 0 1 1 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 0 0 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 1 0;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1;
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1];
Sx = [1 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0];
Sy = [0 1 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 1];
X = [0 5.5 11 17.25 22 26.75 33 37.5 44 49.5 55];
Y = [0 10.9 0 10.9 0 10.9 0 10.9 0 10.9 0];
L = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 11.691 0 0 0 0 0 0];

%The matrix will be entered by the user
L = L';
 
%Create 2 matrices for future usage
matx = zeros(size(C));
maty = zeros(size(C));


dancho = zeros(1,size(C,2));


%Calculating the x components
for i = 1:size(C,2)
        ref =(find(C(:,i)==1))';
        highval = X(ref(2))-X(ref(1));
        distance = sqrt((X(ref(2))-X(ref(1)))^2+(Y(ref(2))-Y(ref(1)))^2);
        tablu = highval/distance;
        vecko(i) = distance;
        highval2 = X(ref(1))-X(ref(2));
        ele2 = highval2/distance;
        gymy(ref(1),i) = tablu;
        gymy(ref(2),i) = ele2;
end


%Calculating the y components
for j = 1:size(C,2)
    ref = (find(C(:,j)==1))';
    highval = Y(ref(2))-Y(ref(1));
    distance = sqrt((X(ref(2))-X(ref(1)))^2+(Y(ref(2))-Y(ref(1)))^2);
    tot1 = highval/distance;
    illuminati(ref(1),j) = tot1;
    highval2 = Y(ref(1))-Y(ref(2));
    tot2 = highval2/distance;
    illuminati(ref(2),j) = tot2;
end
 
%Creation of matrix A
MatA = [gymy Sx;illuminati Sy];
 
%Calculating the magnitude of the unknown force
T = inv(MatA)*(L);
 
%Labeling of tension and compression
for l = 1:(length(T)-3)
    if T(l)<0
        state = char('C');
    elseif T(l)>0
        state = char('T');
    elseif T(l)== 0
        state = char('');
    end
        fprintf('m%d: %.3f N (%c)\n',l,abs(T(l)),state)
end
 
%Reaction forces
disp('Reaction Forces in Newtons:')
Sx1 = T(length(T)-2);
Sy1 = T(length(T)-1);
Sy2 = T(length(T));
fprintf('Sx1: %.3f\n',Sx1)
fprintf('Sy1: %.3f\n',Sy1)
fprintf('Sy2: %.3f\n',Sy2)
 
%Calculating the total load
totload = sum(L);
fprintf('Load: %d N\n?',totload)
 
%Calculating the buckling load
n = length(vecko);


Buck = zeros(1,n);
Table = zeros(1,n);
for i = 1:n
    Buck(i) = (1277.78)*((vecko(i))^(-2));
    Table(i) = 643.7125*((vecko(i))^(-3));
end
 
%Calculating force/buckling load ratio of members 
ratio = zeros(1,n);
for i = 1:n;
    ratio(i) = T(i)/Buck(i) ;
end


RatioC = transpose(ratio);
Ratio_TB_1 = RatioC;
 
%Breaking order of members
[border,Bulgaria] = sortrows(RatioC,1); 
 maxload = max(L)/abs(min(ratio)); 
%Calculating the maximum load 
%{
LoweLoad = find(L>0);
while max(RatioC) < 1
    L(LoweLoad) = max(L)+.1;
    T = inv(MatA)*(L);
    for i = 1:n;
        ratio(i) = abs(T(i))/Buck(i) ;
    end
    RatioC = transpose(ratio);
end
maxload = max(L);
%}
fprintf('The maximum load is: %.3f \n', maxload)
  
%Calculating the cost of the truss
[r1,c1] = size(C);
Cost = (10*r1) + (sum(vecko));
fprintf('The cost of the truss: $%.2f\n',Cost)


%Calculating the load/cost ratio
nitya = maxload/Cost;
fprintf('Theoretical max load/cost ratio in N/$: %.4f\n\n',nitya)


%Getting the Maximum load uncertainty
latee = (Table(Bulgaria(1))/100)*maxload;
fprintf('Maximum load uncertainty: %.4f\n\n',latee)


%Printing the buckling load for each member
    for i = 1:n
        fprintf('Buckling load for m%d: %.3f N\n',i,Buck(i))
    end


%Printing which one will buckle first
    for i = 1:n
        fprintf('m%d will be %d to break with a F/B ratio of %.3f \n',Bulgaria(i),i,RatioC(Bulgaria(i)))
    end


%Location of joint (applied load)
member=find(ratio==min(ratio));
fprintf('A load of more than %.3f N at the joint will collapse the bridge\n',maxload)


% fprintf('EK301, Section A3, Group Straight Out of Compton: Nitya Rudraraju, Emma Pazoff, Dancho Ivanov, 11/15/16');


