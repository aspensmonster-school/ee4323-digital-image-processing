% Holy shitballs this function is slow. Like, taking 30 seconds to complete  
% slow. I ought to look into that. 
 
function [g]=smooth_n(f,n) 
[height width]=size(f); 
g=f; 
for row=1:height 
    for col=1:width 
        startrow=max(row-n,1); 
        endrow=min(row+n,height); 
        startcol=max(col-n,1); 
        endcol=min(col+n,width); 
        g(row,col)=mean(mean(f(startrow:endrow,startcol:endcol))); 
    end 
end 
