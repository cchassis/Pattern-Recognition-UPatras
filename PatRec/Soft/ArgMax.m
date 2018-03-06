function [Res] = ArgMax(x)
Num = length(x) ;
Res = 1 ;
MaxNum = x(1) ;
for i = 1:Num
    if (x(i) > MaxNum)
       MaxNum = x(i) ;
       Res = i ;
    end ;
end ;