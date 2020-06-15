clc;clear;close all;

group=[];
data=[];
count = 0;

addr = genpath('.');   % generate current path
addpath(addr);      % add current folders to search paths

folder=dir('.\dataset');

%%
for mn=3:length(folder)
    address=strcat('.\dataset\',folder(mn).name);
    files=dir(address);
    num=numel(files);
    disp(folder(mn).name);
    count = count + 1;
    
    for i=3:num
        
        disp(files(i).name);
        
        str=strcat('.\dataset\',folder(mn).name,'\',files(i).name);
        im=imread(str);
%         im = imresize(im,[512,512]);
        
%         imshow(im)
        cform = makecform('srgb2lab');
        J = applycform(im,cform);
%         figure;imshow(J);
        
        K=J(:,:,2);
%         figure;imshow(K);
        
        L=graythresh(J(:,:,2));
        BW1=im2bw(J(:,:,2),L);
        
%         figure(1);imshow(BW1);

        BW1=bwareaopen(BW1,500);
        BB=regionprops(BW1,'Boundingbox');

        pause(0.01)
        object = imcrop(BW1,BB(1).BoundingBox);
        
%          figure(2);imshow(object);
        
        object = imresize(object,[50,50]);
        
        [feat] = hog_feature_vector(object);
        
            
        group = [group ; count];
        data=[data ; feat];
    end
    
end
%%
save features data group