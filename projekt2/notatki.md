# Bieguny
- przy lokowaniu biegunów poza układem jednostowym układ "rozjeżdza się".
- zwiększanie odległości od zera lokowanych biegunów minimalnie przyspiesza regulację, ale zwiększa wpływ szumów
- przy lokowaniu ujemnych biegunów układ obserwatora dużo gorzej reaguje na szumy

## Bieguny obserwatora
Można stworzyć obserwator złożony z dwuczęściowego (odzielnie obserwujemy macierz ```Phi``` i ```Phi_w```). Wtedy nie bierzemy pod uwagę wpływu ```Phi_xw```. Drugą opcją jest zaprojektowanie obserwatora dla całego układu od razu. Wydaje się, że faktycznie daje to mniejsze błędy w sterowaniu.

## Bieguny K_x
Z równania 

``` det(zI - A + BK_x) ```

daje się znaleźć tylko liniową zależność ponieważ sterowany układ jest liniowo zależny 

```rank(W_c) < rank(Phi) ``` 

Warto aby wartości ```K_x``` były małe. Ustawienie dużych wartości wektora powoduje większe przenoszenie szumów przez większe wartości sterowania.

## Bieguny K_w
Po przekształceniu równania 

``` x_hat(x+1) = Phi*x(t) + Phi_xw*w(t) + Gamma*u(t) ```

i podstawieniu 

``` U(t) = -K_x*x(t)-K_w*w(t) ```

dostajemy:

``` W(t) = (Phi_xw - Gamma*K_w) ==> K_w = pinv(Gamma)*Phi_xw```

ale wymiary macierzy się nie zgadzają. Żeby znaleźć coś podobnego do odwrotności macierzy ```Gamma``` zastosowałem pseudoodwrotność.

# Sterowanie
- widać wyraźne piki sterowania przy zmianie wartości zadanej 
- nie ma eliminacji uchybu statycznego ==> wartość uchybu statycznego zależy od ```K_c```
- przy niektórych symulacjach widać jak nieskompensowany szum zaczyna wprowadzać coraz większe oscylacje do obserwatora.

## Wartość K_c
Układ bez sterowania zewnętrznego zbiega do zera. Po dodaniu do sterowania wartości zadanej układ powinien zbiegać do niej. Zależy nam na tym aby w stanie ustalonym (możemy pominąć indeksy czasu i wpływ szumów):

``` y = C*X = u_c```

Po podstawieniu tam gdzie się da ```u_c=y``` i zastosowaniu macierzy pseudoodwrotnej dostajemy:

``` K_c = Gamma^-1*[1-Phi+Gamma*K_x]*C^-1```

i wtedy możemy wyliczyć ```K_c```, które jednak nie jest jednoznaczne bo ```K_x``` jest liniowo zależne.

Można na to wszystko spojrzeć w przewrotny sposób. Na zwykłą logikę jeśli ```K_c=1``` to układ powinien podążać za ```u_c``` i dla symulacji faktycznie ma to miejsce. Można odwrócić powyższe równanie i wyliczyć wartości ```K_x```, co w przybliżeniu osiągamy dla ```k_2 = 0.3235```. Przy tak dobranych wartościach szumy są małe i nie zwiększają oscylacji układu w trakcie symulacji. Faktycznie dla tak dobranych wartości układ reguluje się dobrze ale nie wiem czy zastosowana sztuczka ma wogóle znaczenie.
