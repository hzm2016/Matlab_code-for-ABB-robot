function  result = MoveToolTo_2( position,q, vel,t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%      swrite=zeros(100,1);
% 	 stemp=zeros(100,1);
% 	 recvbuf[100];
%	 str;
    ClearSocketBuffer(t);%��ս��ջ�����
	%���ͳ����ı�
    swrite='#FileHead@';
	fwrite(t,swrite);
     FileCounter=0;
    %ģ��ͷ
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

	%��Ԫ��
	q1=q(1);
    q2=q(2);
    q3=q(3);
    q4=q(4);

	%Ŀ���
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

	%%�ӳ���ͷ
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' '  'PROC Path_10()' char(10)  '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'PROC Path_10()\n');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%SingArea \Wrist�������������ʱ��������΢���޸�����̬��
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter)  ' ' char(9) 'SingArea  ' char(92)  'Wrist;' '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'\tSingArea \\Wrist;');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%ConfL \Off���رնԻ�����λ�εļ��
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' '  char(9) 'ConfL ' char(92) 'Off;' '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'\tConfL \\Off;');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

	%%�˶�ָ��
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

	%%�ӳ���β
	FileCounter=FileCounter+1;
	swrite=['#FileData ' num2str(FileCounter) ' ' 'ENDPROC'  '@'];
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'ENDPROC');
% 	strcat(swrite,'@');
	fwrite(t,swrite);

    %%ģ��β
	FileCounter=FileCounter+1;
	swrite=['#FileData '  num2str(FileCounter)  ' '  'ENDMODULE'   '@']; 
% 	stemp=num2str(FileCounter);
% 	strcat(swrite,stemp);
% 	strcat(swrite,' ');
% 	strcat(swrite,'ENDMODULE');
% 	strcat(swrite,'@');
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
    
    fwrite(t,'#WorkStart@');

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
    if timeout<100
        result = true;
        %fprintf('Move Tool Success!\n');
    else
        result = false;
        fprintf('Move Tool Fail!\n');
    end    
end

