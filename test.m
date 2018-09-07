fs = 5000;
Ts = 1/fs;
tempG = tf(1,[1,0,0]);
tempGDis = c2d(tempG,Ts,'zoh');
%%
tempF = ZPETC(tempGDis);
%%
z = tf('z',Ts);
tempF = z^2 * (1-z^-1)^-2;
%%
tempDelta = calculateDelta(1,0,0,Ts,'zpetc');
%%
z = tf('z',Ts);
tempG = (1-0.9772*z^-1)*(1 - 0.127*z^-1 + 0.02029*z^-2);