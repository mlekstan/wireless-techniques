close all; clear all;

A = [0,0];
B = [24,0];
C = [24,14];
D = [0,14];

A1 = [15.05,0];
B1 = [15.05,4];
C1 = [15.05,7];
D1 = [15.05,14];



[x,y] = meshgrid(0.05:0.05:24,0.05:0.05:14)

rozmiarMacierzy = size(x)
lwierszy = rozmiarMacierzy(1,1)
lkolumn = rozmiarMacierzy(1,2)
mocRx = []
mocLogRx = []
mocTx = 5; %[mW]
mocLogTx = 10*log10(mocTx)
mocRx2 = []
mocLogRx2 = []
f = 2 * 10^9; %[Hz]
polozenieTx = [14, 10]
polozenieRx = [0,0]
odbicie = 0.8
dlugoscFali = (3*10^8)/f

for k = 1:lwierszy
    for h = 1:lkolumn
        polozenieRx(1,1) = x(k,h);
        polozenieRx(1,2) = y(k,h);
        %disp(polozenieRx)
    
        if (dwawektory(polozenieTx(1,1),polozenieTx(1,2),polozenieRx(1,1),polozenieRx(1,2),A1(1,1),A1(1,2),B1(1,1),B1(1,2)) == -1 & dwawektory(polozenieTx(1,1),polozenieTx(1,2),polozenieRx(1,1),polozenieRx(1,2),C1(1,1),C1(1,2),D1(1,1),D1(1,2)) == -1)
                
                odleglosc = sqrt((polozenieRx(1,1)-polozenieTx(1,1))^2+(polozenieRx(1,2)-polozenieTx(1,2))^2);
                %tmpMocRx =  mocTx*(((3*10^8)/(2*10^9)/(4*pi*odleglosc))^2)
                %mocRx(end+1) = tmpMocRx
                %mocLogRx(end+1) = 10*log10(tmpMocRx)
                tmpTransmitancja = odbicie*(dlugoscFali/(4*pi*odleglosc))*exp((-j*2*pi*odleglosc)/dlugoscFali);
                mocRx2(end+1) = mocTx*(abs(tmpTransmitancja))^2;
                mocLogRx2(end+1) = mocLogTx+20*log10(abs(tmpTransmitancja));
        else 
                tmpTransmitancja = 0*(dlugoscFali/(4*pi*odleglosc))*exp((-j*2*pi*odleglosc)/dlugoscFali);
                mocRx2(end+1) = mocTx*(abs(tmpTransmitancja))^2;
                mocLogRx2(end+1) = mocLogTx+20*log10(abs(tmpTransmitancja));
        end
    
    
    end

end

%zmieniona_mcLogRx2 = reshape(mocLogRx2,lwierszy,lkolumn)
nowaMacierz = [];

for c = 1:lwierszy
    tmp = mocLogRx2(1:lkolumn);
    nowaMacierz = [nowaMacierz;tmp];
    numel(mocLogRx2);
    if (lkolumn+1) > numel(mocLogRx2)
        break
    else 
        mocLogRx2 = mocLogRx2(lkolumn+1:end);
    end
end



pcolor(x,y,nowaMacierz);
colormap('parula');
shading('interp');
colorbar()
hold on;


plot(polozenieTx(1,1),polozenieTx(1,2),"Color",'black','Marker','*','MarkerSize',10,'LineWidth',2);
line([A(1,1),B(1,1)],[A(1,2),B(1,2)],'Color', 'black', 'LineWidth', 5);
line([B(1,1),C(1,1)],[B(1,2),C(1,2)],'Color', 'black', 'LineWidth', 5);
line([C(1,1),D(1,1)],[C(1,2),D(1,2)],'Color', 'black', 'LineWidth', 5);
line([D(1,1),A(1,1)],[D(1,2),A(1,2)],'Color', 'black', 'LineWidth', 5);
line([A1(1,1),B1(1,1)],[A1(1,2),B1(1,2)],'Color', 'black', 'LineWidth', 5);
line([C1(1,1),D1(1,1)],[C1(1,2),D1(1,2)],'Color', 'black', 'LineWidth', 5);
grid;