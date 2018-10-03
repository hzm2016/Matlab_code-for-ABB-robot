theta(1)=0;FN_1(1)=0;FN_2(1)=0;
for i=2:90
%i=1;Force_peg(i,3)=-0.4997;Force_peg(i,2)=0.0125;Force_peg(i,4)=-0.287;
    if max(abs(State(i,:)))==0||Force_peg(i,3)>0
            theta(i+1)=theta(i);FN_1(i)=0;FN_2(i)=0;Error_force(i,:)=[0,0,0];
    else
            [FN_1(i),FN_2(i),theta(i+1),Error_force(i,:)]=Contact_force_theta(Force_peg(i,:),State(i,:),Peg(i,:),Hole(i,:));
%*************解析解************************%
%******************定义常量*********
%         Y_Peg_h=0.001*Peg(1:4);
%         Z_Peg_h=0.001*Peg(5:8);
%         Y_Hole_h=0.001*Hole(1:4);
%         u=0.1;alpha=2*pi/180;%金属和金属之间抹了润滑油后，摩擦系数约为0.1

%         D=30/1000;C=0.200;dz=0.144;
%         Zph2=0.001*abs(Peg(i,6));
%         Fy=Force_peg(i,2);Fz=Force_peg(i,3);Mx=Force_peg(i,4)+Fy*0.144;
%         KE=(Mx-Fz*(D+C)/2)/(u*D-Zph2)-Fy;
%         theta(i+1)=atan((Fz+u*Fy+2*u*KE)/(KE*(u^2-1)+(Fz+u*Fy)*u));
%         %theta(i+1)=atan((2*u*(Mx+(u*(C-D)/2+Zph2)*Fy)-(Zph2+u*C)*(u*Fy+Fz))/((Mx+(u*(C-D)/2+Zph2)*Fy)*(u^2-1)-((Zph2+u*(C-D)/2)*u-(D+C)/2)*(u*Fz+Fy)));
%         %theta(i+1)=atan(((2*u*Mx+u^2*(D+C)/2)*(u*Fy+Fz)-(Zph2+u*(C-D)/2)*(Fz-u*Fy))/(Mx*(u^2-1)-u*(D+C)/2*(u*Fy+Fz)-(Zph2+u*(C-D)/2)*(u*Fz+Fy)));
%         FN_1(i)=(u*Fy+Fz)/((u^2-1)*sin(theta(i+1))-2*u*cos(theta(i+1)));
%         FN_2(i)=Fy-u*FN_1(i)*sin(theta(i+1))+FN_1(i)*cos(theta(i+1));
%         
%         Ky_1=-1;Ky_2=cos(theta(i+1))-u*sin(theta(i+1));
%         Kz_1=u;Kz_2=u*cos(theta(i+1))+sin(theta(i+1));
%         Km_1=(u*abs(Y_Peg_h(2))+abs(Z_Peg_h(2)));Km_2=Kz_2*abs(Y_Hole_h(1));
%         F_y_1=-Ky_1*FN_1(i)-Ky_2*FN_2(i);
%         F_z_1=-Kz_1*FN_1(i)-Kz_2*FN_2(i);
%         M_x_1=-Km_1*FN_1(i)-Km_2*FN_2(i);%x(1)=FN_1,x(2)=FN_2,x(3)=theta
%         Error_force(i,:)=[Force_peg(i,2)-F_y_1,Force_peg(i,3)-F_z_1,Force_peg(i,4)+Force_peg(i,2)*dz-M_x_1];
    end
    if max(abs(State(i,5:8)))==0||abs(theta(i+1))>0.1|| max(abs([FN_1(i),FN_2(i)]))>10*max(abs(Force_peg(i,:)))
        theta(i+1)=theta(i);FN_1(i)=FN_1(i-1);FN_2(i)=FN_1(i-1);Error_force(i,:)=[0,0,0];
    end
