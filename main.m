%==========================================================
% Written for the task of Automatic Vehicle Licence Plate Recognition
% Yao Yeboah Junior - ECE2011
% South China University of Technology
%===========================================================

%main function
clc
clear all
close all



%%
%%-------------------loading the input Image------------------------------
[fn,pn,fi]=uigetfile('*.jpg','Please Chose a Picture');
I=imread([pn fn]);figure,imshow(I);title('Original Input Image');%We display the original Image
inputpath=[pn fn]
I_bai=I;
[PY2,PY1,PX2,PX1]=color_seg(I);
%%
[PY2,PY1,PX2,PX1,threshold]=SEC_modify(PY2,PY1,PX2,PX1); % Plate Recognition

Plate=I_bai(PY1:PY2,PX1:PX2,:); % Updated Image

bw=Plate;figure,imshow(bw);title('License Plate Image');

bw=rgb2gray(bw);figure,imshow(bw);title('Gray Scale Image');

%% 
%-------------------------- Correcting the Angle of Tilt-------------------
tilt=rando_change(bw)
bw=imrotate(bw,tilt,'bilinear','crop');figure,imshow(bw);title('Tilt Correction');% Tunring to the right value = negative
%%
bw=im2bw(bw,graythresh(bw));%figure,imshow(bw);
bw=bwmorph(bw,'hbreak',inf);%figure,imshow(bw);
bw=bwmorph(bw,'spur',inf);%figure,imshow(bw);title('Erased Before');
bw=bwmorph(bw,'open',5);%figure,imshow(bw);title('Closing Operator');
bw = bwareaopen(bw, threshold);figure,imshow(bw);title('Erase');

%----------------------------------------------------------------------
bw=~bw;figure,imshow(bw);title('Erase Reverse Colour'); 
%%
%----Further cropping the image to ensure that the border close to the font--
bw=projection(bw);figure;imshow(bw);title('Y Direction Processing');
bw=~bw;
bw = bwareaopen(bw, threshold);
bw=~bw;%figure,imshow(bw);title('Second Erasure');
[y,x]=size(bw);%Re-assignment on the length and width
%%
%---------------------Text Segmentation------------------------------
segment=digiseg(bw,tilt)
[m,k]=size(segment);
%-------------------Image Segmentation Results--------------------------- 
figure;
for s=1:2:k-1
    subplot(1,k/2,(s+1)/2);imshow(bw( 1:y,segment(s):segment(s+1)));
end

%=--------------------- Image Positioning--------------------------
cn_char  =bw( 1:y,segment(1):segment(2));
eng_letter   =bw( 1:y,segment(3):segment(4));
lt_ch_1 =bw( 1:y,segment(5):segment(6));
lt_ch_2 =bw( 1:y,segment(7):segment(8));  
num_1 =bw( 1:y,segment(9):segment(10)); 
num_2 =bw( 1:y,segment(11):segment(12)); 
num_3 =bw( 1:y,segment(13):segment(14)); 
%%
%-----------------------Identification----------------------------
modifycnword =   imresize(cn_char, [110 55],'bilinear');
modifycnletter  =   imresize(eng_letter,  [110 55],'bilinear');
modifycnletter_sz_1=  imresize(lt_ch_1,[110 55],'bilinear');
modifycnletter_sz_2 = imresize(lt_ch_2,[110 55],'bilinear');
modifynum_1 = imresize(num_1,[110 55],'bilinear');
modifynum_2 = imresize(num_2,[110 55],'bilinear');
modifynum_3 = imresize(num_3,[110 55],'bilinear');
%-------------------  0-9 , A-Z as well as provinces-----------------------
province=charead(imread('cpgui.bmp'),imread('cpguizhou.bmp'),imread('cpjing.bmp'),imread('cpsu.bmp'),imread('cpyue.bmp'));
%Minor Modification due to the ratio of letters to numbers.
letternum=letnumread(imread('0.bmp'),imread('1.bmp'),imread('2.bmp'),imread('3.bmp'),imread('4.bmp'),...
                   imread('5.bmp'),imread('6.bmp'),imread('7.bmp'),imread('8.bmp'),imread('9.bmp'),...
                   imread('10.bmp'),imread('11.bmp'),imread('12.bmp'),imread('13.bmp'),imread('14.bmp'),...
                   imread('15.bmp'),imread('16.bmp'),imread('17.bmp'),imread('18.bmp'),imread('19.bmp'),...
                   imread('20.bmp'),imread('21.bmp'),imread('22.bmp'),imread('23.bmp'),imread('24.bmp'),...
                   imread('25.bmp'),imread('26.bmp'),imread('27.bmp'),imread('28.bmp'),imread('29.bmp'),...
                   imread('30.bmp'),imread('31.bmp'),imread('32.bmp'),imread('33.bmp'));
letter  = readletter(imread('10.bmp'),imread('11.bmp'),imread('12.bmp'),imread('13.bmp'),imread('14.bmp'),...
                 imread('15.bmp'),imread('16.bmp'),imread('17.bmp'),imread('18.bmp'),imread('19.bmp'),...
                 imread('20.bmp'),imread('21.bmp'),imread('22.bmp'),imread('23.bmp'),imread('24.bmp'),...
                 imread('25.bmp'),imread('26.bmp'),imread('27.bmp'),imread('28.bmp'),imread('29.bmp'),...
                 imread('30.bmp'),imread('31.bmp'),imread('32.bmp'),imread('33.bmp'));
num = readnum(imread('0.bmp'),imread('1.bmp'),imread('2.bmp'),imread('3.bmp'),imread('4.bmp'),...
                 imread('5.bmp'),imread('6.bmp'),imread('7.bmp'),imread('8.bmp'),imread('9.bmp')); 
%%
%-------------------------------Recognition Results------------------------------------------ 
i=1;
charesult  = charec(province,modifycnword);recresult(1,i) =charesult;  i=i+1;
letresult   = letrec(letter,modifycnletter);           recresult(1,i) =letresult;   i=i+1;
let_num_res_1= letnum_rec(letternum,modifycnletter_sz_1);  recresult(1,i) =let_num_res_1;i=i+1;
let_num_res_2= letnum_rec(letternum,modifycnletter_sz_2);  recresult(1,i) =let_num_res_2;i=i+1;
numresult_1= numrec(num,modifynum_1);      recresult(1,i) =numresult_1;i=i+1;
numresult_2= numrec(num,modifynum_2);      recresult(1,i) =numresult_2;i=i+1;
numresult_3= numrec(num,modifynum_3);      recresult(1,i) =numresult_3;i=i+1;
%----------------------------Dialog box display----------------------------
recresult
msgbox(recresult,'VLP is:');
%---------------------------Write Results to Database----------------------
fid=fopen('Data.xls','a+');
fprintf(fid,'%s\r\n',recresult,datestr(now));
fclose(fid);


 















