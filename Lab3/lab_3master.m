global vc Lcg mcr rgy ksf ksr bsf bsr mtf mtr ktf ktr Lwb L g Jcr
vc = 10;
Lcg = 0.9;
mcr = 300;
rgy = 0.5;
ksf = 3000;
ksr = 3500;
bsf = 400;
bsr = 500;
mtf = 15;
mtr = 20;
ktf = 30000;
ktr = 40000;
Lwb = 1.6;
L = 0.5;
g = 9.81;

Jcr = mcr*(rgy^2);

a = Lcg;
b = Lwb-Lcg;

fssd = mcr*a*g/(ksf*Lwb);
rssd = mcr*b*g/(ksr*Lwb);
ftd = mcr*a*g/(ktf*Lwb) + mtf*g/ktf;
rtd = mcr*b*g/(ktr*Lwb) + mtr*g/ktr;

initial = [0 0 fssd rssd 0 0 ftd rtd]; 
%s(1) = Pitch angular momentum
%s(2) = Verical momentum of cycle and rider
%s(3) = Front suspension spring displacement
%s(4) = Rear suspension spring displacement
%s(5) = Momentum of front tire mass
%s(6) = Momentum of rear tire mass
%s(7) = Front tire deflection
%s(8) = Rear tire deflection

tspan = linspace(0,4,667);

[t, s] = ode45(@lab2_eqns,tspan,initial);
ext = zeros(length(t),2);
ds = zeros(length(t),6);

for i = 1:length(t)
    [ds(i,:), ext(i,:)] = lab2_eqns(t(i), s(i,:));
end

figure('Name','displacements','NumberTitle','off','Color','white')
plot(t(1:84),s(1:84,2)-Q6IN,'k',t(1:84),s(1:84,6),'--k'), grid on
title('Suspension and Road Displacement')
legend('Suspension','Road')
ylabel('displacement (m)')
xlabel('time (s)')

figure('Name','mass acceleration','NumberTitle','off','Color','white')
plot(t,ds(:,1)/M,'k'), grid on
title('Body Acceleration')
legend('Body')
ylabel('acceleration (m/s^2)')
xlabel('time (s)')
% figure('Name','dforce','NumberTitle','off')
% plot(t,ext(:,1),'k'), grid on
% title('Suspension Damper Force')
% ylabel('force (N)')
% xlabel('time (s)')
