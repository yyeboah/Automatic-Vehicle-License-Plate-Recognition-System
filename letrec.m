function letrec=letrec(letter,lettermod);
[y,x,z]=size(lettermod);
for k=1:24
sum=0;
for i=1:y
    for j=1:x
         if  letter(i,j,k)==lettermod(i,j)%
             sum=sum+1;
        end
    end
end
baifenbi(1,k)=sum/(x*y);
end
chepai= find(baifenbi>=max(baifenbi));
letrec=chepai;%
if         letrec==1
        letrec='A';
    elseif letrec==2
        letrec='B';
    elseif letrec==3
        letrec='C';
    elseif letrec==4
        letrec='D';
    elseif letrec==5
        letrec='E';
    elseif letrec==6
        letrec='F';
    elseif letrec==7
        letrec='G';
    elseif letrec==8
        letrec='H';
    elseif letrec==9
        letrec='J';
    elseif letrec==10
        letrec='K';
    elseif letrec==11
        letrec='L';
    elseif letrec==12
        letrec='M';
    elseif letrec==13
        letrec='N';
    elseif letrec==14
        letrec='P';
    elseif letrec==15
        letrec='Q';
    elseif letrec==16
        letrec='R';
    elseif letrec==17
        letrec='S';
    elseif letrec==18
        letrec='T';
    elseif letrec==19
        letrec='U';
    elseif letrec==20
        letrec='V';
    elseif letrec==21
        letrec='W';
    elseif letrec==22
        letrec='X';
    elseif letrec==23
        letrec='Y';
    elseif letrec==24
        letrec='Z';
    end