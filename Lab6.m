close all; clear all;

x = 60;
y = 40;

Tx1 = [5.5, 4.5];
Tx2 = [5.5,20];
Tx3 = [5.5,34];

macierz_polozen_Tx = [Tx1;Tx2;Tx3];

Rx1 = [54,10.5];
Rx2 = [54,16.5];
Rx3 = [54,24.5];
Rx4 = [54,30.5];

macierz_polozen_Rx = [Rx1;Rx2;Rx3;Rx4];

plot(Tx1(1),Tx1(2),'r*','LineWidth',2);
hold on;
plot(Tx2(1),Tx2(2),'r*','LineWidth',2);
plot(Tx3(1),Tx3(2),'r*','LineWidth',2);

plot(Rx1(1),Rx1(2),'bx','LineWidth',2);
plot(Rx2(1),Rx2(2),'bx','LineWidth',2);
plot(Rx3(1),Rx3(2),'bx','LineWidth',2);
plot(Rx4(1),Rx4(2),'bx','LineWidth',2);

rectangle('Position',[0 0 x y],'LineWidth',3)

rozmiar_macierzy_Tx = size(macierz_polozen_Tx);
rozmiar_macierzy_Rx = size(macierz_polozen_Rx);

szerokosc_obiektu = 1;
wysokosc_obiektu = 1;
x1_obiektu = abs(Rx1(1) - Tx1(1)) * rand() + Tx1(1);
y1_obiektu = abs(Tx1(2) - Tx3(2)) * rand() + Tx1(2);
x2_obiektu = x1_obiektu + szerokosc_obiektu;
y2_obiektu = y1_obiektu + wysokosc_obiektu;

rectangle('Position',[x1_obiektu y1_obiektu szerokosc_obiektu wysokosc_obiektu], 'EdgeColor','b','FaceColor','r','LineWidth',1)

macierz_przeciec_Tx = [];
macierz_przeciec_Rx = [];
k = 1;

for (i = 1:rozmiar_macierzy_Tx(1))
    for (j = 1:rozmiar_macierzy_Rx(1))
        if wektorsektor(macierz_polozen_Tx(i,1),macierz_polozen_Tx(i,2),macierz_polozen_Rx(j,1),macierz_polozen_Rx(j,2),x1_obiektu,y1_obiektu,szerokosc_obiektu,wysokosc_obiektu) == -1  %(dwawektory(macierz_polozen_Tx(i,1),macierz_polozen_Tx(i,2),macierz_polozen_Rx(j,1), macierz_polozen_Rx(j,2),x1_obiektu,y1_obiektu,x2_obiektu,y1_obiektu) == -1 && dwawektory(macierz_polozen_Tx(i,1),macierz_polozen_Tx(i,2),macierz_polozen_Rx(j,1), macierz_polozen_Rx(j,2),x2_obiektu,y1_obiektu,x2_obiektu,y2_obiektu) == -1 && dwawektory(macierz_polozen_Tx(i,1),macierz_polozen_Tx(i,2),macierz_polozen_Rx(j,1), macierz_polozen_Rx(j,2),x2_obiektu,y2_obiektu,x1_obiektu,y2_obiektu) == -1 && dwawektory(macierz_polozen_Tx(i,1),macierz_polozen_Tx(i,2),macierz_polozen_Rx(j,1), macierz_polozen_Rx(j,2),x1_obiektu,y2_obiektu,x1_obiektu,y1_obiektu) == -1)
            
            line([macierz_polozen_Tx(i,1), macierz_polozen_Rx(j,1)],[macierz_polozen_Tx(i,2), macierz_polozen_Rx(j,2)],'Color', 'g','LineWidth', 1);
        
        else
            line([macierz_polozen_Tx(i,1), macierz_polozen_Rx(j,1)],[macierz_polozen_Tx(i,2), macierz_polozen_Rx(j,2)], 'Color', 'r','LineWidth',1);
            macierz_przeciec_Tx(k,:) = macierz_polozen_Tx(i,:);
            macierz_przeciec_Rx(k,:) = macierz_polozen_Rx(j,:);
            k = k + 1;
        end
    end
end

[m,n] = size(macierz_przeciec_Tx);

for (i = 0:x-1)
        for (j = 0:y-1)
            rectangle('Position',[i j szerokosc_obiektu wysokosc_obiektu],'LineWidth',0.5);
            for z = 1:m
                if (wektorsektor(macierz_przeciec_Tx(z,1),macierz_przeciec_Tx(z,2),macierz_przeciec_Rx(z,1),macierz_przeciec_Rx(z,2),i,j,1,1)==1)
                    rectangle('Position',[i j szerokosc_obiektu wysokosc_obiektu],'LineWidth',2,'EdgeColor','c');
                end
            end
                
        end
end

