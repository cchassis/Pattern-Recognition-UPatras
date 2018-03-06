function [x,c] = ReadSatImage(Tot)
%#
%#  [x,c] = ReadSatImage(Tot)
%#   Read the Satelite image database stored in the file "satimage.data"
%#  Input:
%#      Tot: Number of Patterns
%#  Output:
%#      x: Patterns matrix
%#      c: Classes integer

if ( Tot > 6435 )
   Tot = 6435 ;
end
f1 = fopen( '../DATA/satimage.data', 'r' ) ;
x = zeros(36,Tot) ;
c = zeros(1,Tot) ;
for j = 1:Tot
	for i = 1:36
   	x(i,j) = fscanf( f1, '%f', 1 ) ; 
	end
	c(1,j) = fscanf( f1, '%d', 1 ) + 1 ;
end
fclose(f1) ;
