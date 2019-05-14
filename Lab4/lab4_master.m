global row g Ap P Cf L Ip At Ct d0 d1 d2 
row = 1000; %[kg*m^-3]
At = 0.71; %[m^2]
g = 9.81; %[m*s^-2]
Ap = 0.1; %[m^2]
Cf = 49000; %[kg*m^-7]
L = 50; % [m]
Ip = row*L/Ap; %[kg*m^-4]
Ct = At/(row*g); %[m^5/N]
d0 = 20; %[m]
d1 = 20; %[m]
d2 = 20; %[m]

p9init = 1.5*Ip;
p3init = p9init;
q7init = Ct*(row*g*d0+row*g*d1-Cf*(1.5*1.5)*p3init/Ip);
q13init = Ct*((q7init/Ct)+(row*g*d2)-(Cf*(1.5*1.5)*p9init/Ip));

initial = [p3init q7init p9init q13init]; 
% s(1) = fluid momentum in section 1
% s(2) = volumetric dispalcement of tank 1
% s(3) = fluid momentum in section 2
% s(4) = volumetric dispalcement of tank 2

T = (2*pi/(sqrt(1/(Ct*Ip))));

tspan = 0:T/10:2*T;

[t, s] = ode45(@lab4_eqns,tspan,initial);
ext = zeros(length(t),2);
ds = zeros(length(t),4);

for i = 1:length(t)
    [ds(i,:), ext(i,:)] = lab4_eqns(t(i), s(i,:));
end

maxh1 = max(s(:,2))/At;
maxh2 = max(s(:,4))/At;

figure('Name','Tank Heights','NumberTitle','off','Color','white')
plot(t,s(:,2)/At,'k', t,s(:,4)/At,'--k'), grid on
title('Tank 1 Height vs Time')
legend('Location', 'south','Tank 1', 'Tank 2')
ylabel('hight (m)')
xlabel('time (s)')