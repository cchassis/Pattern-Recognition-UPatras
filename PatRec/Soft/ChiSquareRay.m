function [Error] = ChiSquareRay(x,Np,Nint)
%#
%#  [Error] = ChiSquareRay(x,Np,Nint)
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
end
[Mean,Var] = MeanVarCol(x) ;
a = Mean - sqrt( pi * Var / ( 4 - pi ) ) ;
b = 4 * Var / ( 4 - pi ) ;
xs = sort(x) ;
Dp = d1 / Np ;
Spr = 1 / Np ;
C1 = 2 / b ;
C2 = -1 / ( 2 * Var ) ;
Error = 0 ;
for i=1:Np
	Stp = floor((i-1) * Dp) + 1 ;
	Endp = floor(i * Dp) ;
	if ( xs(Endp) < a )
		Pr = 0 ;
	elseif ( xs(Endp) > a & xs(Stp) < a )
		Xt = xs(Endp) ;
		Pr = 0 ;
		Step = (Xt - a) / Nint ;  
		r=a+Step/2 ;
		while( r < Xt )
			xa = ( r - a ) ;
			xb = xa * xa ;
			Pr = Pr + C1 * xa * exp( C2 * xb ) ;
			r = r + Step ;
		end
		Pr = Pr * Step ;
	else
      Xt = xs(Endp) ;
		Xs = xs(Stp) ;
      Pr = 0 ;
      Step = (Xt - Xs) / Nint ;
      r=Xs+Step/2 ;
		while( r < Xt )
         xa = ( r - a ) ;
         xb = xa * xa ;
         Pr = Pr + C1 * xa * exp( C2 * xb ) ;
			r = r + Step ;
      end
      Pr = Pr * Step ;
	end
	Error = Error + ( Pr - Spr )^2 / Spr ;
end
