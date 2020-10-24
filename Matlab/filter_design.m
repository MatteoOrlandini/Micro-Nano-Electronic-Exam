clc
clear all
close all

load ('G.mat', 'G');
load('SOS.mat', 'SOS');
[b,a] = sos2tf(SOS, G);     % Convert digital filter second-order section data to transfer function form 
[z,p,k] = sos2zp(SOS, G);   % Convert digital filter second-order section parameters to zero-pole-gain form
rho = abs(p);               % absolute value of every pole
theta = angle(p);           % phase of every pole
q1 = theta(1)/(2*(1-rho(1)));   % quality factor first stage
disp("First stage quality factor: "+q1);
q2 = theta(3)/(2*(1-rho(3)));   % quality factor second stage
disp("Second stage quality factor: "+q2);
q3 = theta(5)/(2*(1-rho(5)));   % quality factor third stage
disp("Third stage quality factor: "+q3);

% first stage - coefficients conversion form Matlab to theory 
a2 = SOS(1,1)/SOS(1,6)*G(1);
a1 = SOS(1,2)/SOS(1,6)*G(1);
a0 = SOS(1,3)/SOS(1,6)*G(1);
b2 = SOS(1,4)/SOS(1,6);
b1 = SOS(1,5)/SOS(1,6);
b0 = SOS(1,6)/SOS(1,6);
num1 = [a2 a1 a0];
den1 = [b2 b1 b0];

% first stage - capacitance calculation
disp("First stage capacitance: ")
b = 1;
d = 1;
disp("B = D = "+d);
k = a0;
disp("K = "+k);
j = a2-a0;
disp("J = "+j);
g = (a0+a1+a2)/sqrt(b1+b2+1);
disp("G = "+g)
f = b2 - 1;
disp("F = "+f);
c = sqrt(b1+b2+1);
a = sqrt(b1+b2+1);
disp("A = C = "+a);

% second stage - coefficients conversion form Matlab to theory 
a2 = SOS(2,1)/SOS(2,6)*G(2);
a1 = SOS(2,2)/SOS(2,6)*G(2);
a0 = SOS(2,3)/SOS(2,6)*G(2);
b2 = SOS(2,4)/SOS(2,6);
b1 = SOS(2,5)/SOS(2,6);
b0 = SOS(2,6)/SOS(2,6);
num2 = [a2 a1 a0];
den2 = [b2 b1 b0];

% second stage - capacitance calculation
disp("Second stage capacitance: ")
b = 1;
d = 1;
disp("B = D = "+b);
k = a2/b2;
disp("K = "+k);
c = sqrt((b1+b2+1)/b2); 
a = sqrt((b1+b2+1)/b2); 
disp("A = C = "+a);
l = (a2-a0)/(b2*c);
disp("L = "+l);
g = (a0+a1+a2)/(b2*c);
disp("G = "+g)
e = (b2 - 1)/(b2*c);
disp("E = "+e);

% third stage - coefficients conversion form Matlab to theory 
a2 = SOS(3,1)/SOS(3,6)*G(3);
a1 = SOS(3,2)/SOS(3,6)*G(3);
a0 = SOS(3,3)/SOS(3,6)*G(3);
b2 = SOS(3,4)/SOS(3,6);
b1 = SOS(3,5)/SOS(3,6);
b0 = SOS(3,6)/SOS(3,6);
num3 = [a2 a1 a0];
den3 = [b2 b1 b0];

% third stage - capacitance calculation
disp("Third stage capacitance: ")
b = 1;
d = 1;
disp("B = D = "+b);
k = a2/b2;
disp("K = "+k);
c = sqrt((b1+b2+1)/b2); 
a = sqrt((b1+b2+1)/b2); 
disp("A = C = "+a);
l = (a2-a0)/(b2*c);
disp("L = "+l);
g = (a0+a1+a2)/(b2*c);
disp("G = "+g)
e = (b2 - 1)/(b2*c);
disp("E = "+e);

% demystifing formula for Q-factor
Q1_demystifing = abs(atan(imag(roots(den1))./real(roots(den1)))./2./(1-sqrt(real(roots(den1).^2+imag(roots(den1)).^2)))); 
% Q1 is an approximate value.
H1 = (real(roots(den1))).^2 + (imag(roots(den1))).^2;
alpha1 = 1-2.*sqrt(H1).*cos(atan(imag(roots(den1)))./real(roots(den1)))+(H1);
beta1 = 1 - H1;
Q1_accurate = sqrt(alpha1.*(1-0.25.*alpha1-0.5.*beta1))./beta1;

