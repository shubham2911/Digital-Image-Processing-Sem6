clc
close all
clear all

data=imread('try.jpg');
subplot(2,3,1), imshow(data)
data = rgb2gray(data);
subplot(2,3,2), imshow(data)
data = imnoise(data,'salt & pepper',0.01);
subplot(2,3,3), imshow(data)
data=im2double(data);

masksize=1;

%removing pepper noise
Q=1;
sumn=[];
sumd=[];
pixln=0;
pixld=0;
[ro, col]=size(data);

for i=1:ro;
    for j=1:col;
        for m=-masksize:masksize;
            for n=-masksize:masksize;
                if (i+m>0 && i+m<ro && j+n>0 && j+n<col && ...      % To keep indices in limit
                        masksize+m>0 && masksize+m<ro && ...
                        masksize+n>0 && masksize+n<col) 
                    
                    pixl1=(data(i+m,j+n)).^(Q+1);                   % Application of Formula
                    pixl2= (data(i+m,j+n)).^Q;
                    pixln=pixln+pixl1;                              % Application of Summation
                    pixld=pixld+pixl2;
                
                end
            end
        end
       reformedimage1(i,j)=(pixln/pixld);
       pixln=0;
       pixld=0;
    end
end

subplot(2,3,4), imshow(reformedimage1)

%removing salt noise
masksize=2;

Q=-2;
sumn=[];
sumd=[];
pixln=0;
pixld=0;
[ro, col]=size(data);

for i=1:ro;
    for j=1:col;
        for m=-masksize:masksize;
            for n=-masksize:masksize;
                if (i+m>0 && i+m<ro && j+n>0 && j+n<col && ...      % To keep indices in limit
                        masksize+m>0 && masksize+m<ro && ...
                        masksize+n>0 && masksize+n<col) 
                    
                    pixl1=(reformedimage1(i+m,j+n)).^(Q+1);                   % Application of Formula
                    pixl2= (reformedimage1(i+m,j+n)).^Q;
                    pixln=pixln+pixl1;                              % Application of Summation
                    pixld=pixld+pixl2;
                
                end
            end
        end
       reformedimage2(i,j)=(pixln/pixld);
       pixln=0;
       pixld=0;
    end
end
subplot(2,3,5), imshow(reformedimage2)

%alphatrimmed filter
masksize=2;

% Specifications of the filter
d=4;
figure,imshow(data)
[ro,col]=size(data);
temp1=[];
summ=[];


for i=1:ro;
    for j=1:col;
        for m=-masksize:masksize;
            for n=-masksize:masksize;
                if (i+m>0 && i+m<ro && j+n>0 && j+n<col && ...      % To keep indices in limit
                        masksize+m>0 && masksize+m<ro && ...
                        masksize+n>0 && masksize+n<col) 
                    
                    temp1=[temp1 data(i+m,j+n)];
                                    
                end
            end
        end
         
        temp1=sort(temp1);
        lenth=length(temp1);
        for k=((d/2)-1):(lenth-(d/2))
            summ=[summ temp1(k)];
        end
        summ=sum(summ);
        reformedimage3(i,j)=(summ) / (25-d);
        
        summ=[];
        temp1=[];
        
    end
end

figure,imshow(reformedimage3)
