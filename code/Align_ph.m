function Setresult= Align_ph(t,Tw_h)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%% 初始化坐标系及转换矩阵(Tw_h代表Hole在world坐标系中的转换矩阵)
Tt_p=[0.991637400257484,-0.129010728876267,-0.00335371088056397,1.32178490731144;
     -0.128981831489122,-0.991617025826413,0.00793154084490458,-1.77211582117081;
     -0.00434884804796371,-0.00720370882070689,-0.999962920899018,176.105974283837;
     0,0,0,1];% 通过配准算法加跟踪测量仪测出来，前者是孔到世界坐标系的转换矩阵，后者是世界坐标系到轴的转换矩阵
[~,~,Tw_t] = GetCalibTool(t);
Tw_p=Tw_t*Tt_p;
Th_p=Tw_h^-1*Tw_p;
%% 将轴孔位姿调整一致；
Tw_p_2=Tw_h;
Tw_p_2(3,4)=Tw_p(3,4);
dT=Tw_p^-1*Tw_p_2;
dT_2=Tt_p*dT*Tt_p^-1;
Tw_t2=Tw_t*dT_2;
[position_t2,eulerang_t2] = MatrixToEuler(Tw_t2);
%% 
myForceVector= GetFCForce(t);%从力传感器中采集得到的力信息, Forcedata(Fx,Fy,Fz,Mx,My,Mz)
%%
MoveToolTo(position_t2,eulerang_t2,30,t)%轴调整位姿
Setresult=1;
end

