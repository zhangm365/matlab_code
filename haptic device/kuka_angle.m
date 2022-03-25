function kuka_angle()
    disp('Program started');
    % vrep=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
    sim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    sim.simxFinish(-1); % just in case, close all opened connections
    clientID=sim.simxStart('127.0.0.1',19997,true,true,5000,5);
    
    sim.simxStartSimulation(clientID, sim.simx_opmode_oneshot);
    
    r1=[];
    r2=[];
    r3=[];
    r4=[];
    r5=[];
    r6=[];
    r7=[];
    
    k=0;
    m = 7;
    JointHandle = zeros(m,1);
    
    if (clientID>-1)
        disp('Connected to remote API server');
        
%         for i = 1:m
%             % get handle for kuka_joint
%             [res,JointHandle(i)] = sim.simxGetObjectHandle(clientID, ['LBR_iiwa_7_R800_joint', num2str(i)], sim.simx_opmode_blocking ); 
%             
%         end
        [res,jointhandle1] = sim.simxGetObjectHandle(clientID, 'LBR_iiwa_7_R800_joint1', sim.simx_opmode_blocking );
        [res,jointhandle2] = sim.simxGetObjectHandle(clientID, 'LBR_iiwa_7_R800_joint2', sim.simx_opmode_blocking ); 
        [res,jointhandle3] = sim.simxGetObjectHandle(clientID, 'LBR_iiwa_7_R800_joint3', sim.simx_opmode_blocking ); 
        [res,jointhandle4] = sim.simxGetObjectHandle(clientID, 'LBR_iiwa_7_R800_joint4', sim.simx_opmode_blocking ); 
        [res,jointhandle5] = sim.simxGetObjectHandle(clientID, 'LBR_iiwa_7_R800_joint5', sim.simx_opmode_blocking ); 
        [res,jointhandle6] = sim.simxGetObjectHandle(clientID, 'LBR_iiwa_7_R800_joint6', sim.simx_opmode_blocking ); 
        [res,jointhandle7] = sim.simxGetObjectHandle(clientID, 'LBR_iiwa_7_R800_joint7', sim.simx_opmode_blocking ); 
        
        while (sim.simxGetConnectionId(clientID)~=-1)   % while the connection is still active
%             t = sim.simxGetLastCmdTime(clientID) / 1000.0;  % get current simulation time
%             if (t > 1000) 
%                 break; 
%             end  % stop after t = 1000 seconds

            [res, info] = sim.simxGetInMessageInfo(clientID, sim.simx_headeroffset_server_state);
            if( info ~= 1 ) % the remote server has stoped
                break;
            end
            
            [res,r1angle]=sim.simxGetJointPosition(clientID,jointhandle1,sim.simx_opmode_blocking );   
            [res,r2angle]=sim.simxGetJointPosition(clientID,jointhandle2,sim.simx_opmode_blocking );
            [res,r3angle]=sim.simxGetJointPosition(clientID,jointhandle3,sim.simx_opmode_blocking );
            [res,r4angle]=sim.simxGetJointPosition(clientID,jointhandle4,sim.simx_opmode_blocking );
            [res,r5angle]=sim.simxGetJointPosition(clientID,jointhandle5,sim.simx_opmode_blocking );
            [res,r6angle]=sim.simxGetJointPosition(clientID,jointhandle6,sim.simx_opmode_blocking );
            [res,r7angle]=sim.simxGetJointPosition(clientID,jointhandle7,sim.simx_opmode_blocking ); 
            
            r1= [r1 180*r1angle/pi];
            r2= [r2 180*r2angle/pi];
            r3= [r3 180*r3angle/pi];
            r4= [r4 180*r4angle/pi];
            r5= [r5 180*r5angle/pi];
            r6= [r6 180*r6angle/pi];
            r7= [r7 180*r7angle/pi];
            
            k=k+1 %to test
            
        end
        
        angle=[r1' r2' r3' r4' r5' r6' r7'];
        
        
%         r=[r1' r2' r3' r4' r5' r6' r7'];
%         fid=fopen('angle.txt','wt');
%         [m,n]=size(r);
%         for i=1:1:m
%             for j=1:1:n
%                 if j==n 
%                     fprintf(fid,'%g\n',r(i,j));
%                 else
%                     fprintf(fid,'%g\t',r(i,j));
%                 end
%             end
%         end
%         fclose(fid);           
        
        
       
        % Before closing the connection to CoppeliaSim, make sure that the last command sent out had time to arrive. You can guarantee this with (for example):
        sim.simxGetPingTime(clientID);
        % Now close the connection to V-REP:
        sim.simxFinish(clientID);
        
        save data\JointAngle angle;
        
   else
      disp('Failed connecting to remote API server');
    end
    
    sim.delete(); % call the destructor!
   
   disp('Program ended');
end

