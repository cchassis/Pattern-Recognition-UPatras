function [Error] = ChiSquareLap(x,Np,Nint)
%#
%#  [Error] = ChiSquareLap(x,Np,Nint)
%#
%#  Input
%#      x: Pattern Vectors
%#  Output
%#      Error: The error of the Chi-square test
%#      Np: Number of partitions 
%#      Nint: Number of partitions for the integral computations

d1 = columns( x ) ;
if ( rows(x) ~= 1 )
	printf( 'The data must be in a vector form\n' ) ;
	return ;
end ;
[Mean,Var] = MeanVarCol(x) ;
xs = sort(x) ;
Dp = d1 / Np ;
Spr = 1 / Np ;
b = sqrt( 2 / Var ) ;
C1 = b / 2 ;
C2 = -b ;
Error = 0 ;
for i=1:Np
	Stp = floor((i-1) * Dp) + 1 ;
	Endp = floor(i * Dp) ;
	Xt = xs(Endp) ;
	a = xs(Stp) ;
	Pr = 0 ;
	Step = (Xt - a) / Nint ;  
	r=a+Step/2 ;
	while( r < Xt )
		Pr = Pr + C1 * exp( C2 * abs( r - Mean ) ) ;
		r = r + Step ;
	end ;
	Pr = Pr * Step ;
	Error = Error + ( Pr - Spr )^2 / Spr ;
end ;
