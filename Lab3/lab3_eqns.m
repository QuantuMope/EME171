function [ds, ext] = lab3_eqns(t,s)
global vc Lcg mcr rgy ksf ksr bsf bsr mtf mtr ktf ktr Lwb L g Jcr

pj = s(1); % Pitch angular momentum
pcr = s(2); % Vertical momentum of cycle and rider
qsf = s(3); % Front suspension spring displacement
qsr = s(4); % Rear suspension spring displacement
ptf = s(5); % Momentum of front tire mass
ptr = s(6); % Momentum of rear tire mass
qtf = s(7); % Front tire deflection
qtr = s(8); % Rear tire deflection

a = Lcg;
b = Lwb - Lcg;

T1 = 0.1; %start of front wheel on first bump
T2 = L/(2*vc) + T1; %apex of fron wheel on first bump
T3 = L/vc + T1; % end of front wheel on first bump
T4 = T3 + Lwb/vc; % start of front wheel on second bump
T5 = T4 + L/(2*vc); % apex of front wheel on second bump
T6 = T4 + L/vc; % end of front wheel on second bump
T7 = T1 + Lwb/vc; % start of rear wheel on first bump
T8 = T7 + L/(2*vc); % apex of rear wheel on first bump
T9 = T7 + L/vc; % end of rear wheel on first bump
T10 = T9 + Lwb/vc; % start of rear wheel on second bump
T11 = T10 + L/(2*vc); % apex of rear wheel on second bump
T12 = T10 + L/vc;% end of rear wheel on second bump

Vup = 2*A*vc/L;
Vdown = - Vup;

if t < T1
    vfi = 0;
elseif t >= T1 && t <= T2
    vfi = Vup;
elseif t > T2 && t <= T3
    vfi = Vdown;
elseif t > T3 && t <= T4
    vfi = 0;
elseif t > T4 && t <= T5
    vfi = Vup;
elseif t > T5 && t <= T6
    vfi = Vdown;


pj_dot =a(qsf*ksf+bsf(ptf/mtf-pcr/mcr-a*pj/Jcr))-b(qsr*ksr+bsr(ptr/mtr-pcr/mcr+bpj/Jcr));
pcr_dot = -mcr*g+qsf*ksf+bsf(ptf/mtf-pcr/mcr-a*pj/Jcr)+qsr*ksr+bsr(ptr/mtr-pcr/mcr+b*pj/Jcr);
qsf_dot = ptf/mtf-pcr/mcr-a*pj/Jcr;
qsr_dot = ptr/mtr-pcr/mcr+b*pj/Jcr;
ptf_dot = qtf*ktf-mtf*g-qsf*ksf-bsf(ptf/mtf-pcr/mcr-a*pj/Jcr);
ptr_dot = qtr*ktr-mtr*g-qsr*ksr-bsr(ptr/mtr-pcr/mcr-b*pj/Jcr);
qtf_dot = vfi - ptf/mtf;
qtr_dot = vri - ptf/mtr;



