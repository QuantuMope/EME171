function [ds, ext] = eqns(t,s)
global M K B amp
p = s(1);   %kg-m/s, (body) momentum - bond graph standard variable
q = s(2);   %m, (suspension) displacement - bond graph standard varable
if t < 1
    Vi = amp(1);
elseif t >= 1 && t < 2
    Vi = amp(2);
elseif t >= 2 && t < 3
    Vi = amp(3);
elseif t >= 3 && t < 4
    Vi = amp(4);
else 
    Vi = amp(5);
end
    
    
p_dot = K*q + B*(Vi - p/M); %N, derivative of body momentum
q_dot = Vi - p/M;    %m/s, derivative of suspension displacement
dbody_dot = p/M;
droad_dot = Vi;
ext(1) = B*(Vi - p/M);
ext(2) = Vi;
ds = [p_dot; q_dot; dbody_dot; droad_dot];