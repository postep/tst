# Bieguny
- przy lokowaniu biegunów poza układem jednostowym układ "rozjeżdza się".
- zwiększanie odległości od zera lokowanych biegunów minimalnie przyspiesza regulację, ale zwiększa wpływ szumów
- przy lokowaniu ujemnych biegunów układ obserwatora dużo gorzej reaguje na szumy

## Bieguny obserwatora
Można stworzyć obserwator złożony z dwuczęściowego (odzielnie obserwujemy macierz ```Phi``` i ```Phi_w```). Wtedy nie bierzemy pod uwagę wpływu ```Phi_xw```. Drugą opcją jest zaprojektowanie obserwatora dla całego układu od razu. Wydaje się, że faktycznie daje to mniejsze błędy w sterowaniu.
- ustawienie ujemnych bieg

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

``` W(t) = (Phi_xw - Gamma*K_w) ==> Phi_xw = Gamma*k_w ```

ale wymiary macierzy się nie zgadzają. Żeby znaleźć coś podobnego do odwroności macierzy Gamma zastosowałem pseudoodwrotność.

# Sterowanie
- widać wyraźne piki przy zmianie wartości zadanej 
- nie ma eliminacji uchybu statycznego ==> wartość uchybu statycznego zależy od ```K_c```

## Wartość Kc
Układ bez sterowania zewnętrznego zbiega do zera. Po dodaniu do sterowania wartości zadanej układ powinien zbiegać do niej. Zależy nam na tym aby w stanie ustalonym (możemy pominąć indeksy czasu i wpływ szumów):

``` y = C*X = u_c```

Po podstawieniu tam gdzie się da ```u_c=x1=y``` dostajemy:

``` u_c = p11*u_c + K_c*u_c^2 - g1*k1*u_c - (p12*u_c*(p21 - g2*k1))/(p22 + K_c*u_c - g2*k2) + (g1*k2*u_c*(p21 - g2*k1))/(p22 + K_c*u_c - g2*k2)```

i wtedy możemy wyliczyć ```K_c```
