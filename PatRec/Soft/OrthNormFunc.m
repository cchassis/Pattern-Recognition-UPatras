function Val = OrthNormFunc(x,Transf,Type)
%#
%#  Val = OrthNormFunc(x,Transf,Type) 
%#
%#  Input
%#      x: Input Vector(s) 
%#      Pol: Polynomial index
%#      Type: Type of orthonormal functions
%#          1: Hermite   2: Laguerre    3: Legendre
%#  Output
%#      Val: Output Vector(s)

xRows = rows(x) ;
cTr = rows( Transf ) ;
Vects = columns(x) ;
if ( xRows ~= columns(Transf) )
   display( 'Rows of x and Transf must be equal\n' ) ;
   return ;
end
Val = zeros(cTr,Vects) ;
if ( Type == 1 )
for k = 1:Vects
	for i = 1:cTr
		for j = 1:xRows
				Val(i,k) = Val(i,k) + Hermite(x(j,k),Transf(i,j)) ;
		end
	end
end
elseif ( Type == 2 )
for k = 1:Vects
   for i = 1:cTr
      for j = 1:xRows
            Val(i,k) = Val(i,k) + Laguerre(x(j,k),Transf(i,j)) ;
      end
   end
end
elseif ( Type == 3 )
for k = 1:Vects
   for i = 1:cTr
      for j = 1:xRows
            Val(i,k) = Val(i,k) + Legendre(x(j,k),Transf(i,j)) ;
      end
   end
end
else
	display( 'Parameter Type = 1,2,3\n' ) ;
	Val = 0 ;
end
