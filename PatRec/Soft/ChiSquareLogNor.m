function [Error] = ChiSquareLogNor(x,Np,Nint)
%#
%#  [Error] = ChiSquareLogNor(x,Np,Nint)
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
a = 0.5 * ( log( Var / ( exp(Var) - 1 ) ) - Var ) ;
b = Mean - exp( a + Var / 2 ) ;
xs = sort(x) ;
Dp = d1 / Np ;
Spr = 1 / Np ;
C1 = 1 / sqrt( Var * 2 * pi ) ;
C2 = -1 / ( 2 * Var ) ;
Error = 0 ;
for i=1:Np
	Stp = floor((i-1) * Dp) + 1 ;
	Endp = floor(i * Dp) ;
	if ( xs(Endp) < b )
		Pr = 0 ;
	elseif ( xs(Endp) > b & xs(Stp) < b )
		Xt = xs(Endp) ;
		Pr = 0 ;
		Step = (Xt - b) / Nint ;  
		r=b+Step/2 ;
		while( r < Xt )
			xb = ( r - b ) ;
			Pr = Pr + C1 * exp( C2 * (log(xb)-a) ) / xb ;
			r = r + Step ;
		end ;
		Pr = Pr * Step ;
	else
      Xt = xs(Endp) ;
		Xs = xs(Stp) ;
      Pr = 0 ;
      Step = (Xt - Xs) / Nint ;
      r=Xs+Step/2 ;
		while( r < Xt )
         xb = ( r - b ) ;
         Pr = Pr + C1 * exp( C2 * (log(xb)-a) ) / xb ;
			r = r + Step ;
      end ;
      Pr = Pr * Step ;
	end ;
	Error = Error + ( Pr - Spr )^2 / Spr ;
end ;
