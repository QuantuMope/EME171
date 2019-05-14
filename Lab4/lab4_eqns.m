function [ds, ext] = lab4_eqns(t,s)
global row g Ap P Cf L Ip At Ct d0 d1 d2

p3 = s(1); % fluid momentum in section 1
q7 = s(2); % volumetric dispalcement of tank 1
p9 = s(3); % fluid momentum in section 2
q13 = s(4); % volumetric dispalcement of tank 2

T1 = .5; %Turbing begins to turn off
T2 = T1 + 0.15;

Qon = 1.5;

if t < T1
    Q0 = Qon;
elseif t >= T1 && t <= T2
    Q0 = Qon - (Qon/0.15)*(t - T1);
elseif t > T2
    Q0 = 0;
end

p3_dot = row*g*d0 + row*g*d1 - Cf*(abs(p3/Ip))*p3/Ip - q7/Ct;
q7_dot = p3/Ip - p9/Ip;
p9_dot = q7/Ct + row*g*d2 - Cf*(abs(p9/Ip))*p9/Ip - q13/Ct;
q13_dot = p9/Ip - Q0;

ext(1) = 0;
ext(2) = 0;

ds = [p3_dot; q7_dot; p9_dot; q13_dot];