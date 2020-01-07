function y = PBiquad(x,f0, gain, Q, fs)

 
%x = zeros(1, 1024); x(1) = 1; % delta fn input 
a = zeros(1, 3); b = zeros(1, 3); % alloc coeffs
 
% intermediate variables... 
A = 10^(gain/40);
w0 = 2*pi*f0/fs;
alpha = sin(w0)/(2*Q); 

b(1) =   1 + alpha*A;             
b(2) =  -2*cos(w0);             
b(3) =   1 - alpha*A;             
a(1) =   1 + alpha/A;             
a(2) =  -2*cos(w0);             
a(3) =   1 - alpha/A;

y = filter(b, a, x);

end