% temp = impulse(GpDis,1);
T = feedback(series(GpDis,GcDis),1);
Tr = modelBasedFeedforward(T,'zmetc');
figure;bodeplot(T,1/Tr);
T = 1/Tr;
%% ��ȡ��λ������Ӧ
fs = 5000;
Ts = 1/fs;
sampleNum = 5000;
timeLength = sampleNum * Ts;
impRes = impulse(T,timeLength);
figure;plot(impRes);

%% ��ȡToeplitz����
numTraj = 2360; % �켣�����������
tempImp = impRes(1:numTraj);
tempZero = zeros(numTraj,1);
topT = toeplitz(tempImp,tempZero);
%% Toeplitz����Ԥ����



%%
u = feedbackControlSignalData(:,end);
u = filteredFBControlSignalShortStroke;
ilcFF = linsolve(topT,u);
figure;
plot(ilcFF);
%%
lambda = 20000;
L = inv(topT'*topT + lambda * eye(size(topT)) ) * topT';
tempilcFF = L * u;
tempilcFF = (topT'*topT + lambda * eye(size(topT)) ) \ (topT * u);
figure;
plot(tempilcFF);
%%
figure;plot([u,tempilcFF]);
%%
figure;
pwelch(ilcFF - mean(ilcFF),[],[],[],5000);
%%

