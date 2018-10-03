function [State,Peg,Hole,Peg_p]=Contact_state(theta,Peg_o_p,Hole_o_h,Th_p,k)
%***********轴孔尺寸*********
r_p=14.98;r_h=15;l_h=90;
h_p=100;h_h=100;
%*********Peg的底面法向量
Peg_fl_p=[0,-sin(theta),cos(theta)];Peg_fr_p=[0,sin(theta),cos(theta)];%轴的左右底面法向量
%***********各自点在各自坐标系里的坐标，点由左下角至左上角，逆时针一圈***********
Peg_ol_p=Peg_o_p{1};Peg_or_p=Peg_o_p{2};
Hole_ol_h=Hole_o_h{1};Hole_or_h=Hole_o_h{2};
%*********轴的坐标*******************
Peg_p=zeros(8,3);Hole_h=zeros(12,3);
Peg_p(1,:)=Peg_ol_p+r_p*[Peg_fl_p(1),-Peg_fl_p(3),Peg_fl_p(2)];
Peg_p(2,:)=Peg_ol_p+r_p*[Peg_fl_p(1),Peg_fl_p(3),-Peg_fl_p(2)];
Peg_p(3,:)=Peg_or_p+r_p*[Peg_fr_p(1),-Peg_fr_p(3),Peg_fr_p(2)];
Peg_p(4,:)=Peg_or_p+r_p*[Peg_fr_p(1),Peg_fr_p(3),-Peg_fr_p(2)];
Peg_p(5,:)=Peg_p(4,:)+h_p*Peg_fr_p;
Peg_p(6,:)=Peg_p(3,:)+h_p*Peg_fr_p;
Peg_p(7,:)=Peg_p(2,:)+h_p*Peg_fl_p;
Peg_p(8,:)=Peg_p(1,:)+h_p*Peg_fl_p;
%*********孔的坐标*******************
Hole_h(7,:)=Hole_or_h+l_h*[0,1,0];
Hole_h(8,:)=Hole_or_h+r_h*[0,1,0];
Hole_h(9,:)=Hole_or_h-r_h*[0,1,0];
Hole_h(10,:)=Hole_ol_h+r_h*[0,1,0];
Hole_h(11,:)=Hole_ol_h-r_h*[0,1,0];
Hole_h(12,:)=Hole_ol_h-l_h*[0,1,0];
Hole_h(1,:)=Hole_h(12,:)-h_h*[0,0,1];
Hole_h(2,:)=Hole_h(11,:)-h_h*[0,0,1];
Hole_h(3,:)=Hole_h(10,:)-h_h*[0,0,1];
Hole_h(4,:)=Hole_h(9,:)-h_h*[0,0,1];
Hole_h(5,:)=Hole_h(8,:)-h_h*[0,0,1];
Hole_h(6,:)=Hole_h(7,:)-h_h*[0,0,1];
%***************建立封闭区域***********************
Peg_L=[Peg_p(1,2),Peg_p(2,2),Peg_p(7,2),Peg_p(8,2);
       Peg_p(1,3),Peg_p(2,3),Peg_p(7,3),Peg_p(8,3)];
Peg_R=[Peg_p(3,2),Peg_p(4,2),Peg_p(5,2),Peg_p(6,2);
       Peg_p(3,3),Peg_p(4,3),Peg_p(5,3),Peg_p(6,3)];
Hole_L=[Hole_h(1,2),Hole_h(2,2),Hole_h(11,2),Hole_h(12,2);
       Peg_p(1,3),Hole_h(2,3),Hole_h(11,3),Hole_h(12,3)];
Hole_M=[Hole_h(3,2),Hole_h(4,2),Hole_h(9,2),Hole_h(10,2);
       Hole_h(3,3),Hole_h(4,3),Hole_h(9,3),Hole_h(10,3)];
Hole_R=[Hole_h(5,2),Hole_h(6,2),Hole_h(7,2),Hole_h(8,2);
       Hole_h(5,3),Hole_h(6,3),Hole_h(7,3),Hole_h(8,3)];
Area=cell(1,5);
Area{1}=Peg_L;Area{2}=Peg_R;Area{3}=Hole_L;Area{4}=Hole_M;Area{5}=Hole_R;
%% 定义8个标志点在对方坐标系的坐标,从左到右
Y_Peg_p=[0,0,0,0];Z_Peg_p=[0,0,0,0];
Y_Hole_h=[0,0,0,0];Z_Hole_h=[0,0,0,0];
Y_Peg_h=[0,0,0,0];Z_Peg_h=[0,0,0,0];
Y_Hole_p=[0,0,0,0];Z_Hole_p=[0,0,0,0];
for j=1:4
    Peg_h(j,:)=(Th_p*[Peg_p(j,:),1]')';Hole_p(12-j,:)=(Th_p^-1*[Hole_h(12-j,:),1]')';
    Y_Peg_p(j)=Peg_p(j,2);Y_Peg_h(j)=Peg_h(j,2);
    Z_Peg_p(j)=Peg_p(j,3);Z_Peg_h(j)=Peg_h(j,3);
    Y_Hole_h(j)=Hole_h(12-j,2);Y_Hole_p(j)=Hole_p(12-j,2);
    Z_Hole_h(j)=Hole_h(12-j,3);Z_Hole_p(j)=Hole_p(12-j,3);
end
Peg=[Y_Peg_h,Z_Peg_h];
Hole=[Y_Hole_p,Z_Hole_p];
%% 建立封闭区域
Peg_L=Area{1};Peg_R=Area{2};Hole_L=Area{3};Hole_M=Area{4};Hole_R=Area{5};
%% 判断是否在内部
for j=1:4
    P_in(k,j)=inpolygon(Peg(1,j),Peg(1,j+4),Hole_L(1,:),Hole_L(2,:))+inpolygon(Peg(1,j),Peg(1,j+4),Hole_M(1,:),Hole_M(2,:))+inpolygon(Peg(1,j),Peg(1,j+4),Hole_R(1,:),Hole_R(2,:));
    H_in(k,j)=inpolygon(Hole(1,j),Hole(1,j+4),Peg_L(1,:),Peg_L(2,:))+inpolygon(Hole(1,j),Hole(1,j+4),Peg_R(1,:),Peg_R(2,:));
end
State=[P_in(k,:),H_in(k,:)];%State为轴点1-4和孔点1-4接触状态组成的矩阵
end