%% model parameters
modelTypeName = {'rigidBody','doubleMassNonColocated','doubleMassColocated'};
modelInfo.mass = [5,20];
modelInfo.fr = 700;
modelInfo.dampRatio = 0.06;
modelInfo.type = modelTypeName{1};
fs = 5000;
Ts = 1/fs;
Gp = createPlantModel(modelInfo);

%% delay factor
delayCount = 2;
s = tf('s');
delayModel = exp(-delayCount*Ts*s);
delayModel = pade(delayModel,2);

%% generate plant model with delay
GpWithDelay = Gp * delayModel;
GpDis = c2d(GpWithDelay,Ts,'zoh');

%% generate G for calculation of F
feedforwardArchitectureTypeName = {'closedLoopFeedforward','plantInversionFeedforward'};
feedforwardType = feedforwardArchitectureTypeName{1};
switch feedforwardType
    case 'closedLoopFeedforward'
        G = feedback( minreal(  1 * GpDis * GcDis),1);
    case 'plantInversionFeedforward'
        G = minreal(GpDis);
    otherwise       
end

%% generate F
feedforwardMethodName = {'ZPETC','ZMETC','ignore','seriesTruncation'};
feedforwardMethod = feedforwardMethodName{1};
[F,forwardOrderF] = modelBasedFeedforward(G,feedforwardMethod);
z = tf('z',Ts);
tempDelay = z^(-1 * forwardOrderF);
FCausal = F * tempDelay;
%% generate delta
deltaMethodName = {'ZPETC','ZMETC','ignore','seriesTruncation'};
deltaMethod = deltaMethodName{1};
ma = 2.426e-9 + 1.5e-12 - 4.18e-14;
% ma = 0;
mj = 0;
md = -3.48e-17;
% md = 0;
[delta,forwardOrderD] = calculateDelta(ma,mj,md,Ts,deltaMethod);
z = tf('z',Ts);
tempDelay = z^(-1 * forwardOrderD);
deltaCausal = delta * tempDelay;
%%
forwardOrder = forwardOrderD + forwardOrderF;

