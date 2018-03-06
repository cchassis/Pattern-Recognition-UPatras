function a = AbsMat( b )
%# usage: a = AbsMat( b )
%#
%# This function returns the absolute values of the array elements |b(i,j)|
%#
r = rows(b) ;
c = columns(b) ;
for i=1:r
  for j = 1:c
     if ( b(i,j) < 0.0 )
        a(i,j) = - b(i,j) ;
     else
        a(i,j) = b(i,j) ;
     end ;
  end ;
end ;
