function [h]=histogram(f);
 [xmax,ymax]=size(f);
 h=zeros(1,256);
 for x=1:xmax
    for y=1:ymax
        color=double(f(x,y));
        h(color+1)=h(color+1)+1;
    end;
 end;

