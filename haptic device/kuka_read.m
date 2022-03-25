function kuka_read()
    disp('Program started');
    % vrep=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
    sim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    sim.simxFinish(-1); % just in case, close all opened connections
    clientID=sim.simxStart('127.0.0.1',19997,true,true,5000,5);
    
    sim.simxStartSimulation(clientID, sim.simx_opmode_oneshot);
    
    % position data
    pa = [];    % actual position
    pd = [];    % desired position
    k=0;
    
    % joint angle data
    r1=[];
    r2=[];
    r3=[];
    r4=[];
    r5=[];
    r6=[];
    r7=[];
    
    % joint velocity data
    v1=[];
    v2=[];
    v3=[];
    v4=[];
    v5=[];
    v6=[];
    v7=[];
    
    r1vel = zeros(1);
    r2vel = zeros(1);
    r3vel = zeros(1);
    r4vel = zeros(1);
    r5vel = zeros(1);
    r6vel = zeros(1);
    r7vel = zeros(1);
    
    if (clientID>-1)
        disp('Connected to remote API server');
        
%         for i = 1:m
%             % get handle for kuka_joint
%             [res,JointHandle(i)] = sim.simxGetObjectHandle(clientID, ['LBR_iiwa_7_R800_joint', num2str(i)], sim.simx_opmode_blocking ); 
%             
%         end
%         [res,simBase] = sim.simxGetObjectHandle(clientID, '/LBR_iiwa_7_R800', sim.simx_opmode_blocking );
        
        % position handle
        [res,simTip] = sim.simxGetObjectHandle(clientID, '/LBR_iiwa_7_R800/tip', sim.simx_opmode_blocking );
        [res,simTarget] = sim.simxGetObjectHandle(clientID, '/target', sim.simx_opmode_blocking ); 
        
        % joint handle
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
            
            % read position of tip and target
            [res,p1]=sim.simxGetObjectPosition(clientID, simTip, -1, sim.simx_opmode_blocking );   
            [res,p2]=sim.simxGetObjectPosition(clientID, simTarget, -1, sim.simx_opmode_blocking );
            
            
            pa= [pa p1'];
            pd= [pd p2'];
            
            
            % read joint angle:deg
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
            
            
            % read joint velocity: deg/s
            
            [res,~,r1vel,~,~] = sim.simxCallScriptFunction(clientID, '/LBR_iiwa_7_R800/', sim.sim_scripttype_childscript,'myFunctionName',[jointhandle1],[],'',[],sim.simx_opmode_blocking);
            [res,~,r2vel,~,~] = sim.simxCallScriptFunction(clientID, '/LBR_iiwa_7_R800/', sim.sim_scripttype_childscript,'myFunctionName',[jointhandle2],[],'',[],sim.simx_opmode_blocking);
            [res,~,r3vel,~,~] = sim.simxCallScriptFunction(clientID, '/LBR_iiwa_7_R800/', sim.sim_scripttype_childscript,'myFunctionName',[jointhandle3],[],'',[],sim.simx_opmode_blocking);
            [res,~,r4vel,~,~] = sim.simxCallScriptFunction(clientID, '/LBR_iiwa_7_R800/', sim.sim_scripttype_childscript,'myFunctionName',[jointhandle4],[],'',[],sim.simx_opmode_blocking);
            [res,~,r5vel,~,~] = sim.simxCallScriptFunction(clientID, '/LBR_iiwa_7_R800/', sim.sim_scripttype_childscript,'myFunctionName',[jointhandle5],[],'',[],sim.simx_opmode_blocking);
            [res,~,r6vel,~,~] = sim.simxCallScriptFunction(clientID, '/LBR_iiwa_7_R800/', sim.sim_scripttype_childscript,'myFunctionName',[jointhandle6],[],'',[],sim.simx_opmode_blocking);
            [res,~,r7vel,~,~] = sim.simxCallScriptFunction(clientID, '/LBR_iiwa_7_R800/', sim.sim_scripttype_childscript,'myFunctionName',[jointhandle7],[],'',[],sim.simx_opmode_blocking);

            if res == sim.simx_return_ok         
                
                v1= [v1 180*r1vel/pi]; 
                v2= [v2 180*r2vel/pi];
                v3= [v3 180*r3vel/pi];
                v4= [v4 180*r4vel/pi];
                v5= [v5 180*r5vel/pi];
                v6= [v6 180*r6vel/pi];
                v7= [v7 180*r7vel/pi];
                
            else
                disp("the read joint velocity error");
            end
            
            k = k+1 %to test
            
        end
        
        pa = pa';
        pd = pd';
        
        
       joint_angle = [r1' r2' r3' r4' r5' r6' r7'];
       joint_velocity = [v1' v2' v3' v4' v5' v6' v7'];
        
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
        
        save data\ObjectPosition pa pd;
        save data\JointAngle joint_angle;
        save data\JointVelocity joint_velocity;
        
   else
      disp('Failed connecting to remote API server');
    end
    
    sim.delete(); % call the destructor!
   
   disp('Program ended');
end

