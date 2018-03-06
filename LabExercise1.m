%% (a)

A = [ 1 1 1; 2 2 2; 1 1 1];
B = [ 2 23 1; 4 6 3; 6 -26 5];

E = (A*B')*A'+B-A*B;
F = (A.*B)+3*B;

A = [ 1 2 3 -9 5 6; 2 2 3 5 2 7; 1 4 1 3 1 1];
pseudoA = (inv(A'*A))*A'

%% (b)

syms x y z w
eq1 = 5*x - 2*y + 3*z - w == 6;
eq2 = x + 2*y - 3*z == 9;
eq3 = -3*x + y -2*w == -1;
eq4 = 4*x + 3*y - z + 5*w == -7;

[A,B] = equationsToMatrix([eq1, eq2, eq3, eq4], [x, y, z, w]);
X = linsolve(A,B)

%% (c)

x = 0:0.01:1;
f = tan(1+exp(x.^2));
g = x.^3 + sin(x.^2) + 5;

plot (x,f,x,g)

%% (d)

file = fopen('PatRec\DATA\data.dat','r');
