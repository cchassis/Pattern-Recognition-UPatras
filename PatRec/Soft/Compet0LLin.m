function [Classif] = Compet0LLin(x,c,Repet,Alpha)
%#
%#  [Classif] = Compet0LLin(x,c,Repet,Alpha)
%#           Competitive Learning method (Sum of weights equal one)
%#  Input
%#      x: Pattern Vectors
%#      c: Classes
%#      HidNodes: Number of Hidden nodes
%#      Repet: number of training repetitions
%#      Alpha: Learning rate
%#  Output
%#      Classif: Classification rate using the C-method
%#

NumOfClass = max(c) ;
NumOfPatterns = columns(x) ;
x = [ x ; ones(1,NumOfPatterns) ] ;
Dimens = rows(x) ;
OutWeights = rand(Dimens,NumOfClass) - 0.5 ;
Norm = sum( OutWeights ) ;
for i=1:NumOfClass
	OutWeights(:,i) = OutWeights(:,i) / Norm(i) ;
end

%#
%#  C-Error
%#

Classif = zeros( NumOfClass, NumOfClass ) ;
for j = 1:NumOfPatterns
	Dist = 1.0 ./ (exp( OutWeights' * x(:,j) ) + 1 ) ;
	Rec = ArgMax(Dist) ;
	Classif(c(j),Rec) = Classif(c(j),Rec) + 1 ;
end
Classif

for i = 1:Repet
	Pat = floor( rand(1) * NumOfPatterns ) + 1 
	Out = 1.0 ./ (exp( OutWeights' * x(:,Pat) ) + 1 ) ;
	Win = ArgMax(Out) ;
	OutWeights(:,Win) = OutWeights(:,Win) + Alpha * (x(:,Pat) - OutWeights(:,Win) ) ;
	Norm = sum( OutWeights(:,Win) ) ;
	OutWeights(:,Win) = OutWeights(:,Win) / Norm ;
   
%#
%#  C-Error
%#

	Classif = zeros( NumOfClass, NumOfClass ) ;
	for j = 1:NumOfPatterns
		Dist = 1.0 ./ (exp( OutWeights' * x(:,j) ) + 1 ) ;
		Rec = ArgMax(Dist) ;
		Classif(c(j),Rec) = Classif(c(j),Rec) + 1 ;
	end
	Classif
end
