clear all;close all;

r = [100,0];
p_t = 5 * 10^-3;
db_p_t = 10*log10(p_t) - 3;
f = 6 * 10^9;
c = 3 * 10^8;
lambda = c / f;
r1 = [100,-0.0125];
r2 = [100,0.0125];
lambda1 = 2 * (abs(r2(2) - r1(2)));
u1 = [50,70];
u2 = [160,50];
db_N = -135;

dist_r1_u1 = sqrt((u1(1)-r1(1))^2 + (u1(2)-r1(2))^2);
dist_r2_u1 = sqrt((u1(1)-r2(1))^2 + (u1(2)-r2(2))^2);
dist_r1_u2 = sqrt((u2(1)-r1(1))^2 + (u2(2)-r1(2))^2);
dist_r2_u2 = sqrt((u2(1)-r2(1))^2 + (u2(2)-r2(2))^2);

diff_dist_u1 = dist_r1_u1 - dist_r2_u1;
diff_dist_u2 = dist_r1_u2 - dist_r2_u2;

% diff_dist_u1 = dist_r2_u1 - dist_r1_u1;
% diff_dist_u2 = dist_r2_u2 - dist_r1_u2;




% Użytkownik 1 transmisja:

diff_phase_u1 = mod((diff_dist_u1 / lambda) * (2 * pi), (2 * pi)); 

phase1_u1 = 0;
phase2_u1 = diff_phase_u1 - phase1_u1;

H1_u1 = (lambda/(4*pi*dist_r1_u1)) * exp((-j*2*pi*dist_r1_u1)/lambda) * exp(j * phase1_u1);
H2_u1 = (lambda/(4*pi*dist_r2_u1)) * exp((-j*2*pi*dist_r2_u1)/lambda) * exp(j * phase2_u1);

H_u1 = H1_u1 + H2_u1;

db_p_r_u1 = db_p_t + 20 * log10(abs(H_u1))

SNR_u1 = db_p_r_u1 - db_N

% Użytkownik 2 wytłumienie

H1_u2_w = (lambda/(4*pi*dist_r1_u2)) * exp((-j*2*pi*dist_r1_u2)/lambda) * exp(j * phase1_u1);
H2_u2_w = (lambda/(4*pi*dist_r2_u2)) * exp((-j*2*pi*dist_r2_u2)/lambda) * exp(j * mod((phase2_u1 - pi),(2 * pi)));

H_u2_w = H1_u2_w + H2_u2_w;

db_p_r_u2_w = db_p_t + 20 * log10(abs(H_u2_w))

SNR_u2_w = db_p_r_u2_w - db_N





% Użytkownik 2 transmisja

diff_phase_u2 = mod((diff_dist_u2 / lambda) * (2 * pi), (2 * pi));

phase1_u2 = 0;
phase2_u2 = diff_phase_u2 - phase1_u2;

H1_u2 = (lambda/(4*pi*dist_r1_u2)) * exp((-j*2*pi*dist_r1_u2)/lambda) * exp(j * phase1_u2);
H2_u2 = (lambda/(4*pi*dist_r2_u2)) * exp((-j*2*pi*dist_r2_u2)/lambda) * exp(j * phase2_u2);

H_u2 = H1_u2 + H2_u2;

db_p_r_u2 = db_p_t + 20 * log10(abs(H_u2))

SNR_u2 = db_p_r_u2 - db_N

% Użytkownik 1 wytłumienie

H1_u1_w = (lambda/(4*pi*dist_r1_u1)) * exp((-j*2*pi*dist_r1_u1)/lambda) * exp(j * phase1_u2);
H2_u1_w = (lambda/(4*pi*dist_r2_u1)) * exp((-j*2*pi*dist_r2_u1)/lambda) * exp(j * mod((phase2_u2 - pi),(2 * pi)));

H_u1_w = H1_u1_w + H2_u1_w;

db_p_r_u1_w = db_p_t + 20 * log10(abs(H_u1_w));

SNR_u1_w = db_p_r_u1_w - db_N
