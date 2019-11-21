%% traj1
s = 0.03;
v = 0.12;
acc = 3;
jerk = 2000;
snap = 20000;
Ts = 0.0002;

%% traj2
s = 0.03;
v = 0.12;
acc = 3;
jerk = 2000;
snap = 60000;
Ts = 0.0002;

%%

[t,dd] = make4(s,v,acc,jerk,snap,Ts);
t1 = t(1);
t2 = t(2);
t3 = t(3);
t4 = t(4);
snapCount = t1/Ts;
jerkCount = t2/Ts;
accCount  = t3/Ts;
velCount = t4/Ts;
snapBound = dd(4);
totalCount = 8*snapCount+4*jerkCount+2*accCount+velCount;

