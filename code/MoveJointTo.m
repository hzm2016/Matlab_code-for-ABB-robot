function result = MoveJointTo(position, vel,t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%���ͳ����ı�
    swrite='#FileHead@'
	fwrite(t,swrite);
     FileCounter=0;
    %ģ��ͷ
	FileCounter=FileCounter+1;
    swrite=['#FileData ' num2str(FileCounter) ' ' 'MODULE movproc'  char(10)  '@'];
 	fwrite(t,swrite);
    %Ŀ���
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
%%�ӳ���ͷ
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)   ' '   'PROC Path_10()' char(10) '@' ];
	fwrite(t,swrite);
    %%�˶�ָ��
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

	%%�ӳ���β
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' '  'ENDPROC' '@'] ;
	fwrite(t,swrite);

    %%ģ��β
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' '  'ENDMODULE' '@'];
	fwrite(t,swrite);

	%%�����ļ�β
	swrite='#FileEnd@';
	fwrite(t,swrite);
    
    %%���ܻ����˵�ȷ����Ϣ,��ָ��ʹ�������˶�
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

	%%���ܻ����˵�ȷ����Ϣ,��ָ��ʹ�������˶�
	fwrite(t,'#WorkStart@');
%     end


    %%�ȴ��������˶�����ź�
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

