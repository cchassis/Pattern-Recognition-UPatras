function [Recs,Sums] = MlpEbp1L(x,c,HidNodes,Lr,Tr,Step)

NumOfClass = max(c) ;
NumOfPatterns = columns(x) ;
Dimens = rows(x) ;
Rec = zeros( 1, floor(Tr/Step+1)) ;
Sums = zeros( 1, floor(Tr/Step+1)) ;
HidWeights = rand(Dimens,HidNodes) - 0.5 ;
OutWeights = rand( HidNodes, NumOfClass ) - 0.5 ;
HidOut = 0.5 * ones( 1, HidNodes ) ;
HidDelta = zeros( 1, HidNodes) ;
Out = zeros( 1, NumOfClass ) ;
OutDelta = zeros( 1, NumOfClass ) ;
mr = 0 ;
for m = 0:Tr
	Nxv = floor(rand(1) * NumOfPatterns ) + 1 ;
	Xinp = x(:,Nxv)' ;
	for j = 1:HidNodes
		HidOut(1,j) = 1 / ( exp(-(Xinp * HidWeights(:,j))) + 1 ) ;
	end
	for j = 1:NumOfClass
		Out(1,j) = 1 / ( exp(-(HidOut * OutWeights(:,j)) ) + 1 ) ;
	end
	Desired = zeros( 1, NumOfClass ) + 0.1 ;
	Desired(1,c(Nxv)) = 0.9 ;
	OutDelta = ( Desired - Out ) .* Out .* ( 1 - Out ) ;
	HidDelta = HidOut .* ( 1 - HidOut ) .* ( OutWeights * OutDelta' )' ;
	OutWeights = OutWeights + Lr * HidOut' * OutDelta ;
	HidWeights = HidWeights + Lr * Xinp' * HidDelta ;
	if( rem( m, Step ) == 0 )
		mr = mr + 1 ;
		Rc = zeros(NumOfClass,1) ;
		Sum = 0 ;
		for i = 1:NumOfPatterns
			k = c(i) ;
			Xinp = x(:,i)' ;
			for j = 1:HidNodes
				HidOut(1,j) = 1 / ( exp(-(Xinp * HidWeights(:,j)) ) + 1 ) ;
			end
			for j = 1:NumOfClass
				Out(1,j) = 1 / ( exp(-(HidOut * OutWeights(:,j)) ) + 1 ) ;
			end
			for j = 1:NumOfClass
				if ( k == j )
					Sum = Sum + ( 0.9 - Out(1,j) )^2 ;
				else
					Sum = Sum + ( Out(1,j) - 0.1 )^2 ;
				end
			end
			Rec = ArgMax(Out) ;
			if (Rec == k )
				Rc(Rec) = Rc(Rec) + 1 ;
			end
		end
	Sums(1,mr) = Sum ;
	TotRec = sum(Rc') ;
   Recs(1,mr) = 100.0 * TotRec / NumOfPatterns ;
	if ( TotRec == NumOfPatterns )
		return ;
	end
	end
end