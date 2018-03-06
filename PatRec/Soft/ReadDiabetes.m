function [x,c] = ReadDiabetes(Tot)
%#
%#  [x,c] = ReadWine(Tot)
%#   Read the Wine database stored in the file "pima-indians-diabetes.data"
%#  Input:
%#      Tot: Number of Patterns
%#  Output:
%#      x: Patterns matrix
%#      c: Classes integer

if ( Tot > 768 )
   Tot = 768 ;
end
f1 = fopen( '../DATA/pima-indians-diabetes.data', 'r' ) ;
x = zeros(8,Tot) ;
c = zeros(1,Tot) ;
for j = 1:Tot
	for i = 1:8
   	x(i,j) = fscanf( f1, '%f', 1 ) ; 
	end
	c(1,j) = fscanf( f1, '%d', 1 ) + 1 ;
end
fclose(f1) ;
