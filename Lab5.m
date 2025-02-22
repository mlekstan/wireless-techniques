clear all; close all;

x = 80;
y = 70;
l_robotow = 90;
stacja_ref_1 = [0,0];
stacja_ref_2 = [x,0];
stacja_ref_3 = [x,y];
stacja_ref_4 = [0,y];

polozenia_robotow_x = 80.*rand(l_robotow,1);
polozenia_robotow_y = 70.*rand(l_robotow,1);
polozenia_robotow_xy(:,1) = polozenia_robotow_x;
polozenia_robotow_xy(:,2) = polozenia_robotow_y;

tab_blad_lokalizacji = [];
odch = 2;

for i=1:l_robotow
    alfa1 = atand((polozenia_robotow_xy(i,1) - stacja_ref_1(1)) / (polozenia_robotow_xy(i,2) - stacja_ref_1(2)));
    alfa1_AoA = alfa1 + odch.*randn(1,1);
    tangens_alfa1_AoA = tand(alfa1_AoA);
    b1 = stacja_ref_1(1) - (stacja_ref_1(2)*tangens_alfa1_AoA);

    alfa2 = atand((polozenia_robotow_xy(i,1) - stacja_ref_2(1)) / (polozenia_robotow_xy(i,2) - stacja_ref_2(2)));
    alfa2_AoA = alfa2 + odch.*randn(1,1);
    tangens_alfa2_AoA = tand(alfa2_AoA);
    b2 = stacja_ref_2(1) - (stacja_ref_2(2)*tangens_alfa2_AoA);
    
    alfa3 = atand((polozenia_robotow_xy(i,1) - stacja_ref_3(1)) / (polozenia_robotow_xy(i,2) - stacja_ref_3(2)));
    alfa3_AoA = alfa3 + odch.*randn(1,1);
    tangens_alfa3_AoA = tand(alfa3_AoA);
    b3 = stacja_ref_3(1) - (stacja_ref_3(2)*tangens_alfa3_AoA);

    alfa4 = atand((polozenia_robotow_xy(i,1) - stacja_ref_4(1)) / (polozenia_robotow_xy(i,2) - stacja_ref_4(2)));
    alfa4_AoA = alfa4 + odch.*randn(1,1);
    tangens_alfa4_AoA = tand(alfa4_AoA);
    b4 = stacja_ref_4(1) - (stacja_ref_4(2)*tangens_alfa4_AoA);

    A = [1,-tangens_alfa1_AoA; 1,-tangens_alfa2_AoA; 1,-tangens_alfa3_AoA; 1,-tangens_alfa4_AoA];
    b = [b1; b2; b3; b4];

    polozenie_robota_AoA = inv((A.') * A) * (A.') * b;
    blad_lokalizacji = sqrt((polozenia_robotow_xy(i,1) - polozenie_robota_AoA(1))^2 + (polozenia_robotow_xy(i,2) - polozenie_robota_AoA(2))^2);
    tab_blad_lokalizacji(i) = blad_lokalizacji;
    polozenia_robotow_xy_AoA(i,:) = polozenie_robota_AoA.';
end

sredni_blad_lokalizacji = mean(tab_blad_lokalizacji)

plot(stacja_ref_1(1),stacja_ref_1(2),'rx');
hold on;
plot(stacja_ref_2(1),stacja_ref_2(2),'rx');
plot(stacja_ref_3(1),stacja_ref_3(2),'rx');
plot(stacja_ref_4(1),stacja_ref_4(2),'rx');

polozenia_robotow_xy;
polozenia_robotow_xy_AoA;

plot(polozenia_robotow_xy(:,1),polozenia_robotow_xy(:,2),'bx');
plot(polozenia_robotow_xy_AoA(:,1),polozenia_robotow_xy_AoA(:,2),'g*');




