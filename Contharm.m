%% Assignment # 3 & 4
% DIP @ c@se Fall 2006
% Contra Harmonic Mean Filter

%% Program Initializations
clc
close all
clear all

%% Reading an Image and making basic maniulations
%data=imread('cameraman.tif');
data=imread('WithSaltAndPepper.jpg');
figure,imshow(data);
%data=rgb2gray(data);
data=im2double(data);

% Filter takes double the size of mask
masksize=3;

% Order of the filter
Q=2;
sumn=[];
sumd=[];
figure(1),imshow(data),title('raw image')
pixln=0;
pixld=0;
[ro col]=size(data);

%% Main Module for Contra Harmonic Mean Filter
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
       reformedimage(i,j)=(pixln/pixld);
       pixln=0;
       pixld=0;
    end
end

figure(2),imshow(reformedimage),title('refoemed image')
