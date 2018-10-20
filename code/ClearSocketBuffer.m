function ClearSocketBuffer( socket )
%ClearSocketBuffer 情况socket接受缓冲区
%   此处显示详细说明
flushinput(socket);
% while socket.BytesAvailable>0
%     while socket.BytesAvailable>0
%         fread(socket,socket.BytesAvailable,'uint8');
%     end
%     pause(0.1);
%     socket.BytesAvailable
% end

