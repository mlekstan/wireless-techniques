close all;clear all;

x = 80;
y = 70;

stacja_ref_1 = [0,0];
stacja_ref_2 = [x,0];
stacja_ref_3 = [x,y];
stacja_ref_4 = [0,y];

[x1, y1] = meshgrid(0:x,0:y);
[Y, X] = meshgrid(0:y,0:x);

avg_error_matrix = [];

odch = 2;

for i = 0:x
    for j = 0:y
        error_tab = [];
        for k = 1:50
            alfa1 = atand((i - stacja_ref_1(1)) / (j - stacja_ref_1(2)));
            alfa1_AoA = alfa1 + odch.*randn(1,1);
            tangens_alfa1_AoA = tand(alfa1_AoA);
            b1 = stacja_ref_1(1) - (stacja_ref_1(2)*tangens_alfa1_AoA);
        
            alfa2 = atand((i - stacja_ref_2(1)) / (j - stacja_ref_2(2)));
            alfa2_AoA = alfa2 + odch.*randn(1,1);
            tangens_alfa2_AoA = tand(alfa2_AoA);
            b2 = stacja_ref_2(1) - (stacja_ref_2(2)*tangens_alfa2_AoA);
            
            alfa3 = atand((i - stacja_ref_3(1)) / (j - stacja_ref_3(2)));
            alfa3_AoA = alfa3 + odch.*randn(1,1);
            tangens_alfa3_AoA = tand(alfa3_AoA);
            b3 = stacja_ref_3(1) - (stacja_ref_3(2)*tangens_alfa3_AoA);
        
            alfa4 = atand((i - stacja_ref_4(1)) / (j - stacja_ref_4(2)));
            alfa4_AoA = alfa4 + odch.*randn(1,1);
            tangens_alfa4_AoA = tand(alfa4_AoA);
            b4 = stacja_ref_4(1) - (stacja_ref_4(2)*tangens_alfa4_AoA);
        
            A = [1,-tangens_alfa1_AoA; 1,-tangens_alfa2_AoA; 1,-tangens_alfa3_AoA; 1,-tangens_alfa4_AoA];
            b = [b1; b2; b3; b4];
        
            polozenie_robota_AoA = inv((A.') * A) * (A.') * b;
            error = sqrt((i-polozenie_robota_AoA(1))^2 + (j-polozenie_robota_AoA(2))^2);
            error_tab(k) = error;
        end
        
        avg_error = mean(error_tab);
        avg_error_matrix(j+1,i+1) = avg_error;
    end
end

pcolor(x1,y1,avg_error_matrix);
colormap('hot');
shading('interp');
colorbar()