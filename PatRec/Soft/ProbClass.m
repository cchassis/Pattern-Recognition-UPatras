function [Rc,Rep] = ProbClass(x,c,Np,Nint)
%#
%#  [Rc,Rep] = ProbClass(x,c,Np,Nint)
%#  Stochastic Pattern Recognition: 
%#
%#  Input
%#      x: Pattern Vectors
%#      c: Classes
%#      Np: Number of partitions
%#      Nint: Number of partitions for the integral computations
%#  Output
%#      Rc: Correct classification rate using the C-method
%#      Rep: Pattern vectors on each class
%#

NumOfClass = max(c) ;
NumOfPatterns = columns(x) ;
Dimens = rows(x) ;
Rep = zeros(NumOfClass,1) ;
Err = zeros(Dimens,5) ;
Best = zeros(Dimens,1) ;
for i = 1:NumOfPatterns
	Rep(c(i)) = Rep(c(i)) + 1 ;
end

%#
%#  Probability density function selection
%#	for each feature separately
%#

for d=1:Dimens
	x1 = x(d,:) ;
		for j=1:NumOfClass
			xc = SeparateClass(x1,c,j);
			Err(d,1) = Err(d,1) + ChiSquareLap(xc,Np,Nint) ;
		end
		for j=1:NumOfClass
			xc = SeparateClass(x1,c,j);
			Err(d,2) = Err(d,2) + ChiSquareLogNor(xc,Np,Nint) ;
		end
		for j=1:NumOfClass
			xc = SeparateClass(x1,c,j);
			Err(d,3) = Err(d,3) + ChiSquareNor(xc,Np,Nint) ;
		end
		for j=1:NumOfClass
			xc = SeparateClass(x1,c,j);
			Err(d,4) = Err(d,4) + ChiSquareRay(xc,Np,Nint) ;
		end
		for j=1:NumOfClass
			xc = SeparateClass(x1,c,j);
			Err(d,5) = Err(d,5) + ChiSquareUni(xc,Np) ;
		end
	end
for d=1:Dimens
	xc = Err(d,:) ;
	Best(d) = ArgMin(xc) ;
   if ( Best(d) == 1 )
      Messg = sprintf( 'Dim %d: Pdf Laplace\n', d ) ;
		display( Messg ) ;
	elseif ( Best(d) == 2 ) 
      Messg = sprintf( 'Dim %d: Pdf Log-Normal\n', d ) ;
		display( Messg ) ;
   elseif ( Best(d) == 3 )
      Messg = sprintf( 'Dim %d: Pdf Gaussian (Normal)\n', d ) ;
		display( Messg ) ;
   elseif ( Best(d) == 4 )
      Messg = sprintf( 'Dim %d: Pdf Rayleigh\n', d ) ;
		display( Messg ) ;
	else
      Messg = sprintf( 'Dim %d: Pdf Uniform\n', d ) ;
		display( Messg ) ;
 	end
end

Mean = zeros( Dimens, NumOfClass ) ;
Var = zeros( Dimens, NumOfClass ) ;
for j=1:NumOfClass
	xc = SeparateClass(x,c,j) ;
	[Mean(:,j),Var(:,j)]=MeanVarCol(xc) ;
end

Rc = zeros(NumOfClass,1) ;
for i=1:NumOfPatterns
	Pr = zeros(NumOfClass,1) ;
	for j=1:NumOfClass
		for d=1:Dimens
			if ( Best(d) == 1 )
				b = sqrt( 2 / Var(d,j) ) ;
				C1 = b / 2 ;
				C2 = -b ;
				Pr(j) = Pr(j) - log( C1 * exp( C2 * abs( x(d,i) - Mean(d,j) ) )) ;
			elseif ( Best(d) == 2 )
				a = 0.5 * ( log( Var(d,j) / ( exp(Var(d,j)) - 1 ) ) - Var(d,j) ) ;
				b = Mean(d,j) - exp( a + Var(d,j) / 2 ) ;
				C1 = 1 / sqrt( Var(d,j) * 2 * pi ) ;
				C2 = -1 / ( 2 * Var(d,j) ) ;
				if ( x(d,i) < b )
					Pr(j) = Pr(j) + 10000000 ;
				else
					xb = ( x(d,i) - b ) ;
					Pr(j) = Pr(j) - log(C1 * exp( C2 * (log(xb)-a) ) / xb) ;
				end
			elseif ( Best(d) == 3 )
				C1 = 1 / sqrt( pi * 2 * Var(d,j) ) ;
				C2 = -1 / ( 2 * Var(d,j) ) ;
				xa = x(d,i) - Mean(d,j) ;
				xb = xa * xa ;
				Pr(j) = Pr(j) - log(C1 * exp( C2 * xb )) ;
			elseif ( Best(d) == 4 )
				a = Mean(d,j) - sqrt( pi * Var(d,j) / ( 4 - pi ) ) ;
				b = 4 * Var(d,j) / ( 4 - pi ) ;
				C1 = 2 / b ;
				C2 = -1 / ( 2 * Var(d,j) ) ;
				if ( x(d,i) < a )
					Pr(j) = Pr(j) + 1000000 ;
				else
					xa = x(d,i) - a ;
					xb = xa * xa ;
					Pr(j) = Pr(j) - log( C1 * xa * exp( C2 * xb ) ) ;
				end
			else
				a = Mean(d,j) - sqrt( Var(d,j) * 3 ) ;
				b = Mean(d,j) + sqrt( Var(d,j) * 3 ) ;
				if ( x(d,i) < a )
					Pr(j) = Pr(j) + 10000000 ;
				elseif ( x(d,i) < b )
					Pr(j) = Pr(j) - log( 1 / ( b - a ) ) ;
				else
					Pr(j) = Pr(j) + 10000000 ;
				end
			end
		end
	end
	Rec = ArgMin(Pr) ;
	if ( Rec == c(i) )
		Rc(Rec) = Rc(Rec) + 1 ;
	end
end
