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
feedforwardType = feedforwardArchitectureTypeName{2};
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
[F,forwardOrder] = modelBasedFeedforward(G,feedforwardMethod);
z = tf('z',Ts);
tempDelay = z^(-1 * forwardOrder);
FCausal = F * tempDelay;
