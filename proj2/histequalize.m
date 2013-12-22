function [g]=histequalize(f)
h=histogram(f);
[height,width]=size(f);
newcolors=zeros(1,256);
for k=1:256
    for j=1:k
        newcolors(k)=newcolors(k)+h(j);
    end
end
newcolors=255*newcolors/(height*width);
newcolors=uint8(newcolors);
g=zeros(height,width);
for r=1:height
    for c=1:width
        oldcolor=double(f(r,c));
        g(r,c)=newcolors(oldcolor+1);
    end
end
g=uint8(g);

