function [Rc,Ru,Rep] = ClassKMDistEucl(x,c,KN)
%#
%#  [Rc,Ru,Rep] = ClassKMDistEucl(x,c,KN)
%#  Pattern Recognition: 
%#      Distance measure:      Euclidian
%#      Prototypes:            K-prototypes K-MEANS
%#      Classification rule:   Minimum Distance
%#
%#  Input
%#      x: Pattern Vectors
%#      c: Classes
%#      KN: Number of protpotypes
%#  Output
%#      Rc: Correct classification rate using the C-method
%#      Ru: Correct classification rate using the U-method
%#      Rep: Pattern vectors on each class
%#

NumOfClass = max(c) ;
NumOfPatterns = columns(x) ;
Rep = zeros(NumOfClass,1) ;
Prot = zeros(4,0) ;

%#
%#  C-Error
%#

for j = 1:NumOfPatterns
	k = c(j) ;
	Rep(k) = Rep(k) + 1 ;
end

for i=1:NumOfClass
	Pat = zeros(4,0) ;
	for j = 1:NumOfPatterns
		k = c(j) ;
		if ( k == i )
			Pat = [ Pat, x(:,j) ] ;
		end
	end
	Prot = [ Prot, KMeans(Pat,KN,0.0001) ] ;
end
NoProt = columns(Prot) ;

Rc = zeros(NumOfClass,1) ;
for i = 1:NumOfPatterns
    for j = 1:NoProt
        Dist(j) = (x(:,i) - Prot(:,j))' * ( x(:,i) - Prot(:,j) ) ;
    end
    Rec = ceil(ArgMin(Dist)/KN) ;
    if (Rec == c(i))
       Rc(Rec) = Rc(Rec) + 1 ;
    end
end

%#
%#  U-Error
%#

Ru = zeros(NumOfClass,1) ;
OrgProt = Prot ;
for i = 1:NumOfPatterns
	One = c(i) ;
	Pat = zeros(4,0) ;
	for j = 1:NumOfPatterns
		k = c(j) ;
		if ( k == One & j ~= i )
			Pat = [ Pat, x(:,j) ] ;
		end
	end
	NewProt = KMeans(Pat,KN,0.0001) ;
	if ( One == 1 )
		Prot = [ NewProt, OrgProt(:,One*KN+1:NumOfClass*KN) ] ;
	elseif ( One == NumOfClass )
		Prot = [ OrgProt(:,1:(One-1)*KN), NewProt ] ;
	else
		Prot = [ OrgProt(:,1:(One-1)*KN), NewProt, OrgProt(:,One*KN+1:NumOfClass*KN) ] ;
	end
    for j = 1:NoProt
        Dist(j) = (x(:,i) - Prot(:,j))' * ( x(:,i) - Prot(:,j) ) ;
    end
    Rec = ceil(ArgMin(Dist)/KN) ;
    if (Rec == One )
       Ru(Rec) = Ru(Rec) + 1 ;
    end
end
