function [Recs,Sums] = MlpEbp2L(x,c,Hid1Nodes,Hid2Nodes,Lr,Tr,Step)
%#
%#  [Recs,Sums] = MlpEbp2L(x,c,Hid1Nodes,Hid2Nodes,Lr,Tr,Step)
%#      Back-propagation of error. Two hidden layer
%#  Input
%#      x: Pattern Vectors
%#      c: Classes
%#      Hid1Nodes: Number of Hidden nodes in the 1st layer
%#      Hid2Nodes: Number of Hidden nodes in the 2nd layer
%#      Lr: Learning rates for each layer
%#      Tr: Training epoches
%#      Step: Classification accuracy and Estimation Error
%#            after "Step" training cycles
%#  Output
%#      Recs: Correct classification rate using the C-method
%#      Sums: Error Function

NumOfClass = max(c) ;
NumOfPatterns = columns(x) ;
Dimens = rows(x) ;
Rec = zeros( 1, Tr/Step+1) ;
Sums = zeros( 1, Tr/Step+1) ;
Hid1Weights = rand(Dimens,Hid1Nodes) - 0.5 ;
Out1Weights = rand( Hid1Nodes, Hid2Nodes ) - 0.5 ;
Hid1Out = 0.5 * ones( 1, Hid1Nodes ) ;
Hid1Delta = zeros( 1, Hid1Nodes) ;
Hid2Weights = rand(Hid1Nodes,Hid2Nodes) - 0.5 ;
OutWeights = rand( Hid2Nodes, NumOfClass ) - 0.5 ;
Hid2Out = 0.5 * ones( 1, Hid2Nodes ) ;
Hid2Delta = zeros( 1, Hid2Nodes) ;
Out = zeros( 1, NumOfClass ) ;
OutDelta = zeros( 1, NumOfClass ) ;
mr = 0 ;
for m = 0:Tr
	Nxv = floor(rand(1) * NumOfPatterns ) + 1 ;
	Xinp = x(:,Nxv)' ;
	for j = 1:Hid1Nodes
		Hid1Out(1,j) = 1 / ( exp(-(Xinp * Hid1Weights(:,j))) + 1 ) ;
	end
	for j = 1:Hid2Nodes
		Hid2Out(1,j) = 1 / ( exp(-(Hid1Out * Hid2Weights(:,j))) + 1 ) ;
	end
	for j = 1:NumOfClass
		Out(1,j) = 1 / ( exp(-(Hid2Out * OutWeights(:,j)) ) + 1 ) ;
	end
	Desired = zeros( 1, NumOfClass ) + 0.1 ;
	Desired(1,c(Nxv)) = 0.9 ;
	OutDelta = ( Desired - Out ) .* Out .* ( 1 - Out ) ;
	Hid2Delta = Hid2Out .* ( 1 - Hid2Out ) .* ( OutWeights * OutDelta' )' ;
	Hid1Delta = Hid1Out .* ( 1 - Hid1Out ) .* ( Hid2Weights * Hid2Delta' )' ;
	OutWeights = OutWeights + Lr(3) * Hid2Out' * OutDelta ;
	Hid2Weights = Hid2Weights + Lr(2) * Hid1Out' * Hid2Delta ;
	Hid1Weights = Hid1Weights + Lr(1) * Xinp' * Hid1Delta ;
	if( rem( m, Step ) == 0 )
		mr = mr + 1 ;
		Rc = zeros(NumOfClass,1) ;
		Sum = 0 ;
		for i = 1:NumOfPatterns
			k = c(i) ;
			Xinp = x(:,i)' ;
			for j = 1:Hid1Nodes
				Hid1Out(1,j) = 1 / ( exp(-(Xinp * Hid1Weights(:,j)) ) + 1 ) ;
			end
			for j = 1:Hid2Nodes
				Hid2Out(1,j) = 1 / ( exp(-(Hid1Out * Hid2Weights(:,j))) + 1 ) ;
			end
			for j = 1:NumOfClass
				Out(1,j) = 1 / ( exp(-(Hid2Out * OutWeights(:,j)) ) + 1 ) ;
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
