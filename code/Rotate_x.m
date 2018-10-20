function  [position_R,eulerang_R] = Rotate_x(q_x,t)
%UNTITLED Summary of this function goes here
[position,eulerang,T]=GetCalibTool(t);  %将机械s臂手动移动到孔轴装配完成的位置，然后再记录此时的轴的位置
position=position;
eulerang=eulerang;
R_x=rotx(q_x);
T_1=[R_x(1,:),0;
     R_x(2,:),0;
     R_x(3,:),0;
     0,0,0,1];
T_2=T*T_1;
[position_R,eulerang_R] = MatrixToEuler(T_2);
%现在的矩阵