end
%% **********************画受力状态图*****************************
figure;
plot(Force_peg(:,1),'r','linewidth',2);
hold on;
plot(Force_peg(:,2),'b','linewidth',2);
hold on;
plot(Force_peg(:,3),'m','linewidth',2);
hold on;
plot(10*Force_peg(:,4),'k','linewidth',2);
hold on;
plot(10*Force_peg(:,5),'y','linewidth',2);
hold on;
plot(10*Force_peg(:,6),'g','linewidth',2);
hold on;
%plot(qz,'.g','linewidth',2);
%plot(1000*L,'.r','linewidth',2);
axis([1,n*k,-50,50]);%控制坐标轴范围
ylabel('\fontsize{15}F/N(N/dm)');
xlabel('\fontsize{15}Moving number');
title('\fontsize{15}Contact Force');
legend('Fx','Fy','Fz','Mx','My','Mz');
%******************************画接触位置移动图********************
figure ;
plot(dPosition_peg(:,1),'r','linewidth',2);
hold on;
plot(dPosition_peg(:,2),'b','linewidth',2);
hold on;
plot(dPosition_peg(:,3),'m','linewidth',2);
%axis([1,20,-3,3]);%控制坐标轴范围
ylabel('\fontsize{20}mm');
xlabel('\fontsize{15}Moving number');
title('\fontsize{20}Peg Position');
legend('X','Y','Z');
%******************************画接触状态图******************************
figure;
subplot(4,2,1);
plot(State(:,1),'r','linewidth',2);
ylabel('\fontsize{20}P1');
title('\fontsize{20}接触状态：接触→1；未接触→0');
axis([1,1.1*k*n,-1,2]);%控制坐标轴范围
subplot(4,2,3);
plot(State(:,2),'r','linewidth',2);
ylabel('\fontsize{20}P2');
axis([1,1.1*k*n,-1,2]);%控制坐标轴范围
subplot(4,2,5);
plot(State(:,3),'r','linewidth',2);
ylabel('\fontsize{20}P3');
axis([1,1.1*k*n,-1,2]);%控制坐标轴范围
subplot(4,2,7);
plot(State(:,4),'r','linewidth',2);
ylabel('\fontsize{20}P4');
axis([1,1.1*k*n,-1,2]);%控制坐标轴范围
subplot(4,2,2);
plot(State(:,5),'b','linewidth',2);
ylabel('\fontsize{20}H1');
title('\fontsize{20}接触状态：接触→1；未接触→0');
axis([1,1.1*k*n,-1,2]);%控制坐标轴范围
subplot(4,2,4);
plot(State(:,6),'b','linewidth',2);
ylabel('\fontsize{20}H2');
axis([1,1.1*k*n,-1,2]);%控制坐标轴范围
subplot(4,2,6);
plot(State(:,7),'b','linewidth',2);
ylabel('\fontsize{20}H3');
axis([1,1.1*k*n,-1,2]);%控制坐标轴范围
subplot(4,2,8);
plot(State(:,8),'b','linewidth',2);
ylabel('\fontsize{20}H4');
axis([1,1.1*k*n,-1,2]);%控制坐标轴范围
%******************************画接触力图******************************
figure;
subplot(3,1,1);
plot(FN_1,'r','linewidth',2);
ylabel('\fontsize{20}FN_1/N');
title('\fontsize{20}接触力变化大小');
%axis([1,1.1*k*n,-50,50]);%控制坐标轴范围
subplot(3,1,2);
plot(FN_2,'b','linewidth',2);
ylabel('\fontsize{20}FN_2/N');
%axis([1,1.1*k*n,-50,50]);%控制坐标轴范围
subplot(3,1,3);
plot(theta,'b','linewidth',2);
ylabel('\fontsize{20}theta');
title('\fontsize{20}倾斜角变化大小');
axis([1,1.1*k*n,-0.1,0.1]);%控制坐标轴范围
%*******************接触力反解误差**********
figure;
plot(Error_force(:,1),'b','linewidth',2);
hold on;
plot(Error_force(:,2),'r','linewidth',2);
hold on;
plot(Error_force(:,3),'k','linewidth',2);
axis([1,100,-10,10]);%控制坐标轴范围