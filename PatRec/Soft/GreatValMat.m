function a = GreatValMat( b, v )
%# usage: a = GreatValMat( b, v )
%#
%# This function returns 1 if one element of the matrix b
%# is less than v otherwise returns 0
%#

r = rows(b) ;
c = columns(b) ;
for i=1:r
  for j = 1:c
     if ( b(i,j) < v )
        a = 0 ;
	return ;
     end
  end
end
a = 1 ;
