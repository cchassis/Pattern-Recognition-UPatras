function [x,c] = ReadIris(Tot)

if ( Tot > 150 )
   Tot = 150 ;
end
f1 = fopen( '..\DATA\iris.data', 'r' ) ;
x = zeros(4,Tot) ;
c = zeros(1,Tot) ;
for i = 1:Tot
   x(1,i) = fscanf( f1, '%f', 1 ) ;
   x(2,i) = fscanf( f1, '%f', 1 ) ;
   x(3,i) = fscanf( f1, '%f', 1 ) ;
   x(4,i) = fscanf( f1, '%f', 1 ) ;
   c(1,i) = fscanf( f1, '%d', 1 ) ;
	c(1,i) = c(1,i) + 1 ;
end
fclose(f1) ;