Q2_demystifing = abs(atan(imag(roots(den2))./real(roots(den2)))./2./(1-sqrt((real(roots(den2)).^2+imag(roots(den2)).^2))));
% Q2 is an approximate value.
H2 = (real(roots(den2))).^2 + (imag(roots(den2))).^2;
alpha2 = 1-2.*sqrt(H2).*cos(atan(imag(roots(den2)))./real(roots(den2)))+(H2);
beta2 = 1 - H2;
Q2_accurate = sqrt(alpha2.*(1-0.25.*alpha2-0.5.*beta2))./beta2;

%Q3_demystifing = sqrt(1+SOS(3,5)+SOS(3,6))./(1-SOS(3,6)); 
Q3_demystifing = abs(atan(imag(roots(den3))./real(roots(den3)))./2./(1-sqrt((real(roots(den3)).^2+imag(roots(den3)).^2))));
% Q3 is an approximate value.
H3 = (real(roots(den3))).^2 + (imag(roots(den3))).^2;
alpha3 = 1-2.*sqrt(H2).*cos(atan(imag(roots(den3)))./real(roots(den3)))+(H3);
beta3 = 1 - H3;
Q3_accurate = sqrt(alpha3.*(1-0.25.*alpha3-0.5.*beta3))./beta3;

% check if the zeros are in or out the unit circle
% First stage
num1_roots = roots(num1);
zero_magnitude1 = abs(num1_roots);
if zero_magnitude1 <= 1
    disp("The zero of the first stage zero is inside the unit circle");
else
    disp("The zero of the first stage zero is outside the unit circle");
end

% Second stage
num2_roots = roots(num2);
zero_magnitude2 = abs(num2_roots);
if zero_magnitude2 <= 1
    disp("The zero of the second stage zero is inside the unit circle");
else
    disp("The zero of the second stage zero is outside the unit circle");
end

% Third stage
num3_roots = roots(num3);
zero_magnitude3 = abs(num3_roots);
if zero_magnitude3 <= 1
    disp("The zero of the third stage zero is inside the unit circle");
else
    disp("The zero of the third stage zero is outside the unit circle");
end


%% real opamp design; Allen - CMOS analog circuit design pag. 293
disp ("Allen - CMOS analog circuit design pag. 293")
% MOSFET parameters
k_n = 167 * 10^-6;  % u_n * Cox
k_p = 42 * 10^-6;   % u_p * Cox
V_t1min = 0.57;     % Minimum threshold voltage N MOS
V_t1max = 0.93;     % Maximum threshold voltage N MOS
V_t3max = -0.71;    % Threshold voltage P MOS
% opamp parameters
V_out_max = 3.3;    % max output voltage
V_out_min = 0;      % min output voltage
V_in_max = 3.1;     % max input voltage
V_in_min = 1.2;     % min input voltage
GB = 10*10^6;  % gain bandwidth (10 MHz = 2*pi*10*10^6 rad/s)
SR = 6.22*10^6;       % slew rate (primo tentativo = 10V/us) 
C_c = 5*10^-12;     % compensation capacitance primo tentativo = 5pF) 
% calculation
I_5 = SR * C_c;     % M5 drain current
S_3 = I_5/(k_p*(V_out_max-V_in_max-abs(V_t3max)+V_t1min)^2); % M3 W/L 
g_m1 = 2 * pi * GB * C_c;    % M1 g_m 
I_1 = I_5/2;        % M1 drain current 
S_1 = g_m1^2/(2*k_n*I_1); % M1 W/L
V_ds5_sat = V_in_min - V_out_min - sqrt(I_5/(k_n*S_1)) - V_t1max;
S_5 = 2*I_5/(k_n*V_ds5_sat^2); % M5 W/L
g_m6 = 10 * g_m1;   % M6 g_m
g_m4 = sqrt(2*k_p*S_3*I_1); %M4 g_m
S_6 = S_3*g_m6/g_m4;% M6 W/L
I_6 = g_m6^2/(2*k_p*S_6);   % M6 drain current
S_7 = I_6/I_5*S_5;  % M7 W/L
disp ("S_1 = S_2 = " + S_1);
disp ("S_3 = S_4 = " + S_3);
disp ("S_5 = S_8 = " + S_5);
disp ("S_6 = " + S_6);
disp ("S_7 = " + S_7);

