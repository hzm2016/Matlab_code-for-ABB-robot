function  result = MoveToolTo( position,euler, vel,t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%      swrite=zeros(100,1);
% 	 stemp=zeros(100,1);
% 	 recvbuf[100];
%	 str;
    ClearSocketBuffer(t);%清空接收缓冲区
	%发送程序文本
    swrite='#FileHead@';
	fwrite(t,swrite);
     FileCounter=0;
    %模块头
	FileCounter=FileCounter+1;
%     swrite=['#FileData ' num2str(FileCounter)  ' ' 'MODULE movproc' char(10) '@'];
    swrite=['#FileData ' num2str(FileCounter) ' ' 'MODULE movproc'  char(10)  '@'];
%  	fwrite(t,swrite);
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'MODULE movproc\n');
% 	strcat(swrite,'@');
    fwrite(t,swrite);

	%欧拉角转换为四元数
	ax=euler(1)*pi/180;
	ay=euler(2)*pi/180;
	az=euler(3)*pi/180;

	x1=cos(ay)*cos(az);
	x2=cos(ay)*sin(az);
	x3=-sin(ay);
	y1=-cos(ax)*sin(az)+sin(ax)*sin(ay)*cos(az);
	y2=cos(ax)*cos(az)+sin(ax)*sin(ay)*sin(az);
	y3=sin(ax)*cos(ay);
	z1=sin(ax)*sin(az)+cos(ax)*sin(ay)*cos(az);
	z2=-sin(ax)*cos(az)+cos(ax)*sin(ay)*sin(az);
	z3=cos(ax)*cos(ay);

	q1=sqrt(x1+y2+z3+1)/2;
	if(y3>=z2)
		q2=sqrt(x1-y2-z3+1)/2;
    else
		q2=-sqrt(x1-y2-z3+1)/2;
    end
    if(z1>=x3)
		q3=sqrt(y2-x1-z3+1)/2;
    else
		q3=-sqrt(y2-x1-z3+1)/2;
    end
    if(x2>=y1)
		q4=sqrt(z3-x1-y2+1)/2;
    else
		q4=-sqrt(z3-x1-y2+1)/2;
    end


	%目标点
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' '  char(9) 'CONST robtarget Target_1000:=[['  sprintf('%.5f',position(1)) ',' sprintf('%.5f',position(2)) ',' sprintf('%.5f',position(3)) '],'  '@'];
%     stemp=num2str(FileCounter)
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'\tCONST robtarget Target_1000:=[[');
% 	stemp=sprintf('%.5f',position(1));
% 	strcat(swrite,stemp);
% 	strcat(swrite,',');
% 	stemp=sprintf('%.5f',position(2));
% 	strcat(swrite,stemp);
% 	strcat(swrite,',');
% 	stemp=sprintf('%.5f',position(3));
% 	strcat(swrite,stemp);
% 	strcat(swrite,'],');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	FileCounter=FileCounter+1;
    swrite=['#FileData ' num2str(FileCounter) ' ' char(9)  '['  sprintf('%.5f',q1) ',' sprintf('%.5f',q2) ',' sprintf('%.5f',q3) ','];
    swrite=[swrite  sprintf('%.5f',q4)  '],'  '@'];
% 	stemp=num2str(FileCounter);
%     strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'\t[');
% 	stemp=sprintf('%.5f',q1);
% 	strcat(swrite,stemp);
% 	strcat(swrite,',');
% 	stemp=sprintf('%.5f',q2);
% 	strcat(swrite,stemp);
% 	strcat(swrite,',');
% 	stemp=sprintf('%.5f',q3);
% 	strcat(swrite,stemp);
% 	strcat(swrite,',');
% 	stemp=sprint('%.5f',q4);
% 	strcat(swrite,stemp);
% 	strcat(swrite,'],');
% 	strcat(swrite,'@');
	fwrite(t,swrite);
	
    FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' ' char(9)  '[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,0]];'  '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'\t[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,0]];');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%子程序头
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' '  'PROC Path_10()' char(10)  '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'PROC Path_10()\n');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%SingArea \Wrist，允许出现奇异时机器人轻微地修改其姿态。
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' ' char(9) 'SingArea  ' char(92)  'Wrist;' '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'\tSingArea \\Wrist;');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%ConfL \Off，关闭对机器人位形的监控
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' '  char(9) 'ConfL ' char(92) 'Off;' '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'\tConfL \\Off;');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%运动指令
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' '  char(9) 'MoveL Target_1000,userspeed' char(92) 'V:=' sprintf('%.5f',vel) ',z100,Tool0' char(92) 'WObj:=wobj0;' char(10) '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'\tMoveL Target_1000,userspeed\\V:=');
% 	stemp=sprintf('%.5f',vel);
% 	strcat(swrite,stemp);
% 	strcat(swrite,',z100,Tool0\\WObj:=wobj0;\n');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%MovtionFinish
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' '  ' MovtionFinish;' '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'	MovtionFinish;');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%ERROR_MovtionFinish
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' '  'ERROR' '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite, ' ');
% 	strcat(swrite,'ERROR');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' '  ' MovtionFinish;'  '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'	MovtionFinish;');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%子程序尾
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' ' 'ENDPROC'  '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'ENDPROC');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

    %%模块尾
	FileCounter=FileCounter+1;
	swrite=['#FileData '  num2str(FileCounter)  ' '  'ENDMODULE'   '@']; 
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'ENDMODULE');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%发送文件尾
	swrite='#FileEnd@';
	fwrite(t,swrite);

	%%接受机器人的确认信息,发指令使机器人运动
    recvbuf='';
    timeout = 0;
    while (isempty(strfind(recvbuf,'Receive Over!')) && timeout<20)
        if (t.BytesAvailable > 0)
             recvbuf = fscanf(t,'%c',t.BytesAvailable);
        end
        timeout=timeout+1;
        pause(0.1);
    end
    if timeout<20
        result = true;
        %fprintf('Receive Success!\n');
    else
        result = false;
        fprintf('Receive Fail!\n');
        return;
    end
    
    fwrite(t,'#WorkStart@');

	%%等待机器人运动完成信号
    recvbuf='';
	timeout = 0;
    while (isempty(strfind(recvbuf,'MotionFinish')) && timeout<100)
        if (t.BytesAvailable > 0)
             recvbuf = fscanf(t,'%c',t.BytesAvailable);
        end
        timeout=timeout+1;
        pause(0.1);
    end
    if timeout<100
        result = true;
        %fprintf('Move Tool Success!\n');
    else
        result = false;
        fprintf('Move Tool Fail!\n');
    end    
end

