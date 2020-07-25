function charec=charec(hanzi,xiuzhenghanzi);
[y,x,z]=size(xiuzhenghanzi);
for k=1:5
sum=0;
for i=1:y
    for j=1:x
         if  hanzi(i,j,k)==xiuzhenghanzi(i,j)%
             sum=sum+1;
        end
    end
end
baifenbi(1,k)=sum/(x*y);
end
chepai= find(baifenbi>=max(baifenbi));
charec=chepai;%
if       charec==1
         charec='╧П';
    elseif charec==2
         charec='╧С';
    elseif charec==3
         charec='╬╘';
    elseif charec==4
         charec='ку';
    elseif charec==5
         charec='та';
end