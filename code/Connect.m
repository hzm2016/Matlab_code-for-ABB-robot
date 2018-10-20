function socket = Connect
if exist('socket.mat','file')
    Disconnect
    socket=tcpip('192.168.125.1',1502,'NetworkRole','client');
    fopen(socket);
    %fwrite(socket,'#MotorOn@');
    %fwrite(socket,'#Init@');
    save 'socket.mat' 'socket';
else
    error('Wrong directory!')
end