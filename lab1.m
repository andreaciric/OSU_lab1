close all
clear
clc

diary on
%% zadatak 1 G(s)=(s+2)/(s^2+2s+2) odskocni odziv - preskok, vreme uspona i smirenja

s = tf('s');
G =(s+2)/(s^2+2*s+2);

figure('Name','zadatak 1','NumberTitle','off')
step(G,10);
grid on
title('odskocni odziv sistema')

Info = stepinfo(G);%pozivanje Info.Overshoot, Info.RiseTime i Info.SettlingTime

%% zadatak 2 G(s)=1/(s*(s+2))

G1 = 1/(s*(s+2));

t = 0:0.01:30;
for i = 1:length(t)
    u(i) = 0;
    if (t(i)>=5)&(t(i)<10)
        u(i) = 1;
    end
    if (t(i)>=15)&(t(i)<20)
        u(i) = -2;
    end
    if (t(i)>=20)&(t(i)<25)
        u(i) = 1;
    end
end
y = lsim(G1,u,t);

figure('Name','zadatak 2','NumberTitle','off')
plot(t,u,'b'); hold on;
plot(t,y,'r'); hold off;
ylim ([-3 3])
grid on
legend('in(t)','out(t)', 'Location', 'southwest')
title('odziv sistema')

%% zadatak 3 
%W(s) = Y(s)/E(s)
%G(s) = Y(s)/R(s) = W(s)/(1+W(s))
%Ge(s) = E(s)/R(s) = E(s)/Y(s) * Y(S)/R(s) = 1/(1+W(s))

W = (1-s)/(s*(s+2));
G3 = W/(1+W);
G3e = 1/(1+W);

figure('Name','zadatak 3','NumberTitle','off')
step(W,10,'b'); hold on;
step(G3,10, 'r');
step(G3e,10, 'g'); hold off
legend('H(s)','G(s)','Ge(s)', 'Location', 'northwest')
grid on
title('odskocni odzivi sistema')


%% zadatak 4

G41 = tf([8.5],[1 6 14.25 16.5 8.5]);
G42 = tf([2020],[1 44 569 1816 2020]);

p1 = pole(G41);
p2 = pole(G42);

figure('Name','zadatak 4 - polovi','NumberTitle','off')
plot(p1,'*','DisplayName','p1'); hold on;
plot(p2,'*','DisplayName','p2'); hold off;
xlim([-21 0])
legend(); grid on;
title('polovi')

%ovde na osnovu slike možemo da zaklju?imo koji su polovi dominantni

s = tf('s');
G41_aprox = 1/((s-p1(3))*(s-p1(4))); 
G42_aprox = 1/((s-p2(3))*(s-p2(4)));


figure('Name','zadatak 4 - G1','NumberTitle','off')
step(G41); hold on;
step(G41_aprox); hold off;
legend('G1(s)', 'G1_aprox(s)', 'Location', 'southeast');
title('odskocni odziv sistema')

figure('Name','zadatak 4 - G2','NumberTitle','off')
step(G42); hold on;
step(G42_aprox); hold off;
legend('G2(s)', 'G2_aprox(s)', 'Location', 'northwest');
title('odskocni odziv sistema')

Info41 = stepinfo(G41)
Info41_aprox = stepinfo(G41_aprox)
Info42 = stepinfo(G41)
Info42_aprox = stepinfo(G41_aprox)

% dTr1 = Info41.RiseTime-Info41_aprox.RiseTime
% dTr2 = Info41.RiseTime-Info41_aprox.RiseTime
% 
% dTs1 = Info41.SettlingTime-Info41_aprox.SettlingTime
% dTs2 = Info42.SettlingTime-Info42_aprox.SettlingTime
% 
% dP1 = Info41.Overshoot-Info41_aprox.Overshoot
% dP2 = Info42.Overshoot-Info42_aprox.Overshoot

%% zadatak 5

W5 = 10^4/((s+0.1)*(s+1)*(s^2+200*s+10025));

figure('Name','zadatak 5 - bode','NumberTitle','off')

[mag,phase,wout]=bode(W5);
mag = squeeze(mag);
phase = squeeze(phase);

w1 = interp1(20*log10(mag),wout,1);

[temp,ph1]=bode(W5,w1);
fazni_preskok = 180 + ph1

wpi = interp1(phase,wout,-180);
[temp,phpi]=bode(W5,wpi);
d = 1/phpi

subplot(2,1,1)
semilogx(wout, 20*log10(mag), w1, 1, 'r+'); grid on;
ylabel('Magnitude(dB)');
legend('20*log10(A)','w1', 'Location', 'southwest')


subplot(2,1,2)
semilogx(wout, phase, wpi, -180, 'r+'); grid on;
xlabel('Frequency (rad/s)');
ylabel('Phase (deg)')
legend('phase','wpi', 'Location', 'southwest')
suptitle('Bodeove karakteristike')

diary off
