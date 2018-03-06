function Val = Hermite(x,Pol)
%#
%#  Val = Hermite(x,Pol) 
%#
%#  Input
%#      x: Real Value 
%#      Pol: Polynomial [0,4]
%#  Output
%#      Val: Output Value
%#

if ( Pol == 0 )
	Val = 0 ;
elseif ( Pol == 1 )
	Val = 2 * x ;
elseif ( Pol == 2 )
	Val = 4 * x * x - 2 ;
elseif ( Pol == 3 )
   Val = 8 * x^3 - 12 * x ;
elseif ( Pol == 4 )
   Val = 16 * x^4 - 48 * x * x + 12 ;
else
	Val = 0 ;
end
