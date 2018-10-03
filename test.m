clc;
jammingPoints=[0;0];
[length,~] = size(Force_peg);
ratio = 1;
for i = 1:length
    [ratio(i),Fy_FzRatio,Mx_CFzRatio] = ...
        calKpRationAndDrawDatas(Force_peg(1:i,:),dPosition_peg(1:i,:), ...
        jammingPoints,0);
    jammingPoints(1,i) = Fy_FzRatio;
    jammingPoints(2,i) = Mx_CFzRatio;
end
calKpRationAndDrawDatas(Force_peg(1:length,:),dPosition_peg(1:length,:), ...
    jammingPoints,1);
figure;
plot(ratio);

