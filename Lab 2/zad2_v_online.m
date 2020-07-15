clear;

% Funkcja poczatkowa
f = @(x,y) sqrt(x.*y + sin(x) + 4) .* ( 3 .* y ^ 2 + 6);
% Przykladowe dane wejsciowe
x = 10;
y = 10;
% W ponizszych linijkach robimy takie rzeczy:
% 1. Po lewej stronie umieszczamy graf obliczen dla funkcji, w ktorej po kolei zapisujemy wszystkie operacje, 
% ktore beda wykonane w funkcji
% 2. Po prawej stronie zapisujemy pochodna operacji umieszczonej po lewej.
% Czyli naprzyklad w linijce, layer_1_0 mamy mnozenie, wiec w po lewej stronie w zmiennej g2_layer_1_0
% umieszczamy pochodna dla operacij mnozenia. u'v + uv'
%Input dla grafu obliczen funkcij              Input dla grafu obliczen pochodnej czastkowej
layer_0_0 = x;                                 g2_layer_0_0 = 0; %x
layer_0_1 = y;                                 g2_layer_0_1 = 1; %y

% Graf obliczen dla funkcij wejsciowej         %Graf obliczen dla pochodnej  czastkowej kazdej z funkcij
layer_1_0 = layer_0_0 .* layer_0_1;            g2_layer_1_0 = g2_layer_0_0 .* layer_0_1 + g2_layer_0_1 .* layer_0_0; % 
layer_1_1 = sin(layer_0_0);                    g2_layer_1_1 = cos(layer_0_0) .* g2_layer_0_0; %
layer_1_3 = layer_0_1 .^ 2;                    g2_layer_1_3 = 2 * g2_layer_0_1 * layer_0_1; % 

layer_2_1 = layer_1_0 + layer_1_1 + 4;         g2_layer_2_1 = g2_layer_1_0 + g2_layer_1_1 + 0; %
layer_2_2 = layer_1_3 .* 3;                    g2_layer_2_2 = 3 .* g2_layer_1_3;

layer_3_0 = layer_2_2 + 6;                     g2_layer_3_0 = g2_layer_2_2 + 0; %
layer_3_1 = sqrt(layer_2_1);                   g2_layer_3_1 = 1./(2 .* sqrt(layer_2_1)) .* g2_layer_2_1; %

output = layer_3_0 .* layer_3_1;               g2_output = g2_layer_3_1 .* layer_3_0 + layer_3_1 .* g2_layer_3_0;

% Sprawdzamy czy wynik otrzymany za pomoca grafu obliczen zgadza sie z przyblizeniem 
% pochodnej otrzymanej za pomoca ilorazu
g2_output
h = 0.00001;
df = (f(x,y+h) - f(x,y)) / h