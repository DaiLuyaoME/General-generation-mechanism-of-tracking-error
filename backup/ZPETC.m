function F = ZPETC(G)
%%
[z,p,k,Ts] = zpkdata(G,'v');
% relativeDegree = numel(p) - numel(z);
bound = 0.999999;
index = abs(z) > bound;
nonminimumZero = z( index );
minimumZero = z( ~index );
F = zpk(p,minimumZero,1/k,Ts);
%%
for i = 1:numel(nonminimumZero)
   temp = tf( [-1 * nonminimumZero(i),1] ,1 ,Ts,'variable','z^-1');
   F = F * temp * (1 / (abs(1 - nonminimumZero(i))).^2 );
end


end