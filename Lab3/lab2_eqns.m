function [ds, ext] = lab2_eqns(t,s)
global M K B Mu Kt L A Vc G

p2 = s(1); %kg-m/s, (body) momentum - bond graph standard variable
q6 = s(2); %m, (suspension) displacement - bond graph standard variable
p8 = s(3);
q11 = s(4);

T1 = 0.1;
T2 = T1 + L/(2*Vc);
T3 = T1 + L/(Vc);

if t < T1
    SF12 = 0;
elseif t >= T1 && t <= T2
    SF12 = 2*A*Vc/L;
elseif t > T2 && t <= T3
    SF12 = -2*A*Vc/L;
else
    SF12 = 0;
end


p_dot2 = -B*p2/M - K*q6 + B*p8/Mu + M*G;
q_dot6 = p2/M - p8/Mu;
p_dot8 = B*p2/M + K*q6 - B*p8/Mu - Kt*q11 + Mu*G;
q_dot11 = p8/Mu - SF12;

dbody_dot = p2/M;
droad_dot = SF12;

ext(1) = SF12;
ext(2) = 1;

ds = [p_dot2; q_dot6; p_dot8; q_dot11; dbody_dot; droad_dot];


