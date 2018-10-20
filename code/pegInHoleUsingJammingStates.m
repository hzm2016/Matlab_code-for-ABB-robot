% main control programming of delevering the pegs
%first step :connet the physical robot with the computer by TCP/IP
%interface
%% connectTcp
clear;
clc;
t=tcpip('192.168.125.1',1502,'NetworkRole','client');
fopen(t);
%% initilize movement
[position,eulerang,tcpInBase]=GetCalibTool(t);  
%get the postion and rotation of tcp
%relative move, the rotation unit is radian, so need to be careful
MoveToolTo(position+[0,0,0],eulerang+[0,0,0],50,t);
%% some useful matrixes between tcp and pegs, world and holes
holeInBase=[0.999997160774085,-0.00237707819939362,0.000166970587359760,530.938110000000;
    0.00237691877011176,0.999996725068206,0.000940345457567640,-42.9916;
    -0.000169205315229449,-0.000948341761213039,0.999999543935518,71.7999;
    0,0,0,1];
pegInTcp=[     -0.9782    0.2075    0.0110   -2.0075
    0.2074    0.9782   -0.0088    2.5508
   -0.0125   -0.0063   -0.9999  178.0121
         0         0         0    1.0000];
pegInBase=tcpInBase*pegInTcp;
%************** set controlling parameters and reference force
% force direction£º+Z(down), +Y(left), +X(far from ABB)*******
Kp=0.02;Kp_2=0.002;Kp_q=0.005;Kd=0.002;
Kd_2=0.0002;Ki=0;Ki_2=0;Kv=2;
Seteulerang(1,:)=[0,0,0];
refForceX=0;refForceY=0;refForceZ=-80;
calculateTime =[];
runTime = [];
calculateTime(1) = 0;
runTime(1) = 0;
forcePeg = [];
relativePegPos = [];
jammingPoints=[0;0];
%% align the pegs and holes manually
[position,eulerang,tcpInBase]=GetCalibTool(t);
pegInBase = tcpInBase*pegInTcp;
holeInBase = pegInBase;
%% align test
alignPegAndHole(t,holeInBase,pegInTcp,0);
%% calibrate the force sensor
CalibResult= CalibFCForce(t);
%% get force datas from force sensors
myForceVector_0= GetFCForce(t);%Forcedata(Fx,Fy,Fz,Mx,My,Mz)
%% main loop
% instering the pegs for 50 times
minRatio = 1;
% minRatio = 0.1;
% minRatio = 0.5;
for num=1:5
    k=0;n=150;
    %************ force control and instert the pegs *******************
    k=k+1;
    alignPegAndHole(t,holeInBase,pegInTcp,1);
    for i=1+n*(k-1):k*n
        %change control parameters here
        myForceVector= GetFCForce(t);
        forcePeg(i,:)=myForceVector
        for j=1:6
            if abs(myForceVector(1,j))<0.5
                myForceVector(1,j)=0;
            end
        end
        [position,eulerang,tcpInBase]=GetCalibTool(t);
        time0 =  clock;
        Position_peg(i,:)= position;
        EulerAngle_peg(i,:) = eulerang;
        relativePegPos(i,:)=Position_peg(i,:)-Position_peg(1,:)
        %RefForce=[Fx,Fy,Fz,Tx,Ty,Tz]
        RefForce=[refForceX,refForceY,refForceZ,0,0,0];
        %******* offset moment *********
        % the direction of Mx is the same as rotx, which of My and Mz are
        % adverse
        E_Force(i,:) = myForceVector - RefForce;
        if i<3
            SetPosition(i,1:2)=Kp_2*E_Force(i,1:2);
            SetPosition(i,3)=Kp*E_Force(i,3);
        else
            SetPosition(i,1:2)=SetPosition(i-1,1:2)+Kp_2*(E_Force(i,1:2) ...
                -E_Force(i-1,1:2)+Ki_2*E_Force(i,1:2)+Kd_2*(E_Force(i,1:2)...
                -2*E_Force(i-1,1:2)+E_Force(i-2,1:2)));
            SetPosition(i,3)=SetPosition(i-1,3)+Kp*(E_Force(i,3) ...
                -E_Force(i-1,3)+Ki*E_Force(i,3)+Kd*(E_Force(i,3) ...
                -2*E_Force(i-1,3)+E_Force(i-2,3)));
        end
        SetVel(i)=Kv*abs(sum(E_Force(i,:)));
        %************** adjust the pos **************
        if SetPosition(i,3)>0
            nextTcpInTcp=[rotx(0),[SetPosition(i,1);SetPosition(i,2);SetPosition(i,3)];
                0,0,0,1];
        else
            nextTcpInTcp=[rotx(0),[0;0;0];
                0,0,0,1];
        end
        nextTcpInBase=tcpInBase*nextTcpInTcp;
        [position_tz2(i,:),eulerang_tz2(i,:)] = MatrixToEuler(nextTcpInBase);
        if(i>1)
            calculateTime(i) = calculateTime(i-1) + etime(clock,time0);
            runTime(i) = runTime(i-1) + etime(clock,time0);
        end
        MoveToolTo(position_tz2(i,:),eulerang_tz2(i,:),SetVel(i),t);
        %***************** calKpRationAndDrawDatas **********%
        [ratio(i),Fy_FzRatio,Mx_CFzRatio] = ...
            calKpRationAndDrawDatas(forcePeg(1:i,:),relativePegPos(1:i,:), ...
            jammingPoints,0,minRatio);
        jammingPoints(1,i) = Fy_FzRatio;
        jammingPoints(2,i) = Mx_CFzRatio;
        Kp= 0.02 * ratio(i);
        Kp_2 = 0.002 * ratio(i);
        %**************** finish inserting ******************%
        if relativePegPos(i,3)<(-3)
            refForceZ=-120;
            refForceX=0;
            refForceY=0;
        end
        if (relativePegPos(i,3)<(-96) || max(abs(myForceVector(1:3)))>70 ...
                || max(abs(myForceVector(4:6)))>5)
            break;
        end
    end
    K=i;
    disp('Finish inserting!');
    % ***************** extract the pegs ****************
    for i=1+K:K+n
        [position,eulerang,~]=GetCalibTool(t);
        Position_peg(i,:)=position;
        EulerAngle_peg(i,:) = eulerang;
        relativePegPos(i,:)=Position_peg(i,:)-Position_peg(1,:);
        %relative move, the rotation unit is radian, so need to be careful
        MoveToolTo(position+[0,0,20],eulerang,50,t);
        % **************** Finish extracting ******************%
        if relativePegPos(i,3)>(-20)
            disp('Finish extracting!');
            break;
        end
    end
    % ***************** save the datas ****************
%     filePosition= 'saveData_PTFE\experiment_';
    filePosition= 'saveData_ABS\experiment_';
    fileNum= num2str(num);
    minRatioStr = num2str(minRatioStr*10);
    fileName = [filePosition,minRatioStr,'_',fileNum];
    save(fileName);
    disp('Saving datas successfully!');
    % ***************** draw the datas ****************
    calKpRationAndDrawDatas(forcePeg(1:K,:),relativePegPos(1:K,:), ...
        jammingPoints,1,minRatio);
    figure;
    plot(ratio);
end

