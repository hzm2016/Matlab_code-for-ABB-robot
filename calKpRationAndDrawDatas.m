function [ratio,Fy_FzRatio,Mx_CFzRatio] = ...
    calKpRationAndDrawDatas(forcePeg,relativePegPos,jammingPoints,isDrawDatas,minRatio)
[length,~]= size(forcePeg);
%% draw the force and postions
if(isDrawDatas)
    % draw force pegs
    subplot(1,3,1);
    plot(forcePeg(:,1),'r','linewidth',2);
    hold on;
    plot(forcePeg(:,2),'b','linewidth',2);
    hold on;
    plot(forcePeg(:,3),'m','linewidth',2);
    hold on;
    plot(10*forcePeg(:,4),'k','linewidth',2);
    hold on;
    plot(10*forcePeg(:,5),'y','linewidth',2);
    hold on;
    plot(10*forcePeg(:,6),'g','linewidth',2);
    hold on;
    %plot(qz,'.g','linewidth',2); plot(1000*L,'.r','linewidth',2);
    axis([1,length+5,-100,100]);%control the axis range
    ylabel('\fontsize{15}F/N(N/dm)');
    xlabel('\fontsize{15}Moving number');
    title('\fontsize{15}Contact Force');
    L_F1=legend('Fx','Fy','Fz','Mx','My','Mz');
    set(L_F1,'Location','SouthWest');
    % draw positions
    subplot(1,3,2);
    plot(relativePegPos(:,1),'r','linewidth',2);
    hold on;
    plot(relativePegPos(:,2),'b','linewidth',2);
    hold on;
    plot(relativePegPos(:,3),'m','linewidth',2);
    %axis([1,20,-3,3]);%control the axis range
    axis([1,length+5,-100,5]);%control the axis range
    ylabel('\fontsize{15}Position/mm');
    xlabel('\fontsize{15}Moving number');
    title('\fontsize{15}Peg Position');
    L_p1=legend('X','Y','Z');
    set(L_p1,'Location','SouthWest');
end
%% ****************** calculate the jamming states ***********************%
%jamming state paras
if relativePegPos(length,3)>(-5)
    theta=1*pi/180;
else
    theta=0.01*pi/180;
end
D=0.03;C=0.2;u=0.1;
Yph1=-(C+D)/2;Yph4=(C+D)/2;Zph1=0.1;
Zph4=0.1;
alpha_0=0.0;alpha_1=0;alpha_2=0;
Mx_CFz(length)=5*(forcePeg(length,4)+forcePeg(length,2)*0.144)/forcePeg(length,3);
Mx_CFz(length)=Mx_CFz(length)+0.001*forcePeg(length,2)*relativePegPos(length,3);
Fy_Fz(length)=forcePeg(length,2)/forcePeg(length,3);
Zph2=abs(0.001*relativePegPos(length,3))-0.001+(C-D)*sin(theta)/2;Zph3=Zph2;
Fy_Fz_0=[-u,-(-cos(theta+alpha_0)+u*sin(theta+alpha_0))/(sin(theta+alpha_0)...
    +u*cos(theta+alpha_0)),-1/u,-(-u*cos(theta+alpha_0)...
    +sin(theta+alpha_0))/(u*sin(theta+alpha_0)+cos(theta+alpha_0)),...
    1/u,(-u*cos(theta-alpha_0)+sin(theta-alpha_0))/(u*sin(theta-alpha_0)...
    +cos(theta-alpha_0)),u,(-cos(theta-alpha_0)...
    +u*sin(theta-alpha_0))/(sin(theta-alpha_0)+u*cos(theta-alpha_0))];
Mx_CFz_0=[abs(Yph1)/C,-(C+D)/(2*C),-(abs(Zph2)+u*(C-D))/(2*u*C),...
    -(C-D)/(2*C),(abs(Zph3)+u*(C-D))/(2*u*C),(C-D)/(2*C),-abs(Yph4)/C,(C+D)/(2*C)];
Fy_Fz_1=[1/u,-(-cos(theta+alpha_1)+u*sin(theta+alpha_1))/(sin(theta+alpha_1)...
    +u*cos(theta+alpha_1)),-1/u,-(cos(theta+alpha_2)...
    -u*sin(theta+alpha_2))/(sin(theta+alpha_2)+u*cos(theta+alpha_2)),...
    1/u,(cos(theta-alpha_1)-u*sin(theta-alpha_1))/(sin(theta-alpha_1)...
    +u*cos(theta-alpha_1)),-1/u,(-cos(theta-alpha_2)...
    +u*sin(theta-alpha_2))/(sin(theta-alpha_2)+u*cos(theta-alpha_2))];
Mx_CFz_1=[(2*abs(Zph1)-u*(C+D))/(2*C*u),-(C+D)/(2*C),...
    -(abs(Zph2)+u*(C-D))/(2*u*C),-(C-D)/(2*C),(abs(Zph3)+u*(C-D))/(2*u*C),...
    (C-D)/(2*C),-(2*abs(Zph4)-u*(C+D))/(2*C*u),(C+D)/(2*C)];
Fy_Fz_22=[Fy_Fz_1(2),Fy_Fz_1(3),Fy_Fz_1(8),Fy_Fz_1(5),Fy_Fz_1(2)];
Mx_CFz_22=[Mx_CFz_1(2),Mx_CFz_1(3),Mx_CFz_1(8),Mx_CFz_1(5),Mx_CFz_1(2)];
Fy_Fz_01=[Fy_Fz_0(2),Fy_Fz_0(4),Fy_Fz_0(8),Fy_Fz_0(6),Fy_Fz_0(2)];
Mx_CFz_01=[Mx_CFz_0(2),Mx_CFz_0(4),Mx_CFz_0(8),Mx_CFz_0(6),Mx_CFz_0(2)];
if (forcePeg(length,3)>0)||(abs(Mx_CFz(length))>15)||(abs(Fy_Fz(length))>15)
    Mx_CFz(length)=0;
    Fy_Fz(length)=0;
end

%% draw the jamming states
if(isDrawDatas)
    subplot(1,3,3);
    plot(jammingPoints(1,:),jammingPoints(2,:),'or','linewidth',2);
    hold on;
    if relativePegPos(length,3)>(-5)
        %paper plot  in large deformation
        plot(Fy_Fz_01,Mx_CFz_01,'k.-','linewidth',2);
    else
        %paper plot in small deformation
        plot(Fy_Fz_22,Mx_CFz_22,'b.-','linewidth',2);
    end
    hold off;
    title('\fontsize{15}Jamming diagram');
    ylabel('\fontsize{15}Mx/DFz');
    xlabel('\fontsize{15}Fy/Fz');
end
%% 
Fy_FzRatio = Fy_Fz(length);
Mx_CFzRatio = Mx_CFz(length);
inputPoint = [Fy_FzRatio,Mx_CFzRatio];
inputQuad = [0,0,0,0,0,0,0,0];
for r=1:4
    inputQuad(2*r-1) = Fy_Fz_22(r);
    inputQuad(2*r) = Mx_CFz_22(r);
end
ratio = (1-minRatio) * calJammingRatio(inputPoint,inputQuad) + minRatio;
% drawnow;
end

