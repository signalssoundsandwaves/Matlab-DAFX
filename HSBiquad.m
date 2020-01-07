function y = HSBiquad(x,f0, gain, Q, fs)

 
%x = zeros(1, 1024); x(1) = 1; % delta fn input 
a = zeros(1, 3); b = zeros(1, 3); % alloc coeffs
 
% intermediate variables... 
A = 10^(gain/40);
w0 = 2*pi*f0/fs;
alpha = sin(w0)/(2*Q); 

b(1) =    A*( (A+1) + (A-1)*cos(w0) + 2*sqrt(A)*alpha );             
b(2) = -2*A*( (A-1) + (A+1)*cos(w0));             
b(3) =    A*( (A+1) + (A-1)*cos(w0) - 2*sqrt(A)*alpha );             
a(1) =        (A+1) - (A-1)*cos(w0) + 2*sqrt(A)*alpha;             
a(2) =    2*( (A-1) - (A+1)*cos(w0));             
a(3) =        (A+1) - (A-1)*cos(w0) - 2*sqrt(A)*alpha;



y = filter(b, a, x);

end