function [Res] = ArgMin(x)
%#
%#  Res = ArgMin(x)
%#  Return the POSITION of the minimum value 
%#

Num = length(x) ;
Res = 1 ;
MinNum = x(1) ;
for i = 1:Num
    if (x(i) < MinNum)
       MinNum = x(i) ;
       Res = i ;
    end ;
end ;
