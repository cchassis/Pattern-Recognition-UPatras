function [x,c] = ReadBreastCancer(Tot)
%#
%#  [x,c] = ReadBreastCancer(Tot)
%#   Read the Breast Cancer stored in the file "wdbc.data"
%#  Input:
%#      Tot: Number of Patterns
%#  Output:
%#      x: Patterns matrix
%#      c: Classes integer

if ( Tot > 569 )
   Tot = 569 ;
end

f1 = fopen( '../DATA/wdbc.data', 'r' ) ;
x = zeros(30,Tot) ;
c = zeros(1,Tot) ;
for j = 1:Tot
	br = fscanf( f1, '%s', 1 ) ;
	br = fscanf( f1, '%s', 1 ) ;
	if ( strcmp( br, 'B' ) == 1 )
		c(1,j) = 1 ;
	else
		c(1,j) = 2 ;
	end
	for i = 1:30
   	x(i,j) = fscanf( f1, '%f', 1 ) ; 
	end
end
fclose(f1) ;
