function result = MoveJointTo(position, vel,t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%发送程序文本
    swrite='#FileHead@'
	fwrite(t,swrite);
     FileCounter=0;
    %模块头
	FileCounter=FileCounter+1;
    swrite=['#FileData ' num2str(FileCounter) ' ' 'MODULE movproc'  char(10)  '@'];
 	fwrite(t,swrite);
    %目标点
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' ' char(9) 'CONST jointtarget Target_1000:=' '@'];
    fwrite(t,swrite)
    
    
    FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' ' char(9)  '[['  sprintf('%.5f',position(1)) ',' sprintf('%.5f',position(2)) ',' sprintf('%.5f',position(3)) ',' ];
    swrite=[swrite sprintf('%.5f',position(4))  ',' sprintf('%.5f',position(5)) ',' sprintf('%.5f',position(6))  '],'  '@'];
	fwrite(t,swrite);
    
    FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' '  char(9) '[0,9E9,9E9,9E9,9E9,9E9]];' '@'] ;
 	fwrite(t,swrite);
%%子程序头
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)   ' '   'PROC Path_10()' char(10) '@' ];
	fwrite(t,swrite);
    %%运动指令
	FileCounter=FileCounter+1;
	swrite=['#FileData '  num2str(FileCounter)  ' '   char(9) 'MoveAbsj Target_1000,userspeed' char(92) 'V:='  sprintf('%.5f',vel)  ',z100,Tool0' char(92)  'WObj:=wobj0;'  char(10) '@'];
	fwrite(t,swrite);

	%%MovtionFinish
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' '  ' MovtionFinish;'  '@'];
	fwrite(t,swrite);

	%%ERROR_MovtionFinish
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' ' 'ERROR' '@'] ;
	fwrite(t,swrite);

	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' ' ' MovtionFinish;' '@'];
	fwrite(t,swrite);

	%%子程序尾
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' '  'ENDPROC' '@'] ;
	fwrite(t,swrite);

    %%模块尾
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' '  'ENDMODULE' '@'];
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

	%%接受机器人的确认信息,发指令使机器人运动
	fwrite(t,'#WorkStart@');
%     end


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
    if timeout<20
        result = true;
        fprintf('Move Tool Success!\n');
    else
        result = false;
        fprintf('Move Tool Fail!\n');
    end    
  end

