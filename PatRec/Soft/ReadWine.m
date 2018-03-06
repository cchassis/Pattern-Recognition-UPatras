function [x,c] = ReadWine(Tot)
%#
%#  [x,c] = ReadWine(Tot)
%#   Read the Wine database stored in the file "wine.data"
%#  Input:
%#      Tot: Number of Patterns
%#  Output:
%#      x: Patterns matrix
%#      c: Classes integer

if ( Tot > 178 )
   Tot = 178 ;
end
f1 = fopen( '../DATA/wine.data', 'r' ) ;
x = zeros(13,Tot) ;
c = zeros(1,Tot) ;
for j = 1:Tot
	c(1,j) = fscanf( f1, '%d', 1 ) ;
	for i = 1:13
   	x(i,j) = fscanf( f1, '%f', 1 ) ; 
	end
end
fclose(f1) ;


