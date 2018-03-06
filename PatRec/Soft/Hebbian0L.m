function [Classif] = Hebbian0L(x,c,Repet,Alpha)
%#
%#  [Classif] = Hebbian0L(x,c,Repet,Alpha)
%#           Hebbian Learning method
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
Mi = sum(x')/NumOfPatterns ;

Classif = zeros( NumOfClass, NumOfClass ) ;
for j = 1:NumOfPatterns
	Dist = 1.0 ./ (exp( OutWeights' * x(:,j) ) + 1 ) ;
	Rec = ArgMax(Dist) ;
	Classif(c(j),Rec) = Classif(c(j),Rec) + 1 ;
end
Classif

for i = 1:Repet
	Out = 1.0 ./ (exp( OutWeights' * x ) + 1 ) ;
	Mo = sum(Out')/NumOfPatterns ;
	Moi = x * Out'/NumOfPatterns  ;
   OutWeights = OutWeights + (Alpha * (Moi - Mi' * Mo) ) ;
   
%#
%#  C-Error
%#

	Rc = zeros(NumOfClass,1) ;
	Classif = zeros( NumOfClass, NumOfClass ) ;
	for j = 1:NumOfPatterns
		Dist = 1.0 ./ (exp( OutWeights' * x(:,j) ) + 1 ) ;
		Rec = ArgMax(Dist) ;
		Classif(c(j),Rec) = Classif(c(j),Rec) + 1 ;
	end
	Classif
end
