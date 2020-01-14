% function gf=gFunction(rm,u,rp)
% 
% global qDp qDm;
% 
% cmpP=rp;
% cmpM=rm;
% 
% for i=1:7,
%     if (cmpP(i+3)>qDp(i)) cmpP(i+3)=qDp(i);
%     end;
%     if (cmpM(i+3)<qDm(i)) cmpM(i+3)=qDm(i);
%     end;
% end;
% 
% for i=1:length(u),
%     if (u(i)>=cmpP(i)) 
%         gf(i,1)=cmpP(i);
%     elseif (u(i)<=cmpM(i)) 
%         gf(i,1)=cmpM(i);
%     else 
%         gf(i,1)=u(i);
%     end;
% end;


function gf=gfunction(rm,u,rp)
for i=1:length(u),
    if (u(i)>=rp(i)) 
        gf(i,1)=rp(i);
    elseif (u(i)<=rm(i)) 
        gf(i,1)=rm(i);
    else 
        gf(i,1)=u(i);
    end;
end;