
%% 绘制位移误差
% tempSignal = 
plotError(Err.time,Err.signals.values*1e9,'tracking error');
xlim([acc.time(1),acc.time(end)]);
hold on;
temp1=max(abs(Err.signals.values*1e9));
temp2=max(abs(acc.signals.values));
temp3=max(abs(snap.signals.values));
temp4=max(abs(jerk.signals.values));
temp5=max(abs(vel.signals.values));
ratio=temp1/temp2;
ratio31=temp1/temp3;
ratio41 = temp1/temp4;
ratio51 = temp1/temp5;
% plot(acc.time,ratio*acc.signals.values,'--','DisplayName','scaled acceleration','LineWidth',2);
plot(snap.time,ratio31*snap.signals.values,'--','DisplayName','scaled snap','LineWidth',2);
% plot(jerk.time,ratio41*jerk.signals.values,'--','DisplayName','scaled jerk','LineWidth',2);
% plot(vel.time,ratio51* vel.signals.values,'--','DisplayName','scaled velocity','LineWidth',2);
legend1 = legend(gca,'show');
% set(legend1,'FontName','Times New Roman');
% xlim([0,0.11]);
%% 绘制位移误差(因果情况)
% tempSignal = 
plotError(Err1.time,Err1.signals.values*1e9,'tracking error');
xlim([acc.time(1),acc.time(end)]);
hold on;
temp1=max(abs(Err1.signals.values*1e9));
temp2=max(abs(acc.signals.values));
temp3=max(abs(snap.signals.values));
temp4=max(abs(jerk.signals.values));
temp5=max(abs(vel.signals.values));
ratio=temp1/temp2;
ratio31=temp1/temp3;
ratio41 = temp1/temp4;
ratio51 = temp1/temp5;
% plot(acc.time,ratio*acc.signals.values,'--','DisplayName','scaled acceleration','LineWidth',2);
plot(snap.time,ratio31*snap.signals.values,'--','DisplayName','scaled snap','LineWidth',2);
% plot(jerk.time,ratio41*jerk.signals.values,'--','DisplayName','scaled jerk','LineWidth',2);
% plot(vel.time,ratio51* vel.signals.values,'--','DisplayName','scaled velocity','LineWidth',2);
legend1 = legend(gca,'show');
% set(legend1,'FontName','Times New Roman');
xlim([0,0.11]);





%% 绘制速度误差
plotVelError(velErr.time,velErr.signals.values * 1000,'velocity error');
hold on;
temp1=max(abs(velErr.signals.values * 1000));
temp2=max(abs(acc.signals.values));
temp3=max(abs(snap.signals.values));
temp4=max(abs(jerk.signals.values));
ratio=0.5*temp1/temp2;
ratio31=temp1/temp3;
ratio41 = temp1/temp4;
% plot(acc.time,ratio*acc.signals.values,'DisplayName','scaled acceleration','LineWidth',2);
plot(snap.time,ratio31*snap.signals.values,'DisplayName','scaled snap','LineWidth',2);
% plot(jerk.time,ratio41*jerk.signals.values,'DisplayName','scaled jerk','LineWidth',2);
legend1 = legend(gca,'show');
xlim([0,0.2]);
%% 绘制位移和速度误差
plotError(Err.time,Err.signals.values*1e9,'tracking error');
hold on;
tempError=max(abs(Err.signals.values*1e9));
tempVelError = max(abs(velErr.signals.values * 1000));
tempAcc = max(abs(acc.signals.values));
ratio=tempError/tempVelError;
ratioAcc = tempError / tempAcc;


plot(velErr.time,ratio * velErr.signals.values * 1000,'DisplayName','scaled velocity error','LineWidth',2);
plot(acc.time,ratioAcc*acc.signals.values,'DisplayName','scaled acceleration','LineWidth',2);
legend1 = legend(gca,'show');
%% 绘制真实速度
plotVelError(velReal.time,velReal.signals.values * 1000,'Real Velocity');
legend1 = legend(gca,'show');
%% 绘制加速度误差
data = acc.signals.values - forceReal.signals.values/modelParameters.mass;
plotError(forceReal.time,data,'acceleration error');
ratioSnap = max(abs(data)) / max(abs(snap.signals.values));
hold on;
plot(snap.time,ratioSnap * snap.signals.values,'DisplayName','scaled snap','LineWidth',2);
legend1 = legend(gca,'show');
%% 绘制速度误差谐波分量
plotVelError(velErr.time,velErr.signals.values * 1000,'velocity error');
hold on;
temp1=max(abs(velErr.signals.values * 1000));
temp2=max(abs(acc.signals.values));
temp3=max(abs(snap.signals.values));
temp4=max(abs(jerk.signals.values));
ratio=0.5*temp1/temp2;
ratio31=temp1/temp3;
ratio41 = temp1/temp4;
% plot(acc.time,ratio*acc.signals.values,'DisplayName','scaled acceleration','LineWidth',2);
% plot(snap.time,ratio31*snap.signals.values,'DisplayName','scaled snap','LineWidth',2);
plot(jerk.time,ratio41*jerk.signals.values,'DisplayName','scaled jerk','LineWidth',2);
legend1 = legend(gca,'show');