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
%% zpetc delta parameters
mv = 0;
ma = -0.317710e-7;
% ma = 2.426e-9 + 1.5e-12 - 4.18e-14;
mj = 0;
% mj = 1.8e-10;
% md = 1.1523e-13;
md = 0;
% md = -3.48e-17;
%%
%% zmetc delta parameters
% % mv = 3.870517e-5;
% % ma = 4.6196e-9;
% % mj = 6.145758e-13;
% % % md = -9.773e-17;
% % md = 8.725741483e-17;
% % md = 0;
% mv = 3.870517e-5 + 7.16265e-12;
% % mv = 0;
% ma = -3.12141483e-9 - 5.75e-14;
% % ma = 0;
% mj = 3.1476828e-13;
% % mj = 0;
% % md = -9.773e-17;
% md = -3.485188377e-17 - 1.73e-18;
% % md = 0;
%% ignore delta parameters
% mv = 1.935266583e-5 - 7.732120920e-11;
% % mv = 0;
% ma = 3.337792642e-9 - 1.545e-12;
% % ma = 0;
% mj = 5.32483e-13;
% % mj = 0;
% md = 7.388642e-17;
% % md = 0;
%% 
[delta,forwardOrderD] = calculateDelta(mv,ma,mj,md,Ts,deltaMethod);
z = tf('z',Ts);
tempDelay = z^(-1 * forwardOrderD);
deltaCausal = delta * tempDelay;
%%
forwardOrder = forwardOrderD + forwardOrderF;

