function ClearSocketBuffer( socket )
%ClearSocketBuffer ���socket���ܻ�����
%   �˴���ʾ��ϸ˵��
flushinput(socket);
% while socket.BytesAvailable>0
%     while socket.BytesAvailable>0
%         fread(socket,socket.BytesAvailable,'uint8');
%     end
%     pause(0.1);
%     socket.BytesAvailable
% end

