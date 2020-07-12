clear 
close all;
%% Model obiektu

A = [0 1 0;...
    0 -0.875 -20;...
    0 0 -50];

B = [0;...
     0;...
     50];

% stabilnosc
eig(A) % na granicy stabilnosci
% sterowalnosc
disp(rank(ctrb(A,B))); %sterowalny
 
% macierze wagowe

Q = diag([2 4 8]); % stan
R = 0.5; % wejscie

% definicja macierzy X
X = sym('x',[3 3]);

% rownanie Ricattiego

L = A'*X + X*A + Q - X*B*(R^-1)*B'*X;
P = zeros(3,3);

eqns = L == P;

S = solve(eqns); % <-- drugi element kazdego z wektorow rozwiazaia zgadza sie z wynikiem CARE matlaba

% sprawdzenie CARE

[X,P,Km] = care(A,B,Q,R); %stabilne
%K z CARE ma odwrocony znak w stosunku do laboratorium
K = -Km;
K2 = (-R^-1)*B'*X; %<--

%% Wykresy

t = out.tout;
x = out.x;
x1 = x(:,1);
x2 = x(:,2);
x3 = x(:,3);


figure(1)
plot(t,x1,'g',t,x2,'b',t,x3,'r','Linewidth',1);
legend('\theta','\omega','\tau');
grid on;
xlim([-0.5 10])
xlabel('t (s)')
ylabel('x(t)')

xprim = out.xprim;
x1prim = xprim(:,1);
x2prim = xprim(:,2);
x3prim = xprim(:,3);

figure(2)
plot(t,x1prim,'g',t,x2prim,'b',t,x3prim,'r');
legend('d\theta/dt','d\omega/dt','d\tau/dt');
grid on;

a = 2*x2prim;

figure(3)
plot(t,a,'Color','#D95319','LineWidth',1);
legend('a');
grid on;
xlim([-0.5 10])
xlabel('t (s)')
ylabel('a(t) (m/s^2)')