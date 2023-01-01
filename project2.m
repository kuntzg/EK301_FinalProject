% C= [1 1 0 0 0 0 0 0 0 0 0 0 0; 1 0 1 1 0 0 0 0 0 0 0 0 0; 0 0 0 1 1 0 1 0 0 0 0 0 0;0 1 1 0 1 1 0 1 0 0 0 0 0; 0 0 0 0 0 1 1 0 1 1 0 0 0; 0 0 0 0 0 0 0 1 1 0 1 1 0; 0 0 0 0 0 0 0 0 0 1 1 0 1; 0 0 0 0 0 0 0 0 0 0 0 1 1];
%  Sx= [ 1 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0;0 0 0];
%  Sy= [0 1 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 1];
%  L= [0;0;0;0;0;0;0;0;0;0;0;25;0; 0; 0; 0];
%  x= [0 0 4 4 8 8 12 12];
%  y= [0 4 8 4 8 4 4 0];

filename=input('say name: ', 's');
run(filename);
 
 [joints, members]=size(C);
 totallength=0;
 for i=1:members
     locate=find(C(:,i));
     l1=locate(1);
     l2=locate(2);
     
     for j=1:members
         dx=x(l1)-x(l2);
         dy=y(l1)-y(l2);
         lengthmat(i)=sqrt(dx^2+dy^2);
         len=lengthmat(i);
         totallength=totallength+len;
     end
     
     Ax(l1,i)=(x(l1)-x(l2))/len;
     Ax(l2,i)=-(x(l1)-x(l2))/len;
     
     Ay(l1,i)=(y(l1)-y(l2))/len;
     Ay(l2,i)=-(y(l1)-y(l2))/len;
     
 end
 
 A1=[Ax Sx];
 A2=[Ay Sy];
 A=[A1;A2];
 B=[Sx Sy];
 
 [T,~]=lsqr(A,L);
 
 [trow,~]=size(T);
 
 for i=1:trow
     if (abs(T(i))<.000001)
         T(i)=0;
     end
 end
 
 cost=(10*joints)+totallength;
 
disp('\% EK301 Section A3, group #: Diya Desai, Gaby Kuntz, Madelyn Keller, 11/12/2021')

loadlocate=find(L);
load=L(loadlocate);
fprintf('Load: %.2f oz \n', load)
disp('Member forces in oz:')
for i=1:members
     if (T(i)<0)
         TorC="C";
     elseif (T(i)>0)
         TorC="T";
     else
         TorC='';
     end
     fprintf('m%d : %.2f %c \n', i, abs(T(i)), TorC); 
 end
disp('Reaction forces in oz:')
fprintf('Sx1: %.2f \n', T(end-2))
fprintf('Sy1: %.2f \n', T(end-1))
fprintf('Sy2: %.2f \n', T(end))

fprintf('Cost of truss: $%.2f \n',cost)
count=0;
for j=1:members
    if T(i)~=0
        Rm(j)=abs(T(j))/sum(L);
    end
    Pcrit(j)=2570/(lengthmat(j)^2);
    wmat(j)=Pcrit(j)/Rm(j);
end

wfailure=min(wmat);
memberfail = find(min(wmat));

fprintf('Theoretical max load/cost ratio in oz/$: %.3f\n', wfailure/cost)

     
     