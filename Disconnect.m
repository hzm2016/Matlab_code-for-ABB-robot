function Disconnect(socket)
if nargin<1
    socket=load('socket.mat');
    socket = socket.socket;
end
fclose(socket);
echotcpip('off');