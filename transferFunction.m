function g = transferFunction(xEnv, R, t, k) 

 
% compute knee coefficients...
c0 = -((R - 1.0) * (t * t - k * t + k * k / 4.0)) / (2.0 * k * R);
c1 = ((R - 1) * t + (R + 1) * k / 2.0) / (k * R);
c2 = (1 - R) / (2.0 * k * R);

    % Compute uncompressed portion...
    if (xEnv <= t - (k*0.5))
        g = xEnv;
      
    % Compute compressed portion...    
    elseif (xEnv > t + (k*0.5))
        g = t + ((xEnv-t)/R);
    else
        g = xEnv * xEnv * c2 + xEnv * c1 + c0;        
    end
end