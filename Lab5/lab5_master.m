global Rw Lw Tm M btal R Gr Cr g Cd rho Af n kp ki 
Rw = 0.3; %[ohms], armature winding resistance
Lw = 0.015; %[H], armature winding inductance
Tm = 1.718; %[Wb], transduction coefficient
M = 2200; %[kg], vehicle mass
btal = 0.05; %[Nms/rad], drive shaft friction
R = 0.2; %[m], wheel radius
Gr = 5; %gear ratio
Cr = 0.006; %rolling resistance coefficient
g = 9.81; %[m*s^-2]
Cd = 0.32; %drag coefficient
rho = 1.21; %[kg*m^-3]
Af = 2.05; %[m^2]
n = 0.01;
kp = 176;     %proportional gain 
ki = 500;  %integral gain


p3IN = 0;
p9IN = 0;
dref_IN = 0;   
dact_IN = 0;  

%initial = [p3IN p9IN];
initial = [p3IN p9IN dref_IN dact_IN];  

%tspan = 0:0.01:5;
tspan = 0:0.01:300;   
tspan2= 0:1:300;

[t, s] = ode45(@lab5_eqns,tspan,initial);
ext = zeros(length(t),2);
%ds = zeros(length(t),2);
ds = zeros(length(t),4);

for i = 1:length(t)
    [ds(i,:), ext(i,:)] = lab5_eqns(t(i), s(i,:));
end

vref=zeros(length(t),1);
for i=1:length(t)
 vref(i) = LA92Oracle(t(i));
end

Pin=(s(:,1)/Lw).*ext(:,1);
Pout = (s(:,2)/M).*ds(:,2);
Pin_acc = Pin(Pout>0);
Pout_acc = Pout(Pout>0);
Pin_accavg = mean(Pin_acc);
Pout_accavg = mean(Pout_acc);
Peff = Pout_accavg/Pin_accavg


%plot for vehicle velocity
figure('Name','Vehicle Velocity','NumberTitle','off','Color','white')
hold on
axis([32,54,4,8])
plot(t,s(:,2)/M,'k'), grid on
plot(tspan2,LA92Oracle(tspan2))
hold off
title('Vehicle Velocity')
ylabel('velocity (m/s)')
xlabel('time (s)')


