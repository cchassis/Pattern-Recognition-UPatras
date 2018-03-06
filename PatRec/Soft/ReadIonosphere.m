function [x,c] = ReadIonosphere(Tot)
%#
%#  [x,c] = ReadIonosphere(Tot)
%#   Read the Ionosphere database stored in the file "ionosphere.data"
%#  Input:
%#      Tot: Number of Patterns
%#  Output:
%#      x: Patterns matrix
%#      c: Classes integer

if ( Tot > 351 )
   Tot = 351;
end

f1 = fopen( '../DATA/ionosphere.data', 'r' ) ;
x = zeros(34,Tot) ;
c = zeros(1,Tot) ;
for j = 1:Tot
	for i = 1:34
   	x(i,j) = fscanf( f1, '%f', 1 ) ; 
	end
	br = fscanf( f1, '%s', 1 ) ;
	if ( strcmp( br, 'b' ) == 1 )
		c(1,j) = 1 ;
	else
		c(1,j) = 2 ;
	end
end
fclose(f1) ;


