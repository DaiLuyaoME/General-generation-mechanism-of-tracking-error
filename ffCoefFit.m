%% standard zpetc
% fit acc coef
errorData = Err.signals.values;
accData = acc.signals.values;
dataTime = Err.time;

startTime = 0.022;
endTime = 0.047;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = accData(timeInterval);

accCoefEstimated = inv(A'*A)*A'*b;
%% standard zpetc
% fit snap
errorData = Err.signals.values;
snapData = snap.signals.values;
dataTime = Err.time;

startTime = 0.015;
endTime = 0.036;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = snapData(timeInterval);

snapCoefEstimated = inv(A'*A)*A'*b;
%% standard zmetc
% fit vel ff
errorData = Err.signals.values;
velData = vel.signals.values;
dataTime = Err.time;

startTime = 0.037;
endTime = 0.066;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = velData(timeInterval);

velCoefEstimated = inv(A'*A)*A'*b;

%% standard zmetc
% fit acc ff
errorData = Err.signals.values;
accData = acc.signals.values;
dataTime = Err.time;

startTime = 0.022;
endTime = 0.046;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = accData(timeInterval);

accCoefEstimated = inv(A'*A)*A'*b;

%% standard zmetc
% fit jerk ff
errorData = Err.signals.values;
jerkData = jerk.signals.values;
dataTime = Err.time;

startTime = 0.004;
endTime = 0.014;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = jerkData(timeInterval);

jerkCoefEstimated = inv(A'*A)*A'*b;

%% standard zmetc
% fit snap ff
errorData = Err.signals.values;
snapData = snap.signals.values;
dataTime = Err.time;

startTime = 0.018;
endTime = 0.036;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = snapData(timeInterval);

snapCoefEstimated = inv(A'*A)*A'*b;
%% standard Ignore
% fit vel ff
errorData = Err.signals.values;
velData = vel.signals.values;
dataTime = Err.time;

startTime = 0.037;
endTime = 0.066;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = velData(timeInterval);

velCoefEstimated = inv(A'*A)*A'*b;
%% standard Ignore
% fit acc ff
errorData = Err.signals.values;
accData = acc.signals.values;
dataTime = Err.time;

startTime = 0.022;
endTime = 0.046;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = accData(timeInterval);

accCoefEstimated = inv(A'*A)*A'*b;
%% standard Ignore
% fit jerk ff
errorData = Err.signals.values;
jerkData = jerk.signals.values;
dataTime = Err.time;

startTime = 0.004;
endTime = 0.014;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = jerkData(timeInterval);

jerkCoefEstimated = inv(A'*A)*A'*b;
%% standard Ignore
% fit snap ff
errorData = Err.signals.values;
snapData = snap.signals.values;
dataTime = Err.time;

startTime = 0.018;
endTime = 0.036;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = snapData(timeInterval);

snapCoefEstimated = inv(A'*A)*A'*b;
%% causal zpetc
% fit vel ff
errorData = Err1.signals.values;
velData = vel.signals.values;
dataTime = Err1.time;

startTime = 0.037;
endTime = 0.066;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = velData(timeInterval);

velCoefEstimated = inv(A'*A)*A'*b;
%% causal zpetc
% fit acc ff
errorData = Err1.signals.values;
velData = acc.signals.values;
dataTime = Err1.time;

startTime = 0.018;
endTime = 0.02;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = velData(timeInterval);

velCoefEstimated = inv(A'*A)*A'*b;
%% causal zpetc
% fit jerk ff
errorData = Err1.signals.values;
velData = jerk.signals.values;
dataTime = Err1.time;

startTime = 0.005;
endTime = 0.012;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = velData(timeInterval);

velCoefEstimated = inv(A'*A)*A'*b;
%% causal zpetc
% fit snap ff
errorData = Err1.signals.values;
velData = snap.signals.values;
dataTime = Err1.time;

startTime = 0.004;
endTime = 0.012;

beginIndex = find(dataTime > startTime);
endIndex = find(dataTime > endTime);


timeInterval = beginIndex:endIndex;

b = errorData(timeInterval);
A = velData(timeInterval);

velCoefEstimated = inv(A'*A)*A'*b;
