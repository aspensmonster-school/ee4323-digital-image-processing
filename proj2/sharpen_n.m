% Holy shitballs this function is slow. Like, taking 30 seconds to complete  
% slow. I ought to look into that. 
 
function [g]=sharpen_n(f,n) 
[height width]=size(f); 
g=f; 
for row=1:height 
    for col=1:width 
        startrow=max(row-n,1); 
        endrow=min(row+n,height); 
        startcol=max(col-n,1); 
        endcol=min(col+n,width); 
        summation=0;
        for i=startrow:endrow
          for j=startcol:endcol
            summation=summation+(-1*f(i,j));
          end
        end
        summation=summation-(-1*f(ceil(endrow-startrow),ceil(endcol-startcol)));
        summation=summation+(8*f(ceil(endrow-startrow),ceil(endcol-startcol)));
        g(row,col)=((summation)/(n^2)); 
%        g(row,col)=mean(mean(f(startrow:endrow,startcol:endcol))); 
    end 
end 
