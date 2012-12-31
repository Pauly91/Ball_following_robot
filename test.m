clf
close all
imaqreset
delete(instrfindall)
se=strel('disk',3);
vid=videoinput('winvideo',1,'RGB24_160x120');
triggerconfig(vid, 'manual');
set(vid,'FramesPerTrigger',1 );
set(vid,'TriggerRepeat', inf);
S = serial('COM3');
set(S,'BaudRate', 9600, 'DataBits', 8, 'Parity', 'none','StopBits', 1, 'FlowControl', 'none'); 
fopen(S);
preview(vid)
pause(7);
start(vid);
trigger(vid);
im=getdata(vid,1);
flushdata(vid);
[m,n,t]=size(im);
I=zeros(m,n);
while(1)
    trigger(vid);
    im=getdata(vid,1);
    flushdata(vid);
    im = rgb2hsv(im); 
    H=im(:,:,1);R=im(:,:,2);
    %I=((H<=0.99)&(H>=0.91));
    I=((H<=0.01)&(H>=0.00));%&(R>=0.60)&(R<=0.75);
    clear H
    clear im
    I=imclose(I,se);
    I=imfill(I,'holes');
    I=imopen(I,se);
    imshow(I)
    CC = bwconncomp(I,8); 
    if CC.NumObjects~=0
        info=regionprops(CC, 'Centroid','Area','Perimeter');
        for i=1:(CC.NumObjects)            
                    if ((info(i).Area)>400&&((4*pi)*info(i).Area)/(info(i).Perimeter)^2>0.4)
                        x=info(i).Centroid(1);
                        y=info(i).Centroid(2);  
                        info(i).Area;
                        hold on
                        x=floor(x);
                        y=floor(y);
                        A=floor(info(i).Area);
                        text(x, y, sprintf('x=%d,y=%d,A=%d',x,y,A ),'BackgroundColor',[.5 .5 .5], 'Units', 'data')
                        plot(x,y, 'r.');
                        hold off 
                        if(x>65&&x<95)
                              x=1;
                        end 
                        if(x>=2&&x<=7)
                            x=8;
                        end
                        x
                        fwrite(S,x); 
                        break
                    elseif((info(i).Area)<400&&(info(i).Area)>100&&((4*pi)*info(i).Area)/(info(i).Perimeter)^2>0.4)
                        x=1 
                        fwrite(S,x);                      
                    else
                        x=0
                        fwrite(S,x);
                    end
        end
    else
        x=0
        fwrite(S,x);
    end
   clear CC
   clear info
end


     