function [myForceVector]= GetFCForce(t)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
recvbuf=[];
myForceVector=[];
% 	char *ptr;
% 	int rc;
    ClearSocketBuffer(t);
    fwrite(t,'#GetFCForce@');
    %%PX
    pause(0.3);
   
    timeout = 0;
    ind = 1;
    while (isempty(recvbuf) && timeout<20)
        if (t.BytesAvailable > 0)
            recvbuf = fscanf(t,'%c',t.BytesAvailable);
        end
        timeout=timeout+1;
        pause(0.1);
    end
    if timeout<20
        fprintf('Get Force Success!\n');
    else
        fprintf('Get Force Fail!\n');
        myForceVector=[];
        return;
    end    
    fx=strfind(recvbuf,'Fx');
    fy=strfind(recvbuf,'Fy');
    fz=strfind(recvbuf,'Fz');
    tx=strfind(recvbuf,'Tx');
    ty=strfind(recvbuf,'Ty' );
    tz=strfind(recvbuf,'Tz');
    endnum=strfind(recvbuf,'*');
       
    myForceVector(1)=str2double(recvbuf((fx+2):endnum(1)-1));
    myForceVector(2)=str2double(recvbuf((fy+2):endnum(2)-1));
    myForceVector(3)=str2double(recvbuf((fz+2):endnum(3)-1));
    myForceVector(4)=str2double(recvbuf((tx+2):endnum(4)-1));
    myForceVector(5)=str2double(recvbuf((ty+2):endnum(5)-1));
    myForceVector(6)=str2double(recvbuf((tz+2):endnum(6)-1));
end




