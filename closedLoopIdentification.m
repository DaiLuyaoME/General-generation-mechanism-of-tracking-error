close all;
stageType = 1; % 1 for short stroke stage; 2 for long stroke stage; 3 for short-long-coupling
axisID = 1; %1 for x; 2 for y; 3 for z; 4 for tx; 5 for ty; 6 for tz;
% pathName = 'F:\B2W\data\20170721\';
% pathName = 'D:\Dai\code\B2W\2018\20180613\微动台辨识结果\x1.txt';
dofName = {'x','y','z','tx','ty','tz'};
fileName = [dofName{axisID},'Data.txt'];
% data = load([pathName,fileName]); % 载入数据文件
data = load('D:\Dai\code\B2W\2018\实验数据\20180613\微动台辨识结果\x1.txt');
% data = load('x1.txt');

switch stageType
    case 1
        positionDataIndex = axisID;
        disturbanceIndex = 48;
        controlSignalIndex = 49;
    case 2
        positionDataIndex = axisID;
        disturbanceIndex = 83;
        controlSignalIndex = 84;
end
        
%% 辨识参数设置
disturbance = data(:,disturbanceIndex);
n = abs(disturbance) > 0;
disturbance = disturbance(n);
position=data(n,positionDataIndex);                
DA_input=data(n,controlSignalIndex);           
Ts=0.0002; % 采用周期
f_start = 80; % 辨识起始频率
f_end  = 1500; % 辨识截止频率
fit_order= 28; % 拟合阶次
%% 设置伯德图绘制偏好
Op=bodeoptions;
Op.FreqUnits='Hz';
Op.xlim={[f_start  f_end]};
Op.PhaseVisible = 'on';
Op.Grid='on';
Op.PhaseMatching='on';
Op.PhaseMatchingFreq=100;
Op.PhaseMatchingValue=-180;
%% 生成辨识频段
w_start = f_start*2*pi;
w_end  = f_end*2*pi;
lg_start = log10(w_start);
lg_end  = log10(w_end);
Num  = 1000;
w = logspace(lg_start,lg_end,Num);
% w = [logspace(log10(40*2*pi),log10(480*2*pi),300),logspace(log10(500*2*pi),log10(1300*2*pi),700)];
%%
y=position; % 系统输出
u=disturbance; % 扰动输入
x=DA_input; % 控制器总输出
y=y-mean(y);
u=u-mean(u);
x=x-mean(x);

sp_uy=spafdr(iddata(y,u,Ts),[],w);
sp_ux=spafdr(iddata(x,u,Ts),[],w);
sp_xy=spafdr(iddata(y,x,Ts),[],w); 
identifiedPlant = sp_uy/sp_ux;
figure;
% bode(identifiedPlant,sp_xy,Op);
bode(identifiedPlant,Op)
%%
[Resp,freq]=frdata(identifiedPlant);
Resp=squeeze(Resp);
Resp_Acc=Resp.*freq.*freq*(-1);
Gyy_Acc=frd(Resp_Acc,freq);

Gy_Acc_fit=fitfrd(Gyy_Acc,fit_order);
figure;bode(Gyy_Acc,Gy_Acc_fit);
plantFit=Gy_Acc_fit*tf([1],[1 0 0]);
figure; bode(identifiedPlant,plantFit,Op);
% plantFitDis = c2d(plantFit,Ts,'zoh');
plantFitDis = c2d(plantFit,Ts,'foh');
figure;bodeplot(identifiedPlant,plantFitDis,Op);


