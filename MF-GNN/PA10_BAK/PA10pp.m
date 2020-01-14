clear;
format long;
load INITdata;

interval=0.1;

jj=0;
epsilon=0;
for ii=1:length(t),
    if(t(ii,1)>=epsilon)
        jj=jj+1;
        tn(jj,1)=t(ii,1);
        yn(jj,:)=y(ii,:);
        epsilon=jj*interval;
    elseif(ii==length(t))
        jj=jj+1;
        tn(jj,1)=t(ii,1);
        yn(jj,:)=y(ii,:);
        epsilon=jj*interval;
    end
end
clear t y;
t=tn;
y=yn;
clear tn yn;
qAll=y(:,1:7);
size(qAll)
uAll=y(:,8:17);
size(uAll)
save SNDdata t qAll uAll;