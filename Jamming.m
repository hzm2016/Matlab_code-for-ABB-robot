%% 得到Mx，Fz，Fy之间的关系
Mx_CFz=5*(Force_peg(:,4)+Force_peg(:,2)*0.144)./Force_peg(:,3);
Mx_CFz=Mx_CFz+0.001*Force_peg(:,2).*dPosition_peg(:,3);
Fy_Fz=Force_peg(:,2)./Force_peg(:,3);
for i=1:size(Fy_Fz)
    if (Force_peg(i,3)>0)||(abs(Mx_CFz(i))>10)||(abs(Fy_Fz(i))>10)
        Mx_CFz(i)=0;Fy_Fz(i)=0;
    end
end
N=150-rem(150,4);
%D=0.03;C=0.2;u=0.1;theta_0=1*pi/180;Yph1=-(C+D)/2;Yph4=(C+D)/2;Zph1=0.1;Zph2=0.006;Zph3=0.006;Zph4=0.1;alpha_0=0.0*pi/180;alpha_1=0*pi/180;alpha_2=0*pi/180;%理论分析中的大变形阶段图
%D=0.03;C=0.2;u=0.1;theta_0=0.01*pi/180;Yph1=-(C+D)/2;Yph4=(C+D)/2;Zph1=0.01;Zph2=0.011;Zph3=0.011;Zph4=0.01;alpha_0=0.0*pi/180;alpha_1=2*pi/180;alpha_2=-2*pi/180;%理论分析中的小变形阶段图
D=0.03;C=0.2;u=0.1;theta_0=0.01*pi/180;Yph1=-(C+D)/2;Yph4=(C+D)/2;Zph1=0.1;Zph2=0.11;Zph3=0.11;Zph4=0.1;alpha_0=0.0*pi/180;alpha_1=0*pi/180;alpha_2=0*pi/180;%实验结果中的小变形阶段图
Fy_Fz_0=[-u,-(-cos(theta_0+alpha_0)+u*sin(theta_0+alpha_0))/(sin(theta_0+alpha_0)+u*cos(theta_0+alpha_0)),-1/u,-(-u*cos(theta_0+alpha_0)+sin(theta_0+alpha_0))/(u*sin(theta_0+alpha_0)+cos(theta_0+alpha_0)),1/u,(-u*cos(theta_0-alpha_0)+sin(theta_0-alpha_0))/(u*sin(theta_0-alpha_0)+cos(theta_0-alpha_0)),u,(-cos(theta_0-alpha_0)+u*sin(theta_0-alpha_0))/(sin(theta_0-alpha_0)+u*cos(theta_0-alpha_0))];
Mx_CFz_0=[abs(Yph1)/C,-(C+D)/(2*C),-(abs(Zph2)+u*(C-D))/(2*u*C),-(C-D)/(2*C),(abs(Zph3)+u*(C-D))/(2*u*C),(C-D)/(2*C),-abs(Yph4)/C,(C+D)/(2*C)];
Fy_Fz_1=[1/u,-(-cos(theta_0+alpha_1)+u*sin(theta_0+alpha_1))/(sin(theta_0+alpha_1)+u*cos(theta_0+alpha_1)),-1/u,-(cos(theta_0+alpha_2)-u*sin(theta_0+alpha_2))/(sin(theta_0+alpha_2)+u*cos(theta_0+alpha_2)),1/u,(cos(theta_0-alpha_1)-u*sin(theta_0-alpha_1))/(sin(theta_0-alpha_1)+u*cos(theta_0-alpha_1)),-1/u,(-cos(theta_0-alpha_2)+u*sin(theta_0-alpha_2))/(sin(theta_0-alpha_2)+u*cos(theta_0-alpha_2))];
Mx_CFz_1=[(2*abs(Zph1)-u*(C+D))/(2*C*u),-(C+D)/(2*C),-(abs(Zph2)+u*(C-D))/(2*u*C),-(C-D)/(2*C),(abs(Zph3)+u*(C-D))/(2*u*C),(C-D)/(2*C),-(2*abs(Zph4)-u*(C+D))/(2*C*u),(C+D)/(2*C)];
% Fy_Fz_1=[-1/u,-1/u,1/u,1/u,-1/u];
% Mx_CFz_1=[(Zph2-(C+D)/2)/u,(u*(C-D)/2-Zph2)/u,-(Zph2-(C+D)/2)/u,-(u*(C-D)/2-Zph2)/u,(Zph2-(C+D)/2)/u];
% Fy_Fz_1=[-1/u,-1/u,1/u,1/u,-1/u];
% Mx_CFz_1=[-5,5,5,-5,-5];
Fy_Fz_01=[Fy_Fz_0(2),Fy_Fz_0(4),Fy_Fz_0(8),Fy_Fz_0(6),Fy_Fz_0(2)];
Mx_CFz_01=[Mx_CFz_0(2),Mx_CFz_0(4),Mx_CFz_0(8),Mx_CFz_0(6),Mx_CFz_0(2)];
Fy_Fz_02=[Fy_Fz_0(2),Fy_Fz_0(3),Fy_Fz_0(8),Fy_Fz_0(5),Fy_Fz_0(2)];
Mx_CFz_02=[Mx_CFz_0(2),Mx_CFz_0(3),Mx_CFz_0(8),Mx_CFz_0(5),Mx_CFz_0(2)];
Fy_Fz_11=[Fy_Fz_1(2),Fy_Fz_1(6),Fy_Fz_1(7),Fy_Fz_1(3),Fy_Fz_1(2),Fy_Fz_1(7),Fy_Fz_1(3),Fy_Fz_1(6)];
Mx_CFz_11=[Mx_CFz_1(2),Mx_CFz_1(6),Mx_CFz_1(7),Mx_CFz_1(3),Mx_CFz_1(2),Mx_CFz_1(7),Mx_CFz_1(3),Mx_CFz_1(6)];
Fy_Fz_12=[Fy_Fz_1(4),Fy_Fz_1(8),Fy_Fz_1(5),Fy_Fz_1(1),Fy_Fz_1(4),Fy_Fz_1(5),Fy_Fz_1(8),Fy_Fz_1(1)];
Mx_CFz_12=[Mx_CFz_1(4),Mx_CFz_1(8),Mx_CFz_1(5),Mx_CFz_1(1),Mx_CFz_1(4),Mx_CFz_1(5),Mx_CFz_1(8),Mx_CFz_1(1)];
Fy_Fz_13=[Fy_Fz_1(2),Fy_Fz_1(4),Fy_Fz_1(6),Fy_Fz_1(8),Fy_Fz_1(2),Fy_Fz_1(5),Fy_Fz_1(3),Fy_Fz_1(8),Fy_Fz_1(2),Fy_Fz_1(1),Fy_Fz_1(7),Fy_Fz_1(8),Fy_Fz_1(5),Fy_Fz_1(6),Fy_Fz_1(3),Fy_Fz_1(4),Fy_Fz_1(6),Fy_Fz_1(1),Fy_Fz_1(7),Fy_Fz_1(4),Fy_Fz_1(3),Fy_Fz_1(1),Fy_Fz_1(7),Fy_Fz_1(5)];
Mx_CFz_13=[Mx_CFz_1(2),Mx_CFz_1(4),Mx_CFz_1(6),Mx_CFz_1(8),Mx_CFz_1(2),Mx_CFz_1(5),Mx_CFz_1(3),Mx_CFz_1(8),Mx_CFz_1(2),Mx_CFz_1(1),Mx_CFz_1(7),Mx_CFz_1(8),Mx_CFz_1(5),Mx_CFz_1(6),Mx_CFz_1(3),Mx_CFz_1(4),Mx_CFz_1(6),Mx_CFz_1(1),Mx_CFz_1(7),Mx_CFz_1(4),Mx_CFz_1(3),Mx_CFz_1(1),Mx_CFz_1(7),Mx_CFz_1(5)];
Fy_Fz_21=[Fy_Fz_1(2),Fy_Fz_1(6),Fy_Fz_1(8),Fy_Fz_1(4),Fy_Fz_1(2)];
Mx_CFz_21=[Mx_CFz_1(2),Mx_CFz_1(6),Mx_CFz_1(8),Mx_CFz_1(4),Mx_CFz_1(2)];
Fy_Fz_22=[Fy_Fz_1(2),Fy_Fz_1(3),Fy_Fz_1(8),Fy_Fz_1(5),Fy_Fz_1(2)];% paper 中的图
Mx_CFz_22=[Mx_CFz_1(2),Mx_CFz_1(3),Mx_CFz_1(8),Mx_CFz_1(5),Mx_CFz_1(2)];
Fy_Fz_23=[Fy_Fz_1(2),Fy_Fz_1(7),Fy_Fz_1(8),Fy_Fz_1(1),Fy_Fz_1(2)];
Mx_CFz_23=[Mx_CFz_1(2),Mx_CFz_1(7),Mx_CFz_1(8),Mx_CFz_1(1),Mx_CFz_1(2)];
Fy_Fz_24=[Fy_Fz_1(6),Fy_Fz_1(3),Fy_Fz_1(4),Fy_Fz_1(5),Fy_Fz_1(6)];
Mx_CFz_24=[Mx_CFz_1(6),Mx_CFz_1(3),Mx_CFz_1(4),Mx_CFz_1(5),Mx_CFz_1(6)];
Fy_Fz_25=[Fy_Fz_1(6),Fy_Fz_1(7),Fy_Fz_1(4),Fy_Fz_1(1),Fy_Fz_1(6)];
Mx_CFz_25=[Mx_CFz_1(6),Mx_CFz_1(7),Mx_CFz_1(4),Mx_CFz_1(1),Mx_CFz_1(6)];
Fy_Fz_26=[Fy_Fz_1(3),Fy_Fz_1(7),Fy_Fz_1(5),Fy_Fz_1(1),Fy_Fz_1(3)];
Mx_CFz_26=[Mx_CFz_1(3),Mx_CFz_1(7),Mx_CFz_1(5),Mx_CFz_1(1),Mx_CFz_1(3)];
%% **********************画卡阻图*****************************
figure;
plot(Fy_Fz(91:N/4+90),Mx_CFz(91:N/4+90),'om','linewidth',2);
hold on;
plot(Fy_Fz(N/4+90+1:2*N/4+90),Mx_CFz(N/4+90+1:2*N/4+90),'*b','linewidth',2);
hold on;
plot(Fy_Fz(2*N/4+90+1:3*N/4+90),Mx_CFz(2*N/4+90+1:3*N/4+90),'xy','linewidth',2);
hold on;
plot(Fy_Fz(3*N/4+90+1:4*N/4+90),Mx_CFz(3*N/4+90+1:4*N/4+90),'+g','linewidth',2);
hold on;
% plot(Fy_Fz_01,Mx_CFz_01,'r.-','linewidth',2);
% % text_01={'\fontsize{15}H1','\fontsize{15}H2','\fontsize{15}H4','\fontsize{15}H3','\fontsize{15}H1'};
% % text(Fy_Fz_01,Mx_CFz_01,text_01);
% hold on;
% plot(Fy_Fz_02,Mx_CFz_02,'b.-','linewidth',2);
% % text_02={'\fontsize{15}H1','\fontsize{15}P2','\fontsize{15}H4','\fontsize{15}P3','\fontsize{15}H1'};
% % text(Fy_Fz_02,Mx_CFz_02,text_02);
% hold on;
% plot(Fy_Fz_21,Mx_CFz_21,'r*-','linewidth',2);
% % text_26={'H1','H3','H4','H2','H1'};
% % text(Fy_Fz_21,Mx_CFz_21,text_26);
% hold on;
plot(Fy_Fz_22,Mx_CFz_22,'g.-','linewidth',2);% paper中的图
hold on;
% plot(Fy_Fz_23,Mx_CFz_23,'k*-','linewidth',2);
% hold on;
% plot(Fy_Fz_24,Mx_CFz_24,'b*-','linewidth',2);
% hold on;
% plot(Fy_Fz_25,Mx_CFz_25,'c*-','linewidth',2);
% hold on;
% plot(Fy_Fz_26,Mx_CFz_26,'m*-','linewidth',2);
% % text_26={'P2','P4','P3','P1','P2'};
% % text(Fy_Fz_26,Mx_CFz_26,text_26);
% hold on;

% plot(Fy_Fz_1,Mx_CFz_1,'.r','linewidth',2);
title('\fontsize{15}Jamming diagram');
ylabel('\fontsize{15}Mx/DFz');
xlabel('\fontsize{15}Fy/Fz');
%axis([-11,11,-1,1]);%控制坐标轴范围
legend('\fontsize{10}1','\fontsize{10}2','\fontsize{10}3','\fontsize{10}4');