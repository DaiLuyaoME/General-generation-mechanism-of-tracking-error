function [delta,forwardOrder] = calculateDelta(ma,mj,md,Ts,methodType)
z = tf('z',Ts);
switch lower(methodType)
    case 'zpetc'
        delta = ma * z * ((1-z^-1)/Ts)^2 + mj * z * (z+1) * 0.5 * ((1-z^-1)/Ts)^3 + md * z^2 * ((1-z^-1)/Ts)^4;
    otherwise
        
end
forwardOrder = numel(zero(delta))  - numel(pole(delta));
delta = delta * z^(-1 * forwardOrder);



end
