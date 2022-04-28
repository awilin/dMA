%Bayes1 - script for PhD students 2018 (C)A.Wilinski
%bayesWIG1b - data WIG20
%  both directions plus parameter b
% 
% 
clear all

%eurusd1h280416;  %65kx5  [ohlc vol]
%FW20WS221217;   %1064x7 [data ohlc vol lop]
FW20WS;  %WIG20 - main index od Warsaw Stock Exchange

m=size(C);

k=0;
kl=0;
ks=0;
kr=0;
klr=0;
b=6;

spread=2;
SL=8;


for i=10:4810
    k=k+1;
    PP(i)=(C(i-1,3)+C(i-1,4)+C(i-1,5))/3;  %Pivot Point = (H+L+C)/3
    R1(i)=2*PP(i)-C(i-1,4); % Opór1 = 2*PP - L
        S1(i)=2*PP(i)-C(i-1,3); % Opór1 = 2*PP - H

    if C(i,5)>C(i-1,5)
        kl=kl+1;
    end
    if C(i,5)<C(i-1,5)
        ks=ks+1;
    end
    if C(i,2)>R1(i)
        kr=kr+1;  %liczba zdarzeñ, gdy wartoœæ Close swiecy poprzedniej (otwarcia swiecy bie¿¹cej) jest  powyzej R1
    end
    if C(i,5)<C(i,2) && C(i,2)>R1(i)
        klr=klr+1;  %liczba zdarzeñ, gdy wystapi³ poprzedni warunek i w siecy bie¿acej wystapi³ wzrost (œwieca bia³a)
    end
end

plr=klr/kr   %Bayes - prawdopodobieñstwo udanej pozycji d³ugiej, gdy otwarcie swiecy by³o powyzej R1

%strategia
k=0;
kt=0;
for i=110:4810
    k=k+1;
    zl(k)=0;
    zs(k)=0;
    PP(i)=(C(i-1,3)+C(i-1,4)+C(i-1,5))/3;  %Pivot Point = (H+L+C)/3
    R1(i)=2*PP(i)-C(i-1,4); % Opór1 = 2*PP - L
      S1(i)=2*PP(i)-C(i-1,3); % Opór1 = 2*PP - H
    if C(i,2)>R1(i)+b  && C(i-1,7)>C(i-2,7)
        kt=kt+1;
        zs(k)=-C(i,5)+C(i,2)-spread;  %sh
        if -C(i,2)+C(i,3)>SL
            zs(k)=-SL;
        end
    end
        if C(i,2)<S1(i)-b && C(i-1,7)<C(i-2,7)
        kt=kt+1;
        zl(k)=C(i,5)-C(i,2)-spread;  %long
        if C(i,2)-C(i,4)>SL
            zl(k)=-SL;
        end
        end
end

    
  Zlcum=cumsum(zl) ; 
    Zscum=cumsum(zs) ; 
    Za=Zlcum+Zscum;

  [Zlcum(end) Zscum(end) Za(end)]
  
  
  figure(1)
  plot(Zlcum,':k')%,'LineWidth',0.1)
    hold on
      plot(Zscum,'--k')%,'LineWidth',0.2)
hold on
plot(Za,'-k','LineWidth',2)
title('Cumulative Profit - from long (...) and short (---) positions')


    
    
