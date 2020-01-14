clear;
format long;
load SYSdata;
load INITdata;

jj=0;
epsilon=0;
interval=0.0015;
for ii=1:length(t),
    if(t(ii,1)>=epsilon)
        jj=jj+1;
        tn(jj,1)=t(ii,1);
        yn(jj,:)=y(ii,:);
        epsilon=tn(jj,1)+interval;
    elseif(ii==length(t))
        jj=jj+1;
        tn(jj,1)=t(ii,1);
        yn(jj,:)=y(ii,:);
        %epsilon=jj*interval;
        epsilon=tn(jj,1)+interval;
    end
end

clear t y;
t=tn;
y=yn;
size(t)
size(y)
clear tn yn;

n=5;
qAll=y(:,1:n);
size(qAll) 
xAll=y(:,(n+1):(3*n));
size(xAll)

save SNDdata t qAll xAll;