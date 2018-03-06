function w = HoKaOrg( z, ir )
%#     [Rc,Rep] = HoKaOrg( x1,x2, ir )
%#
%# z: Pattern Array     ir: Algorithm Repetitions
%#
%# This function estimates the weights of a two classes linear classifier
%# by using the Ho Kasyap algorithm

Nv = rows(z) ;
Np = columns(z) ;
b = 0.1 * rand( Np, 1 ) ;
piz = pinv(z') ;
w = piz * b ;
b1 = z' * w ;
e = b1 - b ;
i = 0 ;
while( i < ir )
  printf( 'Step %d\n', i ) ;
  printf( 'Classification Score: %7.4f%%\n', ( 100 * NoGreatValMat( b1, 0.0 ) ) / ( rows(b1) * columns(b1)) ) ;
  if ( GreatValMat(b1,0.0) == 1 )
     printf( 'Linear Separation of classes in %d repetitions\n', i ) ;
     return ;
  end
  ea = AbsMat(e) ;
  b = b + 0.5 * ( e + ea ) ;
  w = piz * b ;
  b1 = z' * w ;
  e = b1 - b ;
  i++ ;
end
printf( 'Original Ho-Kasyap not convergence in %d repetitions\n', i ) ;
printf( 'Classification Score: %7.4f%%\n', ( 100 * NoGreatValMat( b1, 0.0 ) ) / ( rows(b1) * columns(b1)) ) ;
