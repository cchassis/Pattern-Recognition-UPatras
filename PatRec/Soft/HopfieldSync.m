function [Rc,Rep] = HopfieldSync(Pr,x,c)
%#
%#  [Rc,Rep] = HopfieldSync(Pr,x,c)
%#         
%#  Input
%#      Pr: Prototypes Vectors
%#      x: Pattern Vectors for the first class
%#      c: Classes
%#  Output
%#      Rc: Correct classification rate using the C-method
%#      Rep: Pattern vectors on each class
%#

NumOfClass = columns(Pr) ;
NumOfPatterns = columns(x) ;
Dimens = rows(x) ;
if ( rows(Pr) ~= rows(x) )
	return ;
end
Weights = Pr * Pr' ;
for i = 1:Dimens
	Weights(i,i) = 0 ; 
end
Weights = Weights / NumOfPatterns ;

%#
%#  C-Error Synchronous mode
%#

Rc = zeros(NumOfClass,1) ;
Rep = zeros(NumOfClass,1) ;
for j = 1:NumOfPatterns
	k = c(j) ;
	Rep(k) = Rep(k) + 1 ;
	Out = x(:,j) ;
	while( 1 ) 	
		Inp = Out ;
		Out = Weights * Inp ;
		for i = 1:Dimens
			if ( Out(i) >= 0 )
				Out(i) = 1 ;
			else
				Out(i) = -1 ;
			end
		end
		if ( Inp == Out )
			break ;
		end
	end
	Rec = 0 ;
Out'
	for i = 1:NumOfClass
		if ( Pr(:,i) == Out )
			Rec = i ;
			break ;
		end
	end
	if ( Rec == k )
		Rc(Rec) = Rc(Rec) + 1 ;
	end
end
