function SetResult= SetFCForce_ABB(RefForce,t)
    ClearSocketBuffer(t);%清空接收缓冲区
	%发送程序文本
    swrite='#FileHead@';
	fwrite(t,swrite);
    FileCounter=0;
    %模块头
	FileCounter=FileCounter+1;
    swrite=['#FileData ' num2str(FileCounter) ' ' 'MODULE movproc'  char(10)  '@'];
    fwrite(t,swrite);
    %目标点
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' '  char(9) 'CONST robtarget Target_1000:=[['  sprintf('%.5f',RefForce(1)) ',' sprintf('%.5f',RefForce(2)) ',' sprintf('%.5f',RefForce(3)) '],'  '@'];
	swrite=[swrite  sprintf('%.5f',RefForce(4)) ',' sprintf('%.5f',RefForce(5)) ',' sprintf('%.5f',RefForce(6))  '],'  '@'];
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
        SetResult = true;
        %fprintf('Receive Success!\n');
    else
        SetResult = false;
        fprintf('Receive Fail!\n');
        return;
    end
    
    fwrite(t,'#SetFCForce@');

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
        SetResult = true;
        fprintf('SetForce Success!\n');
    else
        SetResult = false;
        fprintf('SetForce Fail!\n');
    end 
end




