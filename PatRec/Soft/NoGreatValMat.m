function a = NoGreatValMat( b,v )
a = 0 ;
r = rows(b) ;
c = columns(b) ;
for i=1:r
  for j = 1:c
     if ( b(i,j) >= v )
        a++ ;
     end
  end
end
