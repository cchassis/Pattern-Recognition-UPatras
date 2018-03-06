function Val = Legendre(x,Pol)
%#
%#  Val = Legendre(x,Pol) 
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
	Val = x ;
elseif ( Pol == 2 )
	Val = 1.5 * x * x - 0.5 ;
elseif ( Pol == 3 )
   Val = 2.5 * x^3 - 0.5 * x ;
elseif ( Pol == 4 )
   Val = 3.125 * x^4 - 3.75 * x * x + 0.375 ;
else
	Val = 0 ;
end
