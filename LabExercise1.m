close all;
clear all;

%% (a)

%	declare matrices
A = [ 1 1 1; 2 2 2; 1 1 1];
B = [ 2 23 1; 4 6 3; 6 -26 5];
%	compute appropriate expressions
E = (A*B')*A'+B-A*B;
F = (A.*B)+3*B;
%	re-declare matrix A
A = [ 1 2 3 -9 5 6; 2 2 3 5 2 7; 1 4 1 3 1 1];
%   calculate pseudoinverse matrix
pseudoA = (inv(A'*A))*A'

%% (b)

%   declare variables
syms x y z w
%   declare equations
eq1 = 5*x - 2*y + 3*z - w == 6;
eq2 = x + 2*y - 3*z == 9;
eq3 = -3*x + y -2*w == -1;
eq4 = 4*x + 3*y - z + 5*w == -7;
%   solve linear equations
[A,B] = equationsToMatrix([eq1, eq2, eq3, eq4], [x, y, z, w]);
X = linsolve(A,B)

%% (c)

%   set space [0,1]
x = 0:0.01:1;
%   declare functions
f = tan(1+exp(x.^2));
g = x.^3 + sin(x.^2) + 5;
%   plot said functions in the same figure
figure('Name','(c) Plots of f(x) and g(x)','NumberTitle','off');
plot (x,f,x,g)

%% (d)

%   import data from path
data = importdata('data.dat');
%   else use this and add route
%data = importdata('/Users/chris/Documents/MATLAB/Αναγνώριση Προτύπων/data.dat')
%   separate patterns
pat1 = data(1:5,:);
pat2 = data(6:10,:);
pat3 = data(11:15,:);
pat4 = data(16:20,:);

% (1)

%   initialise 5x8 patterns matrix
patterns = zeros(5,8);
%   add patterns to said matrix
patt = [pat1 pat2 pat3 pat4];
%   same as above
%patterns(:,1:2) = pat1;
%patterns(:,3:4) = pat2;
%patterns(:,5:6) = pat3;
%patterns(:,7:8) = pat4;
%   test print
%patterns

% (2)

figure('Name','(d)(2) Separate Pattern Scatters','NumberTitle','off');
subplot(2,2,1)
scatter(pat1(:,1),pat1(:,2),'o')
axis([-10 10 -10 10])
title('Pattern no.1')

subplot(2,2,2)
scatter(pat2(:,1),pat2(:,2),'+')
axis([-10 10 -10 10])
title('Pattern no.2')

subplot(2,2,3)
scatter(pat3(:,1),pat3(:,2),'x')
axis([-10 10 -10 10])
title('Pattern no.3')

subplot(2,2,4)
scatter(pat4(:,1),pat4(:,2),'*')
axis([-10 10 -10 10])
title('Pattern no.4')

% (3)

figure('Name','(d)(3) Overlapped Pattern Scatters','NumberTitle','off');
scatter(pat1(:,1),pat1(:,2),'o')
hold on;
scatter(pat2(:,1),pat2(:,2),'+')
hold on;
scatter(pat3(:,1),pat3(:,2),'x')
hold on;
scatter(pat4(:,1),pat4(:,2),'*')
axis([-10 10 -10 10])
hold off;

% (4)

%src: https://www.mathworks.com/help/nnet/examples/linearly-non-separable-vectors.html

Rpat1 = pat1';
Rpat2 = pat2';
Rpat3 = pat3';
Rpat4 = pat4';

X12 = [Rpat1 Rpat2];
X23 = [Rpat2 Rpat3];
X34 = [Rpat3 Rpat4];
X41 = [Rpat4 Rpat1];
T = [1 1 1 1 1 0 0 0 0 0];

figure('Name','(d)(4) Separate Pattern Scatters','NumberTitle','off');

%   compare pattern1 & pattern2
subplot(2,2,1)

net = perceptron;
net = configure(net,X12,T);
hold on;
%   styling
scatter(pat1(:,1),pat1(:,2),'o')
hold on;
scatter(pat2(:,1),pat2(:,2),'+')
axis([-10 10 -10 10]);
title('Processing');
hold on;
%   algorithm
linehandle = plotpc(net.IW{1},net.b{1});
for a = 1:100
   [net,Y,E] = adapt(net,X12,T);
   linehandle = plotpc(net.IW{1},net.b{1},linehandle);  drawnow;
end;
title ('Linear Separation between Pattern 1 & 2');
hold off;

subplot(2,2,2)
net = perceptron;
net = configure(net,X23,T);
hold on;

scatter(pat2(:,1),pat2(:,2),'+')
hold on;
scatter(pat3(:,1),pat3(:,2),'x')
axis([-10 10 -10 10]);
title('Processing');
hold on;

linehandle = plotpc(net.IW{1},net.b{1});
for a = 1:100
   [net,Y,E] = adapt(net,X23,T);
   linehandle = plotpc(net.IW{1},net.b{1},linehandle);  drawnow;
   hold on;
   
%   if(a==98)
%       a98 = linehandle
%   elseif(a==99)
%       a99 = linehandle
%   end
%   if(a==100 && a98 ~= a99)
%       title('no linear separation')
%   elseif(a==100 && a98 == a99)
%       title('linear separation')
%   end
       
end;
title('Linear Separation between Pattern 2 & 3');
hold off;

subplot(2,2,3)
net = perceptron;
net = configure(net,X34,T);
hold on

scatter(pat3(:,1),pat3(:,2),'x')
hold on;
scatter(pat4(:,1),pat4(:,2),'*')
axis([-10 10 -10 10]);
title('Processing');
hold on;

linehandle = plotpc(net.IW{1},net.b{1});
for a = 1:100
   [net,Y,E] = adapt(net,X34,T);
   linehandle = plotpc(net.IW{1},net.b{1},linehandle);  %drawnow;
end;
title('Linear Separation between Pattern 3 & 4');
hold off;

subplot(2,2,4)
net = perceptron;
net = configure(net,X41,T);
hold on

scatter(pat4(:,1),pat4(:,2),'*')
hold on;
scatter(pat1(:,1),pat1(:,2),'o')
axis([-10 10 -10 10]);
title('Processing');
hold on;

linehandle = plotpc(net.IW{1},net.b{1});
for a = 1:100
   [net,Y,E] = adapt(net,X41,T);
   linehandle = plotpc(net.IW{1},net.b{1},linehandle);  drawnow;
end;
title('Linear Separation between Pattern 4 & 1');
hold off;