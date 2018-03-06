function [x,c] = ReadLetter(Tot)
%#
%#  [x,c] = ReadLetter(Tot)
%#   Read the letter-recognition database stored in the file "letter-recognition.data"
%#  Input:
%#      Tot: Number of Patterns
%#  Output:
%#      x: Patterns matrix
%#      c: Classes integer

if ( Tot > 20000 )
   Tot = 20000 ;
end

f1 = fopen( '../DATA/letter-recognition.data', 'r' ) ;
x = zeros(16,Tot) ;
c = zeros(1,Tot) ;
for j = 1:Tot
	b1 = fscanf( f1, '%s', 1 ) ;
	for i = 1:16
   	x(i,j) = fscanf( f1, '%f', 1 ) ; 
	end
	c(1,j) = (b1 - ['A']) + 1 ;
end
fclose(f1) ;
