function [Error] = ChiSquareUni(x,Np)
%#
%#  [Error] = ChiSquareUni(x)
%#
%#  Input
%#      x: Pattern Vectors
%#  Output
%#      Error: The error of the X-square test
%#      Np: Number of partitions

d1 = columns( x ) ;
if ( rows(x) ~= 1 )
	printf( 'The data must be in a vector form\n' ) ;
	return ;
end
[Mean,Var] = MeanVarCol(x) ;
a = Mean - sqrt( Var * 3 ) ;
b = Mean + sqrt( Var * 3 ) ;
xs = sort(x) ;
Dp = d1 / Np ;
Spr = 1 / Np ;
Error = 0 ;
for i=1:Np
	Stp = floor((i-1) * Dp) + 1 ;
	Endp = floor(i * Dp) ;
	if ( xs(Endp) < a )
		Pr = 0 ;
	elseif ( xs(Endp) > a & xs(Stp) < a )
		Pr = ( xs(Endp) - a ) / ( b - a ) ;
	elseif  ( xs(Endp) < b & xs(Stp) > a )
		Pr = ( xs(Endp) - xs(Stp) ) / ( b - a ) ;
   elseif  ( xs(Endp) > b & xs(Stp) < b )
      Pr = ( b - xs(Stp) ) / ( b - a ) ;
	else
		Pr = 0 ;
	end
	Error = Error + ( Pr - Spr )^2 / Spr ;
end
