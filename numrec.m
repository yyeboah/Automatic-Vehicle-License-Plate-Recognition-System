function numrec=numrec(num,letter_1);
[y,x,z]=size(letter_1);
   
for k=1:10
sum=0;
for i=1:y
    for j=1:x
         if  num(i,j,k)==letter_1(i,j)%
             sum=sum+1;
        end
    end
end
baifenbi(1,k)=sum/(x*y);
end
chepai= find(baifenbi>=max(baifenbi));
numrec=chepai-1;
numrec=num2str(numrec);