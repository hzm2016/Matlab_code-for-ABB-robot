function [position,Euler,T] = GetCalibTool(t)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
recvbuf=[];
data=[];
recvtemp=[];
Euler = [];
% 	char *ptr;
% 	int rc;
    
    ClearSocketBuffer(t);
    fwrite(t,'#GetCalibPar@');
    %%PX
    pause(0.3);

    timeout = 0;
    recvbuf=[];
    ind = 1;
    while (isempty(recvbuf) && timeout<20)
        if (t.BytesAvailable > 0)
            recvbuf = fscanf(t,'%c',t.BytesAvailable);
        end
        timeout=timeout+1;
        pause(0.1);
    end
    if timeout<20
        %fprintf('Get Tool Success!\n');
    else
        fprintf('Get Tool Fail!\n');
        position=[];
        Euler=[];
        T=[];
        return;
    end
    
    IsGetCorrect=true;
    
        
    px=strfind(recvbuf,'PX');
    py=strfind(recvbuf,'PY');
    pz=strfind(recvbuf,'PZ');
    ex=strfind(recvbuf,'EX');
    ey=strfind(recvbuf,'EY' );
    ez=strfind(recvbuf,'EZ');
    endnum=strfind(recvbuf,'*');
       
    position(1)=str2double(recvbuf((px+2):endnum(1)-1));
    position(2)=str2double(recvbuf((py+2):endnum(2)-1));
    position(3)=str2double(recvbuf((pz+2):endnum(3)-1));
    Euler(1)=str2double(recvbuf((ex+2):endnum(4)-1));
    Euler(2)=str2double(recvbuf((ey+2):endnum(5)-1));
    Euler(3)=str2double(recvbuf((ez+2):endnum(6)-1));
    euler=Euler*pi/180;
%%************************************************
%calculate the traslation homogeneous Matrix T with the pisition and
%enler having been calculated;
T=zeros(4,4);
T(1,1)=cos(euler(3))*cos(euler(2));
T(1,2)=cos(euler(3))*sin(euler(2))*sin(euler(1))-sin(euler(3))*cos(euler(1));
T(1,3)=cos(euler(3))*sin(euler(2))*cos(euler(1))+sin(euler(3))*sin(euler(1));
T(2,1)=sin(euler(3))*cos(euler(2));
T(2,2)=sin(euler(3))*sin(euler(2))*sin(euler(1))+cos(euler(3))*cos(euler(1));
T(2,3)=sin(euler(3))*sin(euler(2))*cos(euler(1))-cos(euler(3))*sin(euler(1));
T(3,1)=-sin(euler(2));
T(3,2)=cos(euler(2))*sin(euler(1));
T(3,3)=cos(euler(2))*cos(euler(1));
T(1,4)=position(1);
T(2,4)=position(2);
T(3,4)=position(3);
T(4,4)=1;
end




