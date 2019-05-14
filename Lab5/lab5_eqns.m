function [ds, ext] = lab5_eqns(t,s)
global Rw Lw Tm M btal R Gr Cr g Cd rho Af n kp ki 

p3 = s(1); % motor flux linkage
p9 = s(2); % vehicle momentum
dref = s(3);
dact = s(4);

vref=LA92Oracle(t);

uin = kp*(vref - (p9/M))+ ki*(dref - dact);

p3_dot = uin - (Rw/Lw)*p3 -(Tm*Gr/(R*M))*p9;
p9_dot = Gr/R*((Tm*p3/Lw)-(btal*Gr*p9/(R*M)))-(rho*Af*Cd*p9*(abs(p9/M))/(2*M))-(M*g*Cr*(p9/M)/(abs(p9/M)+n));
dref_dot = vref;
dact_dot = p9/M;

ext(1) = uin;
ext(2) = 0;

%ds = [p3_dot; p9_dot];
ds = [p3_dot; p9_dot; dref_dot; dact_dot;];