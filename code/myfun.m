function F = myfun(x,Forcedata,State,Peg,Hole)
%% 定义常量
Y_Peg_h=0.001*Peg(1:4);%单位化为国际单位
Z_Peg_h=0.001*Peg(5:8);%单位化为国际单位
Y_Hole_h=0.001*Hole(1:4);%单位化为国际单位
u=0.1;alpha=2*pi/180;%金属和金属之间抹了润滑油后，摩擦系数约为0.1
%theta=3*pi/180;
dy=0;dz=0.144;
F_y=Forcedata(2);F_z=Forcedata(3);M_x=Forcedata(4)+F_y*dz;%判断一下力的方向是否和我们之前设的方向一致，应该需要调整正负号(判断结果：不用变)
%dy代表孔中心偏离力传感器中心的y距离，理想状态为0；dz代表孔中心偏离力传感器中心的Z距离，理想状态为144
%%  方程的系数
Ky=[-u,-1,1,u,cos(x(3)+alpha)-u*sin(x(3)+alpha),u*cos(x(3)+alpha)-sin(x(3)+alpha),-u*cos(x(3)+alpha)+sin(x(3)+alpha),-cos(x(3)+alpha)+u*sin(x(3)+alpha)];
Kz=[1,u,u,1,u*cos(x(3)+alpha)+sin(x(3)+alpha),cos(x(3)+alpha)+u*sin(x(3)+alpha),cos(x(3)+alpha)+u*sin(x(3)+alpha),u*cos(x(3)+alpha)+sin(x(3)+alpha)];
Km=[abs(Y_Peg_h(1)),(u*abs(Y_Peg_h(2))+abs(Z_Peg_h(2))),-u*abs(Y_Peg_h(3))-abs(Z_Peg_h(3)),-abs(Y_Peg_h(4)),Kz(5)*abs(Y_Hole_h(1)),Kz(6)*abs(Y_Hole_h(2)),-Kz(7)*abs(Y_Hole_h(3)),-Kz(8)*abs(Y_Hole_h(4))];
%%  根据接触状态定义系数
Ky_1=0;Kz_1=0;Km_1=0;
Ky_2=0;Kz_2=0;Km_2=0;
for i=1:8
    if State(i)==1
        Ky_1=Ky(i);
        Kz_1=Kz(i);
        Km_1=Km(i);
        j=i;
        break
    end
end
for i=j+1:8
    if State(i)==1
        Ky_2=Ky(i);
        Kz_2=Kz(i);
        Km_2=Km(i);
    end
end
%% 输出的函数
F=[F_y+Ky_1*x(1)+Ky_2*x(2);
   F_z+Kz_1*x(1)+Kz_2*x(2);
   M_x+Km_1*x(1)+Km_2*x(2)];%x(1)=FN_1,x(2)=FN_2,x(3)=theta

end

