lcount=1;
for k=1:m
    for i= 1:j
        if (C(i,k)==1)
            locate(lcount)=i;
            lcount=lcount+1;
        end
    end
end

%rmat=zeros(1000);
for r=1:numel(locate)
    xchange=(x(locate(r+1))-x(locate(r)))^2;
    ychange=(y(locate(r+1))-y(locate(r)))^2;
    rmat(r)=sqrt(xchange+ychange);
end

%Amat=zeros(1000);
rcount=1;
for i=1:j
    for k= 1:m
        if (C(i,k)==1)
            Amat(i,k)=(x(locate(k+1))-x(locate(k+1)))/rmat(rcount);
            Amat((i+j),k)=(y(locate(k+1))-y(locate(k+1)))/rmat(rcount);
            rcount=rcount+1;
        end
    end
end

for i=1:2j
    for k=m7+1:m7+3
        for si=1:5
            for sk=1:3
                Amat(i,k)=Sx(si,sk);
                Amat((i+j),k)=Sy(si,sk);
            end
        end
    end
end

T_mat=inv(A)\L;

for i=1:m
    Pcrit(i)=2570*(r_mat(i)^2);
    c_buckle(i)=-Pcrit(i);
end

total_length=numel(rmat);
Cost=(10*j)+total_length;

disp('\% EK301 Section A3, group #: Names, date')
fprintf('Load: %d oz', load)
disp('Member forces in oz \n')
for i=1:m
    if member(i)<0
        C_T=C;
    else
        C_T=T;
    end
    fprintf('m%d: %d (%d) \n', i, abs(member), C_T)
end
disp('Reaction forces in oz:\n')
fprintf('Sx1: %d', Sx(1,1))
fprintf('Sy1: %d', Sy(1,1))
fprintf('Sy2: %d', Sy(1,2))
fprintf('Cost of truss: $%d',cost)
fprintf('Theoretical max load/cost ratio in oz/$: %d', load/cost)





