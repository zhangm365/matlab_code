clear;
format long;
load INITdata;

jj=1;
for ii=1:2:length(t),%revise to the new level
    tn(jj,1)=t(ii,1);
    yn(jj,:)=y(ii,:);
    jj=jj+1;
end
tn(jj,1)=t(length(t),1);
yn(jj,:)=y(length(t),:);
clear t y;
t=tn;y=yn;
clear tn yn;
size(t)
size(y)
qAll=y(:,1:7);
size(qAll)
uAll=y(:,8:17);
size(uAll)

save SNDdata t qAll uAll;