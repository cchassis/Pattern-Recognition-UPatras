function [Rc,Ru,Rep] = Wiener(x1,x2)
%#
%#  [Rc,Ru,Rep] = Wiener(x1,x2)
%#
%#  Input
%#      x1: Pattern Vectors for the first class
%#      x2: Pattern Vectors for the second class
%#  Output
%#      Rc: Correct classification rate using the C-method
%#      Ru: Correct classification rate using the U-method
%#      Rep: Pattern vectors on each class
%#

NumOfP1 = columns(x1) ;
NumOfP2 = columns(x2) ;
Rep = [NumOfP1,NumOfP2] ;
TotPat = sum(Rep) ;
Rc = zeros(2,1) ;
Ru = zeros(2,1) ;
if ( rows(x1) ~= rows(x2) )
	printf( 'Error in vectors x1, x2\n' ) ;
end
x1 = [x1;ones(1,NumOfP1)] ;  
x2 = [x2;ones(1,NumOfP2)] ;  

%#
%#  C-Error
%#
d1 = ones(NumOfP1,1) ;
d2 = zeros(NumOfP2,1) ;
d = [d1;d2] ;
x = [x1,x2] ;
A = x * x' ;
B = x * d ;
Weights = A \ B ;
for i=1:NumOfP1
	if ( Weights' * x1(:,i) >= 0.5 )
		Rc(1) = Rc(1) + 1 ;
	end
end
for i=1:NumOfP2
	if ( Weights' * x2(:,i) < 0.5 )
		Rc(2) = Rc(2) + 1 ;
	end
end

%#
%#  U-Error
%#
d1 = ones(NumOfP1-1,1) ;
d2 = zeros(NumOfP2,1) ;
d = [d1;d2] ;
for k = 1:NumOfP1
	x = [x1(:,1:k-1),x1(:,k+1:NumOfP1),x2] ;
	A = x * x' ;
	B = x * d ;
	Weights = A \ B ;
	if ( Weights' * x1(:,k) >= 0.5 )
		Ru(1) = Ru(1) + 1 ;
	end
end
d1 = ones(NumOfP1,1) ;
d2 = zeros(NumOfP2-1,1) ;
d = [d1;d2] ;
for k=1:NumOfP2
	x = [x1,x2(:,1:k-1),x2(:,k+1:NumOfP2)] ;
	A = x * x' ;
	B = x * d ;
	Weights = A \ B ;
	if ( Weights' * x2(:,k) < 0.5 )
		Ru(2) = Ru(2) + 1 ;
	end
end