%% real opamp design; Allen - CMOS analog circuit design pag. 287
disp ("Allen - CMOS analog circuit design pag. 287")
% MOSFET parameters
k_n = 167 * 10^-6;  % u_n * Cox
k_p = 42 * 10^-6;   % u_p * Cox
% opamp parameters
A_0 = 1000;         % opamp DC gain
GB = 10*10^6;  % gain bandwidth (10 MHz = 2*pi*10*10^6 rad/s)
SR = 7*10^6;     % slew rate (primo tentativo = 10V/us), con SR=7.8V/us si migliora molto in DC offset
C_c = 6*10^-12;     % compensation capacitance (primo tentativo = 5pF) 
lambda = 0.175;
I_5 = SR * C_c;     % M5 drain current
g_m1 = 2 * pi * GB * C_c;    % M1 g_m
A_v1 = 2*g_m1/(I_5*2*lambda); % first stage gain
A_v2 = A_0 / A_v1;  % second stage gain
g_m6 = 10*g_m1;     % M6 g_m
I_6 = g_m6/(A_v2*2*lambda); % M6 drain current
I_1 = I_5/2;        % M1 drain current
S_1 = g_m1^2/(2*k_n*I_1); % W/L M1
S_6 = g_m6^2/(2*k_p*I_6);   % W/L M6
V_od5 = 0.3;        % overdrive voltage M5 = 0.2 V
S_5 = 2*I_5/(k_n*V_od5^2);  % W/L M5
S_7 = S_5*I_6/I_5;  % W/L M7
V_od4 = V_od5;      % overdrive voltage M4 = 0.2 V
S_3 = 2*I_1/(k_p*V_od4^2);  % W/L M3
disp ("C_c = " + C_c);
disp ("S_1 = S_2 = " + S_1);
disp ("S_3 = S_4 = " + S_3);
disp ("S_5 = S_8 = " + S_5);
disp ("S_6 = " + S_6);
disp ("S_7 = " + S_7);

%% https://www.youtube.com/watch?v=pdIz5LkHOHM
disp ("Design of two stage operational amplifier (opamp) - https://www.youtube.com/watch?v=pdIz5LkHOHM")
% MOSFET parameters
k_n = 167 * 10^-6;  % u_n * Cox
k_p = 42 * 10^-6;   % u_p * Cox
V_t1min = 0.66;     % Minimum threshold voltage N MOS
V_t1max = 0.95;     % Maximum threshold voltage N MOS
V_t3max = -0.71;    % Threshold voltage P MOS
% opamp parameters
V_out_max = 3.3;    % max output voltage
V_out_min = 0;      % min output voltage
V_in_max = 3.1;     % max input voltage
V_in_min = 1.2;     % min input voltage
GB = 10*10^6;       % gain bandwidth (10 MHz = 2*pi*10*10^6 rad/s)
SR = 6.5*10^6;       % slew rate (primo tentativo = 10V/us), con SR=7.8V/us si migliora molto in DC offset
C_c = 8*10^-12;     % compensation capacitance primo tentativo = 5pF) 
I_5 = SR * C_c;     % M5 drain current
I_1 = I_5/2;        % M1 drain current
g_m1 = 2 * pi * GB * C_c;    % M1 g_m
S_1 = g_m1^2/(k_n*I_5); % W/L M1
S_3 = I_5/(k_p*(V_out_max-V_in_max-abs(V_t3max)+V_t1min)^2); % M3 W/L 
V_ds5_sat = V_in_min - V_out_min - sqrt(I_5/(k_n*S_1)) - V_t1max;
S_5 = 2*I_5/(k_n*V_ds5_sat^2); % M5 W/L
g_m6 = 10 * g_m1;   % M6 g_m
g_m4 = sqrt(2*k_p*S_3*I_1); % M4 g_m
S_6 = S_3*g_m6/g_m4;    % M6 W/L
I_6 = g_m6^2/(2*k_p*S_6);   % M6 drain current
S_7 = I_6/I_5*S_5;  % M7 W/L
disp ("C_c = " + C_c);
disp ("I_5 = " + I_5*10^6 + " uA");
disp ("S_1 = S_2 = " + S_1);
disp ("S_3 = S_4 = " + S_3);
disp ("S_5 = S_8 = " + S_5);
disp ("S_6 = " + S_6);
disp ("S_7 = " + S_7);