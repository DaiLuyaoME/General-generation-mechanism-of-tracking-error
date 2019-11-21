%% define model parameters
modelInfo.type = 2;
modelInfo.mass = [5,20];
modelInfo.fr = 700;
modelInfo.damp = 0.06;
%%
s = tf('s');
delayModel = exp(-2*Ts*s);
delayModel = pade(delayModel,2);
%% generate plant model
Gp = createPlantModel(modelInfo) * delayModel;
fs = 5000;
Ts = 1/fs;
GpDis = c2d(Gp,Ts,'zoh');
%%
figure;
bodeplot(Gp);
%%
figure;
pzmap(GpDis);
% figure;
% zero(GpDis);
%%
% figure;
% pzmap(GpDis,temp1);
z = tf('z',Ts);
delayModel = z^-2;
