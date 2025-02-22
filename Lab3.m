close all;clear all;

odbicie = 0.8
v = 30;
t = 6;
delta_t = 10*(10^-3);
delta_s = v*delta_t

UE_p = [50,10];
UE_k = [50,300];
UE = [];

P_BS = 5;
db_P_BS = 10*log10(P_BS);
BS_1 = [110,190];
BS_2 = [110,10];
BS_3 = [-70,190];
f_BS = 3*(10^9);
c = 3*10^8;
lambda = c/f_BS;


k = 1;
d = 0;
for a = 0:delta_t:t
    UE_1(k) = UE_p(1);
    UE_2(k) = UE_p(2) + d;
    d = k*delta_s;
    k = k + 1;
end

UE(:,1) = UE_1.'
UE(:,2) = UE_2.'


UE_now = [0,0];

r_macierz(length(UE),3) = 0;
db_P_UE_macierz(length(UE),1) = 0;
H = [0,0,0];

for b = 1:length(UE)
    UE_now(1) = UE(b,1);
    UE_now(2) = UE(b,2);
    
    if dwawektory(BS_1(1),BS_1(2),UE_now(1),UE_now(2),70,100,130,100) == -1
        r1 = sqrt((UE_now(1)-BS_1(1))^2+(UE_now(2)-BS_1(2))^2);
        r_macierz(b,1) = r1;
        %H1 = odbicie*(lambda/(4*pi*r1))*exp((-j*2*pi*r1)/lambda);
        H1 = P_BS*((lambda/(4*pi*r1))^2);
        H(1) = H1;
    end
    
    if (UE_now(2) >= 145) & (UE_now(2) <= UE_k(2))
        r2 = sqrt((UE_now(1)-BS_2(1))^2+(UE_now(2)-BS_2(2))^2);
        r_macierz(b,2) = r2;
        H2 = odbicie*(lambda/(4*pi*r2))*exp((-j*2*pi*r2)/lambda);
        H(2) = H2;
    end

    if (UE_now(2) >= UE_p(2)) & (UE_now(2) <= UE_k(2))
        r3 = sqrt((UE_now(1)-BS_3(1))^2+(UE_now(2)-BS_3(2))^2);
        r_macierz(b,3) = r3;
        H3 = odbicie*(lambda/(4*pi*r3))*exp((-j*2*pi*r3)/lambda);
        H(3) = H3;
    end
       
    P_UE = P_BS*((sum(H))^2);
    db_P_UE = 10*log10(P_UE);
    db_P_UE_macierz(b) = db_P_UE;
end

UE;
r_macierz
db_P_UE_macierz;

x = 0:delta_t:t;



plot(x,db_P_UE_macierz.')
