clc;clear;close all;warning off all;

load features

imaqreset;

vid = videoinput('winvideo', 1, 'YUY2_640x480');
src = getselectedsource(vid);
vid.FramesPerTrigger = Inf;
vid.ReturnedColorspace = 'rgb';
start(vid);
preview(vid);

im = getsnapshot(vid);

cform = makecform('srgb2lab');
J = applycform(im,cform);
K=J(:,:,2);
L=graythresh(J(:,:,2));
BW1=im2bw(J(:,:,2),L);
BW1=bwareaopen(BW1,500);
BB=regionprops(BW1,'Boundingbox');
% pause(0.01)
object = imcrop(BW1,BB(1).BoundingBox);
 figure(2);imshow(object);
object = imresize(object,[50,50]);

[feat] = hog_feature_vector(object);
class = knnclassify(feat,data,group)

%import java.awt.Robot;
%robot = java.awt.Robot;
%import java.awt.event.KeyEvent;
%robot=Robot;

%robot.keyPress(KeyEvent.VK_ALT);        robot.keyPress(KeyEvent.VK_TAB);
%robot.keyRelease(KeyEvent.VK_TAB);      robot.keyRelease(KeyEvent.VK_ALT);
%pause(0.1)


switch class
    case 1
        j=1;
        set(handles.edit2,'String',num2str(j));
        disp('Right Click');
        %pause(0.1)
       % robot.keyPress(KeyEvent.VK_F5);    robot.keyRelease(KeyEvent.VK_F5);
       
        helpdlg('Right Click!');
    case 2
        
        disp('Sign of left');pause(0.1)
       % robot.keyPress(KeyEvent.VK_PAGE_UP);    robot.keyRelease(KeyEvent.VK_PAGE_UP);
        helpdlg('Sign of Left!');
    case 3
        
        disp('Sign of Right');pause(0.1)
        %robot.keyPress(KeyEvent.VK_PAGE_DOWN);    robot.keyRelease(KeyEvent.VK_PAGE_DOWN);
        helpdlg('Sign of Right!');
        
end

stop(vid);
imaqreset;