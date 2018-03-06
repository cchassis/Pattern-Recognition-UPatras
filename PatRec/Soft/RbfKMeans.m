function [Rc,Rep] = RbfKMeans(x,c,HidNodes)
%#
%#  [Rc,Rep] = RbfKMeans(x,c,HidNodes)
%#           Kmeans alphabet for the Weights in the first Layer
%#  Input
%#      x: Pattern Vectors 
%#      c: Classes
%#      HidNodes: Number of Hidden nodes
%#  Output
%#      Rc: Correct classification rate using the C-method
%#      Rep: Pattern vectors on each class
%#

NumOfClass = max(c) ;
L = size(x) ;
NumOfPatterns = L(1,2) ;
HidWeights = KMeans(x,HidNodes,0.001);
Rep = zeros(NumOfClass,1) ;
G = zeros(NumOfPatterns,HidNodes) ;

%#
%#  C-Error
%#

for i = 1:HidNodes
	for j = 1:NumOfPatterns
		G(j,i) = 1 / ( sum(abs( HidWeights(:,i) - x(:,j))) + 1 ) ;
	end
end
A = inv(G' * G) * G' ;
OutWeights = zeros( HidNodes, 0 ) ;
for i = 1:NumOfClass
	for j = 1:NumOfPatterns
		if ( c(j) == i )
			b(j) = 1 ;
		else
			b(j) = 0 ;
		end
	end
	OutWeights = [ OutWeights, A * b' ] ; 
end

Rc = zeros(NumOfClass,1) ;
for j = 1:NumOfPatterns
	k = c(j) ;
	Rep(k,1) = Rep(k,1) + 1 ;
	for i = 1:HidNodes
		Ho(i) = 1 / ( sum(abs( HidWeights(:,i) - x(:,j))) + 1 ) ;
	end
	Dist = Ho * OutWeights ;
	Rec = ArgMax(Dist) ;
	if (Rec == k )
		Rc(Rec) = Rc(Rec) + 1 ;
	end
end
