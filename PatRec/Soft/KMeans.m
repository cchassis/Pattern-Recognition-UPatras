function [Alphabet] = KMeans(Vector,KM,Threshold)
%#
%#  [Alphabet] = KMeans(Vectors,KM,Threshord)
%#
%#  Input
%#      Vector: Pattern Vectors
%#      KM: Size of the alphabet
%#      Threshold: Covergence threshold
%#  Output
%#      Alphabet: Vector alphabet 
%#

L = size(Vector) ;
N = L(1,1) ;
NumOfVect = columns(Vector) ;
if ( NumOfVect <= KM )
	printf( 'The size of the alphabet is greater than the number of the Vectors\n' ) ;
	return ;
end
Cluster = zeros(NumOfVect,1) ;
Alphabet = zeros(N,KM) ;
Error = 1.0E28 ;
prError = 1.0E30 ; 
for i=1:KM
	while( 1 )
		Alphabet(:,i) = Vector(:,floor(NumOfVect*rand(1,1))+1) ;
		Same = 0 ;
		for j=1:i-1
			if ( Alphabet(:,j) == Alphabet(:,i) )
				Same = 1 ;
				break ;
			end
		end
	if ( Same == 0 )
		break ;
	end
	end
end
while( (prError-Error)/Error > Threshold ) 
	prError = Error
	Error = 0.0 ;
	NewAlphabet = zeros(N,KM) ;
	Rep = zeros(KM,1) ;
	for i = 1:NumOfVect
		for j = 1:KM
			Dist(j) = (Vector(:,i) - Alphabet(:,j))' * ( Vector(:,i) - Alphabet(:,j) ) ;
		end
		[Md,Rec] = min(Dist) ;
		Error = Error + Md ;
		Cluster(i) = Rec ;
		Rep(Rec) = Rep(Rec)+1 ;
		NewAlphabet(:,Rec) = NewAlphabet(:,Rec) + Vector(:,i) ;
	end
	for i = 1:KM
		Alphabet(:,i) = NewAlphabet(:,i) / Rep(i) ;
	end
end
