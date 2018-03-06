function Val = Laguerre(x,Pol)
%#
%#  Val = Laguerre(x,Pol) 
%#
%#  Input
%#      x: Real Value 
%#      Pol: Polynomial [0,4]
%#  Output
%#      Val: Output Value
%#

if ( Pol == 0 )
	Val = 1 ;
elseif ( Pol == 1 )
	Val = 1 - x ;
elseif ( Pol == 2 )
	Val = x * x - 4 * x + 2 ;
elseif ( Pol == 3 )
   Val = -x^3 + 9 * x^2 - 18 * x * x + 6 ;
elseif ( Pol == 4 )
   Val = x^4 - 16 * x^3 + 72 * x^2 - 96 * x + 24 ;
else
	Val = 0 ;
end
