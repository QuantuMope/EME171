global M K B Vamp Mu Kt L A Vc G
M = 250; %kg, mass of 1/4 car
fn = 1;
wn = fn*2*pi;
K = wn^2*M;
z = 0.3;
B = z*2*M*wn;
Mu = M/5; %kg, mass of wheel
Kt = K*10; %N/m, spring stiffness of wheel
A = 0.08; %m, depth of pot hole
L = 1.2; %m, length of pot hole
Vc = 10; %m/s Horizonal speed
Vamp = 2*A*Vc/L; %m/s vertical speed down
G = 9.81;

Q6IN = (M*G)/K; % Initial Suspension Spring Displacement
Q11IN = (Mu+M)*G/Kt; % Initial Tire Spring Displacement

initial = [0 Q6IN 0 Q11IN 0 0]; % [1mass momentum, 1spring disp, 2mass momentum, 2spring disp, mass disp, bump disp]

tspan = linspace(0,3,500);

[t, s] = ode45(@lab2_eqns,tspan,initial);
ext = zeros(length(t),2);
ds = zeros(length(t),6);

for i = 1:length(t)
    [ds(i,:), ext(i,:)] = lab2_eqns(t(i), s(i,:));
end

figure('Name','displacements','NumberTitle','off','Color','white')
plot(t,s(:,2)-Q6IN,'k',t,s(:,6),'--k'), grid on
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
