function [ds, ext] = eqnsec2(t,s)
global M K B amp
p = s(1);   %kg-m/s, (body) momentum - bond graph standard variable
q = s(2);   %m, (suspension) displacement - bond graph standard varable
ts = 0.5;   %s, time of bump start

if t == ts
    Vi = amp; %m/s

else
    Vi = 0; %m/s
end
p_dot = K*q + B*(Vi - p/M); %N, derivative of body momentum
q_dot = Vi - p/M;    %m/s, derivative of suspension displacement
dbody_dot = p/M;
droad_dot = Vi;
ext(1) = B*(Vi - p/M);
ext(2) = Vi;
ds = [p_dot; q_dot; dbody_dot; droad_dot];