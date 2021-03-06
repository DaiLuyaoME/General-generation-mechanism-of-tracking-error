%% model parameters
modelTypeName = {'rigidBody','doubleMassNonColocated','doubleMassColocated'};
modelInfo.mass = [5,20];
modelInfo.fr = 700;
modelInfo.dampRatio = 0.03;
modelInfo.type = modelTypeName{2};
fs = 5000;
Ts = 1/fs;
Gp = createPlantModel(modelInfo);

%% delay factor
delayCount = 1.3;
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
ma = -1.060763943526000e-08;
mj = 0;
% md = 8.727045949187352e-17;
%%
%% zmetc delta parameters
mv = -1.875473607039328e-04;
ma = 3.634176340793483e-08;
mj = -7.316170835189614e-12;
md = 1.499481989941630e-15;
%% ignore delta parameters
mv = -9.377368045702400e-05;
ma = -1.028442326954372e-08;
mj = -1.171165138192156e-12;
md = -1.407155440488730e-16;
%% causal zpetc delta parameters
mv = 8.000000023540249e-04;
ma = 3.0939e-07;
mj = 7.1530e-11;
md = 1.2644e-14;
%% no compensation
mv = 0;
ma = 0;
mj = 0;
md = 0;
%% 
[delta,forwardOrderD] = calculateDelta(mv,ma,mj,md,Ts,deltaMethod);
z = tf('z',Ts);
tempDelay = z^(-1 * forwardOrderD);
deltaCausal = delta * tempDelay;
%%
forwardOrder = forwardOrderD + forwardOrderF;

