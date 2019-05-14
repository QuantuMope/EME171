global M K B amp
M = 267;
K = 1.87e4;
B = 1389;
amp = 0.2;
initial = [0 0 0 0]; % [mass momentum, spring disp, mass disp, bump disp]
tspan = linspace(0,5,2001);
[t, s] = ode45(@eqns, tspan, initial);
ext = zeros(length(t),2);
ds = zeros(length(t),4);
for i=1:length(t)
    [ds(i,:), ext(i,:)] = eqns(t(i), s(i,:));
end
figure('Name','displacements','NumberTitle','off','Color','white')
plot(t,s(:,3),'k',t,s(:,4),'--k'), grid on
title('Body and Road Displacement')
legend('Body','Road')
ylabel('displacement (m)')
xlabel('time (s)')
figure('Name','velocities','NumberTitle','off','Color','white')
plot(t,s(:,1)/M,'k',t,ext(:,2),'--k'), grid on
title('Body and Road Velocities')
legend('Body','Road')
ylabel('velocity (m/s)')
xlabel('time (s)')


