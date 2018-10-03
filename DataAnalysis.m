clear;
clc;
close all;
%% draw the successful rate
vec_dPosition_peg = [];
for num = 6:55
    filePosition= 'saveData\experiment_';
    fileNum= num2str(num);
    fileName = [filePosition fileNum];
    load(fileName,'dPosition_peg');
    load(fileName,'Force_peg');
    load(fileName,'runTime');
    vec_dPosition_peg(num - 5,:,:) = dPosition_peg(1:43,:);
    vec_forcePeg(num - 5,:,:) = Force_peg(1:43,:);
end

figure;
[X,Y] = meshgrid(1:50,runTime);
color = ['r','g','b','k','m','c'];
p = [];
f = [];
for i = 1:3
    p(:,i) = plot3(X,Y,vec_dPosition_peg(:,:,i),color(i),'linewidth',2);
    hold on;
end
L_p1=legend(p(1,:),'X','Y','Z');
set(L_p1,'Location','best');
figure;
for i = 1:6
    f(:,i) = plot3(X,Y,vec_forcePeg(:,:,i),color(i),'linewidth',2);
    hold on;
end
L_f1=legend(f(1,:),'Fx','Fy','Fz','Mx','My','Mz');
set(L_f1,'Location','best');

fig3 = figure;
set(fig3,'defaulttextinterpreter','latex');
X = reshape(X,[],1);
Y = reshape(Y,[],1);
posTitle = ['X','Y','Z'];
fontSize = 8;
for i = 1:3
    subplot(3,3,i)
    imagesc(Y,X,vec_dPosition_peg(:,:,i));
    colormap parula;
    h = colorbar;
    ylabel(h, 'Position/mm','FontSize',fontSize)
    title(posTitle(i),'defaulttextinterpreter','latex');
    xlabel('Time/s','FontSize',fontSize)
    ylabel('Trial Number','FontSize',fontSize)
end
forceTitle = ['Fx';'Fy';'Fz';'Mx';'My';'Mz'];
for i = 1:6
    subplot(3,3,i+3)
    imagesc(Y,X,vec_forcePeg(:,:,i));
    colormap parula;
    h = colorbar;
    if i <= 3
        ylabel(h, 'F/N','FontSize',fontSize)
    else
        ylabel(h, 'M/(N\cdotdm)','FontSize',fontSize)
    end
    title(forceTitle(i,:));
    xlabel('Time/s','FontSize',fontSize)
    ylabel('Trial Number','FontSize',fontSize)
end
% xlabel('\fontsize{15}Trial Number');
% ylabel('\fontsize{15}Times/s');
% zlabel('\fontsize{15}Position/mm');
% title('\fontsize{15}Peg Position');

%% draw the jamming factor
% figure;
% for num = 1:5
%     filePosition= 'saveData_SecondModify\experiment_';
%     fileNum= num2str(num);
%     fileName = [filePosition fileNum];
%     load(fileName,'ratio');
%     vecRatio(:,num) = ratio(1:49)';
%     subplot(5,1,num);
%     plot(vecRatio(:,num));
% end