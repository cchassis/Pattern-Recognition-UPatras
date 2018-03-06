function [Rc,Rep] = HopfieldAsync(Pr,x,c)
%#
%#  [Rc,Rep] = HopfieldAsync(Pr,x,c)
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
Rr= 3 * Dimens ;
if ( rows(Pr) ~= rows(x) )
	return ;
end
Weights = Pr * Pr' ;
for i = 1:Dimens
	Weights(i,i) = 0 ; 
end
Weights = Weights / NumOfPatterns ;

%#
%#  C-Error Asynchronous mode
%#

Rc = zeros(NumOfClass,1) ;
Rep = zeros(NumOfClass,1) ;
for j = 1:NumOfPatterns
	k = c(j) ;
	Rep(k) = Rep(k) + 1 ;
	Out = x(:,j) ;
	Inp = Out ;
	while( 1 )
		Ag = 0 ;
		for i = 1:Rr
			d = floor( rand() * Dimens ) + 1 ;
			Out(d) = Weights(d,:) * Inp ;
			if ( Out(d) >= 0 )
				Out(d) = 1 ;
			else
				Out(d) = -1 ;
			end
			if ( Inp(d) ~= Out(d) )
				Inp(d) = Out(d) ;
				Ag = 1 ;
			end
		end
		if ( Ag == 1 )
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
