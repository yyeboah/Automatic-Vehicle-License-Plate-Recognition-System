function [PY2,PY1,PX2,PX1]=caitu_fenge(I)
[y,x,z]=size(I);
myI=double(I);
Y_threshlow=5;
X_firrectify=5;%ganrao transaction
%====================== Y ============================
Blue_y=zeros(y,1);
for i=1:y
    for j=1:x
       %if (myI(i,j,1)<=48)&&(myI(i,j,2)>=40)&&(myI(i,j,2)<=90)&&(myI(i,j,3)<=220)&&(myI(i,j,3)>=80)    
        if((myI(i,j,1)<=48)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=200)&&(myI(i,j,3)>=80)))  
        %if ((myI(i,j,1)<=0.7)&&(myI(i,j,1)>=0.6)&&((myI(i,j,2)<=1.8)&&(myI(i,j,2)>=0.6))&&((myI(i,j,3)<=1.7)&&(myI(i,j,3)>=0.45)))
           Blue_y(i,1)= Blue_y(i,1)+1;     %                   
        end  
    end       
end
baisebili=0;changkuanbi=0;
k=0;
while(~((baisebili>=0.12)&&(baisebili<=0.5)&&(changkuanbi>=0.20)&&(changkuanbi<=0.6)))
    if  (k==0)
        [temp MaxY]=max(Blue_y);
        if temp<=20
           msgbox('Fatal Detection Error','warning');
          
           pause;
        end
        PY1=MaxY;
        while ((Blue_y(PY1,1)>=Y_threshlow)&&(PY1>1))
            PY1=PY1-1;
        end 
       
      
        PY2=MaxY;
        while ((Blue_y(PY2,1)>=Y_threshlow)&&(PY2<y))
             PY2=PY2+1;
        end
        PY1, PY2
 
%==============X 方向===============================
        X_threshhigh=(PY2-PY1)/11;
        Blue_x=zeros(1,x);             
        for j=1:x
            for i=PY1:PY2
              %  if((myI(i,j,1)<=48)&&((myI(i,j,2)<=90)&&(myI(i,j,2)>=30))&&((myI(i,j,3)<=160)&&(myI(i,j,3)>=80)))      
                if((myI(i,j,1)<=65)&&((myI(i,j,2)<=100)&&(myI(i,j,2)>=40))&&((myI(i,j,3)<=160)&&(myI(i,j,3)>=90)))%这里由82修改成90.因为图片20090504809   
               %  if ((myI(i,j,1)<=0.7)&&(myI(i,j,1)>=0.6)&&((myI(i,j,2)<=1.8)&&(myI(i,j,2)>=0.6))&&((myI(i,j,3)<=1.7)&&(myI(i,j,3)>=0.45)))
                 Blue_x(1,j)= Blue_x(1,j)+1;               
                end  
            end       
        end
        [temp MaxX]=max(Blue_x);
        PX1=MaxX-6*(PY2-PY1);
        if  PX1<=1
            PX1=1;
        end
        while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))
              PX1=PX1+1;
        end  
        PX2=MaxX+6*(PY2-PY1);
        if  PX2>=x
            PX2=x;
        end
        while ((Blue_x(1,PX2)<=X_threshhigh)&&(PX2>PX1))
               PX2=PX2-1;
        end
        
%         PX1=1;
%         while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))%
%              PX1=PX1+1;
%         end %  
%         PX2=x;
%         while ((Blue_x(1,PX2)<X_threshhigh)&&(PX2>PX1))%
%             PX2=PX2-1;
%        end%
        PX1 ,PX2

%=========================================================       
        a=PY2-PY1+1;b=PX2-PX1+1;
        White=0;
        for i=PY1:PY2
            for j=PX1:PX2
            if   (std([myI(i,j,1) myI(i,j,2) myI(i,j,3)],1,2)<=22)&&(myI(i,j,1)>=90)&&(myI(i,j,1)<=255)
             
                White= White+1;    %                    
                end  
            end       
        end
        baisebili=White/(a*b)
        changkuanbi=a/b
        k=k+1
%
    elseif (k~=0)
        Blue_y(PY1:PY2,1)=0;
        
        [temp MaxY]=max(Blue_y);
        if temp<=20%
           msgbox('Fatal Detection Error','warning');
          
           pause;
        end
        PY1=MaxY;
        while ((Blue_y(PY1,1)>=Y_threshlow)&&(PY1>1))%
             PY1=PY1-1;
        end   
        %
        PY2=MaxY;
        while ((Blue_y(PY2,1)>=Y_threshlow)&&(PY2<y))%
        PY2=PY2+1;
        end
        PY1, PY2
%
        X_threshhigh=(PY2-PY1)/15;
        Blue_x=zeros(1,x);             
        for j=1:x
            for i=PY1:PY2
                if((myI(i,j,1)<=45)&&((myI(i,j,2)<=90)&&(myI(i,j,2)>=20))&&((myI(i,j,3)<=160)&&(myI(i,j,3)>=80)))      
                    Blue_x(1,j)= Blue_x(1,j)+1;               
                end  
            end       
        end
%
%
          [temp MaxX]=max(Blue_x);
          PX1=MaxX-6*(PY2-PY1);
          if  PX1<=1
              PX1=1;
          end          
          while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))%
                PX1=PX1+1;
          end %  
          PX2=MaxX+6*(PY2-PY1);
          if  PX2>=x
              PX2=x;
          end
          while ((Blue_x(1,PX2)<=X_threshhigh)&&(PX2>PX1))%
                PX2=PX2-1;
          end%
%           PX1=1;
%           while ((Blue_x(1,PX1)<=X_threshhigh)&&(PX1<x))%
%               PX1=PX1+1;
%           end
%           PX2=x;
%           while ((Blue_x(1,PX2)<X_threshhigh)&&(PX2>PX1))%
%               PX2=PX2-1;
%           end
          PX1 ,PX2
%=========================================================       
        a=PY2-PY1+1;b=PX2-PX1+1;
        White=0;
        for i=PY1:PY2
            for j=PX1:PX2
                if   (std([myI(i,j,1) myI(i,j,2) myI(i,j,3)],1,2)<=16)&&(myI(i,j,1)>=90)&&(myI(i,j,1)<=255)
                    White= White+1;    %                  
                end  
            end       
        end        
        baisebili=White/(a*b)
        changkuanbi=a/b
        k=k+1        
    end
end

%========================================================
Y_firrectify=fix((PY2-PY1)/5);%
PY1=PY1-Y_firrectify;%
PY2=PY2+Y_firrectify;%
% IY=I(PY1:PY2,:,:);%
PX1=PX1-X_firrectify;% 
PX2=PX2+X_firrectify;% ，