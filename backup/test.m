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
%%
[z,p,k,Ts] = zpkdata(plantFitDis,'v');
tempG = zpk(z,p,k,Ts);
figure;bodeplot(tempG,plantFitDis);
%%
y = -161;
f = 103;
w = f * 2 * pi;
temp = y/(-20) - 2 * log10(w);
m = 10^temp;
%%
temp = GpDis;
f_start = 1;
f_end  = 400;
w_start = f_start*2*pi;
w_end  = f_end*2*pi;
lg_start = log10(w_start);
lg_end  = log10(w_end);
Num  = 5000;
w = logspace(lg_start,lg_end,Num);
% [mag,phase,wout] = bode(1e-9 * temp,w);
[mag,phase,wout] = bode(temp,w);
mag = squeeze(mag);
mag = 20*log10(mag);
m = 10.^( mag/(-20) - 2 * log10(wout));
figure;plot(m);
%%
GpDis = 261.6 / 250 * GpDis;