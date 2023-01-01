filename=input('Name of file: ', 's');
run(filename);
 
 [joints, members]=size(C); %find the number of joints and members
 totallength=0;
 for i=1:members
     locate=find(C(:,i)); %locate the 1's in the C matrix
     l1=locate(1);
     l2=locate(2);
     
     for j=1:members
         dx=X(l1)-X(l2); 
         dy=Y(l1)-Y(l2);
         lengthmat(i)=sqrt(dx^2+dy^2); %calculate r (the distance between joints)
         len=lengthmat(i);
     end
     
     %calculations for the numerator of the force in the A matrix
     Ax(l1,i)=(X(l1)-X(l2))/len;
     Ax(l2,i)=-(X(l1)-X(l2))/len;
     
     Ay(l1,i)=(Y(l1)-Y(l2))/len;
     Ay(l2,i)=-(Y(l1)-Y(l2))/len;
     
 end
 
 %create the complete A matrix
 A1=[Ax Sx];
 A2=[Ay Sy];
 A=[A1;A2];
 B=[Sx Sy];
 
 %T=A^-1(L)
 [T,~]=lsqr(A,L);
 
 [trow,~]=size(T);
 
 %if a value in T(i) is very close to 0, make it 0
 for i=1:trow
     if (abs(T(i))<.000001)
         T(i)=0;
     end
 end
 
 
disp('\% EK301 Section A3, Group: Diya Desai, Gaby Kuntz, Madelyn Keller, 11/12/2021')


loadlocate=find(L);
load=L(loadlocate); %calculate the load for each member
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

totallength=sum(lengthmat); %find the total length of all the members used in the truss
cost=(10*joints)+totallength;
fprintf('Cost of truss: $%.2f \n',cost)
count=0;
for j=1:members
    Rm(j)=abs(T(j))/sum(L);
    Pcrit(j)=2570/(lengthmat(j)^2);
    wmat(j)=Pcrit(j)/Rm(j); %calculate the buckling strength for all members
end

[wfailure]=min(wmat); %calculate the maximum theortical load
[~,memberfail]=min(wmat); %find the weakest member
lengthfail=lengthmat(memberfail); %find the length of the weakest member
maxbuck=Pcrit(memberfail); %find the buckling strength of the weakest member

fprintf('It fails at: %.2f oz \n', wfailure);

fprintf('Theoretical max load/cost ratio in oz/$: %.3f\n', wfailure/cost)

     
     