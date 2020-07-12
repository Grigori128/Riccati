clear 
close all;
%% Model obiektu

A = [0 1 0 0;...
    0 -1 0 0;...
    0 0 0 1;...
    0 0 0 -1];

B = [0 0;...
    1 0;...
    0 0;...
    0 1];

C = eye(4);

 
% stabilność
disp(rank(ctrb(A,B))); % na granicy stabilności

% macierze wagowe
Q = diag([50 0 1 0]); % stan
R = diag([0.001 0.001]); % wejscie

% rownanie Ricattiego

[X,P,K] = care(A,B,Q,R); %stabilne

% sprawdzenie stabilnosci rozwiazania
disp(eig(A-B*K)); 

% feedforward
 A1 = A - (B*K);
 G = dcgain(ss(A1,B,C,0));
 Ff = pinv(G);