C= [1 1 0 0 0 0 0 0 0 0 0 0 0; 1 0 1 1 0 0 0 0 0 0 0 0 0; 0 0 0 1 1 0 1 0 0 0 0 0 0;0 1 1 0 1 1 0 1 0 0 0 0 0; 0 0 0 0 0 1 1 0 1 1 0 0 0; 0 0 0 0 0 0 0 1 1 0 1 1 0; 0 0 0 0 0 0 0 0 0 1 1 0 1; 0 0 0 0 0 0 0 0 0 0 0 1 1];
 Sx= [ 1 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0;0 0 0];
 Sy= [0 1 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 0; 0 0 1];
 L= [0;0;0;0;0;0;0;0;0;0;0;25;0; 0; 0; 0];
 x= [0 0 4 4 8 8 12 12];
 y= [0 4 8 4 8 4 4 0];
 
 %[cx, cy]=size(C);
 
 for i=1:cx
     %m=members
     members=find(C(i,:)==1);
     for j=1:length(members)
         joints(j,:)=find(C(1,members(j))==1);
     end
     [B,~]=size(joints);
     for L=1:B
         if (joints(L,1) == i)
             Xdist=X(joints(L,2))-X(joints(L,1));
         else 
             Xdist=X(joints(L,1))-X(joints(L,2));
         end
             Ydist=Y(joints(L,1))-Y(joints(L,2));
             Rdist=abs((Xdist)/sqrt(Xdist^2+Ydist^2));
             Vector(L)=Rdist;
     end
     forces=zeros(1,Cy)
 end
 

            