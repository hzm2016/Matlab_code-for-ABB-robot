function [SetResult,Position_peg,Force_peg]= SetFCForce(RefForce,myForceVector_0,t,k,n)
    SetPosition=[];Seteulerang=[];SetVel=[];
    Seteulerang(1,:)=[0,0,0];
    Kp=0.2;
    Kd=0;%0.1;
    Ki=0%0.5;
    Kv=5;
    for i=1+n*(k-1):k*n
        myForceVector= GetFCForce(t);%从力传感器中采集得到的力信息, Forcedata(Fx,Fy,Fz,Mx,My,Mz)
        Force_peg(i,:)=myForceVector;
        E_Force(i,:)=RefForce(1:3)-myForceVector(1:3);
        if i<(3+n*(k-1))
            SetPosition(i,:)=Kp*E_Force(i,:);
        else
            %x(i+1)=x(i)+Kp*(e(i)-e(i-1)+Ki*e(i)+Kd*(e(i)-2*e(i-1)+e(i-2)));
            SetPosition(i,:)=SetPosition(i-1,:)+Kp*(E_Force(i,:)-E_Force(i-1,:)+Ki*E_Force(i,:)+Kd*(E_Force(i,:)-2*E_Force(i-1,:)+E_Force(i-2,:)));
        end
        SetVel(i)=Kv*abs(sum(E_Force(i,:)));
        [position,eulerang,~]=GetCalibTool(t); 
        Position_peg(i,:)=position;
        MoveToolTo(position+SetPosition(i,:),eulerang+Seteulerang(1,:),SetVel(i),t);
        if sum(abs(RefForce(1:3)-myForceVector(1:3)))<0.1
            break
        end
    end
    SetResult=1
    %% 画受力状态图
figure;
plot(Force_peg(:,1),'r','linewidth',1);
hold on;
plot(Force_peg(:,2),'b','linewidth',1);
hold on;
plot(Force_peg(:,3),'m','linewidth',1);
%axis([1,20,-3,3]);%控制坐标轴范围
ylabel('\fontsize{20}F/N');
title('\fontsize{20}Contact Force');
legend('Fx','Fy','Fz');
end




