%u �� λ�ã�������
function result = MoveCamera(u,socket,gHc,bHg)
%���x����ץ��z��ͬ��y�෴
if size(u,1)>1
    u = u';
end
if nargin<3
    gHc = load('gHc.mat');
    gHc = gHc.gHc;
end
if nargin<4
    [~,~,bHg]=GetCalibTool(socket);
end


cHc2 = EulerToMatrix(u(1:3),u(4:6));
bHg2 = bHg*gHc*cHc2/gHc;

[position2,euler2]=MatrixToEuler(bHg2);
result = MoveToolTo(position2,euler2,50,socket);

