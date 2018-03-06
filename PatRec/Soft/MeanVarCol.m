function [Mean,Var] = MeanVarCol(x)
%#
%#  [Mean,Var] = MeanVarCol(x)
%#
%#  Input
%#      x: Pattern Vectors
%#  Output
%#      Mean: Mean Value Vector
%#      Var: Variance
%#

d1 = columns( x ) ;
d2 = rows(x) ;
Mean = zeros( d2, 1 ) ;
Var = zeros( d2, 1 ) ;

for i = 1:d1
	Mean = Mean + x(:,i) ;
	Var = Var + x(:,i) .* x(:,i) ;
end
Mean = Mean / d1 ;
Var = Var / d1 - Mean .* Mean ;
Var = (d1 / ( d1 - 1 )) * Var ;  
