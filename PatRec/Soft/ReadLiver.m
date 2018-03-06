function [x,c] = ReadLiver(Tot)
%#
%#  [x,c] = ReadLiver(Tot)
%#   Read the Liver database stored in the file "liverdisorder.data"
%#  Input:
%#      Tot: Number of Patterns
%#  Output:
%#      x: Patterns matrix
%#      c: Classes integer

if ( Tot > 345 )
   Tot = 345 ;
end

f1 = fopen( '../DATA/liverdisorder.data', 'r' ) ;
x = zeros(6,Tot) ;
c = zeros(1,Tot) ;
for j = 1:Tot
	for i = 1:6
   	x(i,j) = fscanf( f1, '%f', 1 ) ; 
	end
	c(1,j) = fscanf( f1, '%d', 1 ) ;
end
fclose(f1) ;
