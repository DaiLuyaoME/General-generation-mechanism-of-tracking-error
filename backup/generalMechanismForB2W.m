%%
GpDis = plantFitDis;
%%
numGc = [];
denGc = [];
GcDis = tf(numGc,denGc,1/5000);
%%
[z,p,k,Ts] = zpkdata(GpDis,'v');
tempG = zpk(z,p,k,Ts);
figure;bodeplot(tempG,GpDis);
figure;pzmap(tempG,GpDis);
%%
tol = 1e-4;
reducedPlantDis = minreal(tempG,tol);
figure;pzmap(reducedPlantDis);
figure;bodeplot(reducedPlantDis,tempG);
%%
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
