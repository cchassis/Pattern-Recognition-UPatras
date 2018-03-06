function [Rc,Rep] = HoKa(x1,x2,Lr,MaxRep)
%#
%#  [Rc,Rep] = HoKa(x1,x2,Lr,MaxRep)
%#
%#  Input
%#      x1: Pattern Vectors for the first class
%#      x2: Pattern Vectors for the second class
%#      Lr: Learning rate
%#      MaxRep: Maximum repetitions
%#  Output
%#      Rc: Correct classification rate using the C-method
%#      Rep: Pattern vectors on each class
%#

NumOfP1 = columns(x1) ;
x1 = [x1;ones(1,NumOfP1)] ;
NumOfP2 = columns(x2) ;
x2 = [x2;ones(1,NumOfP2)] ;
Rep = [NumOfP1,NumOfP2] ;
TotPat = sum(Rep) ;
Rc = zeros(2,1) ;

if ( rows(x1) ~= rows(x2) )
	printf( 'Error in vectors x1, x2\n' ) ;
end

z = [x1,-x2]'; 

Nv = columns(z) ;
Np = rows(z) ;
b = 0.1 * rand( Np, 1 ) ;
piz = inv( z' * z ) * z' ;
w = piz * b ;
b1 = z * w ; 
e = b1 - b ;
i = 0 ;
while( i < MaxRep )
  printf( 'Step %d\n', i ) ;
  printf( 'Classification Score: %7.4f%%\n', ( 100 * NoGreatValMat( b1, 0.0 ) ) / ( rows(b1) * columns(b1)) ) ;
  if ( GreatValMat(b1,0.0) == 1 )
     printf( 'Linear Separation of classes in %d repetitions\n', i ) ;
     Rc = Rep ;
     return ;
  end
  ea = AbsMat(e) ;
  b = b + Lr * ( e + ea ) ;
  w = piz * b ;
  b1 = z * w ;
  e = b1 - b ;
  i++ ;
end
 printf( 'Original Ho-Kasyap not convergence in %d repetitions\n', i ) ;
 printf( 'Classification Score: %7.4f%%\n', ( 100 * NoGreatValMat( b1, 0.0 ) ) / ( rows(b1) * columns(b1)) ) ;
Rc(1) = NoGreatValMat( b1(1:NumOfP1), 0.0 )  ;
Rc(2) = NoGreatValMat( b1(NumOfP1+1:TotPat), 0.0 )  ;
