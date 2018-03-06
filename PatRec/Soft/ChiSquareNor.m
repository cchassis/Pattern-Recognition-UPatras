function [Error] = ChiSquareNor(x,Np,Nint)
%#
%#  [Error] = ChiSquareNor(x,Np,Nint)
%#
%#  Input
%#      x: Pattern Vectors
%#      Np: Number of partitions 
%#      Nint: Number of partitions for the integral computations
%#  Output
%#      Error: The error of the Chi-square test

d1 = columns( x ) ;
if ( rows(x) ~= 1 )
	printf( 'The data must be in a vector form\n' ) ;
	return ;
end
[Mean,Var] = MeanVarCol(x) ;
xs = sort(x) ;
Dp = d1 / Np ;
Spr = 1 / Np ;
C1 = 1 / sqrt( pi * 2 * Var ) ;
C2 = -1 / ( 2 * Var ) ;
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
		xa = ( r - Mean ) ;
		xb = xa * xa ;
		Pr = Pr + C1 * exp( C2 * xb ) ;
		r = r + Step ;
	end
	Pr = Pr * Step ;
	Error = Error + ( Pr - Spr )^2 / Spr ;
end
