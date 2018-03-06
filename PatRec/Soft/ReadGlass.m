function [x,c] = ReadGlass(Tot)
%#
%#  [x,c] = ReadGlass(Tot)
%#   Read the Glass database stored in the file "glass.data"
%#  Input:
%#      Tot: Number of Patterns
%#  Output:
%#      x: Patterns matrix
%#      c: Classes integer

if ( Tot > 214 )
   Tot = 214 ;
end

f1 = fopen( '../DATA/glass.data', 'r' ) ;
x = zeros(9,Tot) ;
c = zeros(1,Tot) ;
for j = 1:Tot
	b = fscanf( f1, '%d', 1 ) ;
	for i = 1:9
   	x(i,j) = fscanf( f1, '%f', 1 ) ; 
	end
	c(1,j) = fscanf( f1, '%d', 1 ) ;
end
fclose(f1) ;


