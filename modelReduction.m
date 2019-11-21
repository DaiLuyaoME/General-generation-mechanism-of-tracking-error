%%
figure;
pzmap(GpDis);
%%
tol = 1e-3;
tempGp = minreal(GpDis,tol);
figure;
pzmap(tempGp);
%%
figure;
bodeplot(GpDis,tempGp);