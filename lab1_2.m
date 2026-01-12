% Очистка командного окна и памяти
clc;
clear;

% Определение символьных переменных
syms x1 x2;

% Подстановка x в исходной функции
f = ((2*x1 + x2) - 1)^2 - sin(2 * (2*x1 + x2));  % Функция двух переменных

% Определение точки для разложения
x1_0 = 1; 
x2_0 = 1;  % Точка, в которой будет производиться разложение

% Разложение функции в ряд Тейлора до 2-й степени
taylor_0 = taylor(f, [x1, x2], [x1_0, x2_0], 'Order', 1);  % 0-я степень
taylor_1 = taylor(f, [x1, x2], [x1_0, x2_0], 'Order', 2);  % 1-я степень
taylor_2 = taylor(f, [x1, x2], [x1_0, x2_0], 'Order', 3);  % 2-я степень

disp('Ряд Тейлора 0-й степени:');
disp(taylor_0);
disp('Ряд Тейлора 1-й степени:');
disp(taylor_1);
disp('Ряд Тейлора 2-й степени:');
disp(taylor_2);

% Построение сетки значений
[x1_vals, x2_vals] = meshgrid(0:0.1:2, 0:0.1:2);  % Сетка значений
y_exact = ((2*x1_vals + x2_vals) - 1).^2 - sin(2 * (2*x1_vals + x2_vals));  % Точная функция

% Аппроксимированные функции (ряды Тейлора)
y_approx_0 = double(subs(taylor_0, {x1, x2}, {x1_vals, x2_vals}));
y_approx_1 = double(subs(taylor_1, {x1, x2}, {x1_vals, x2_vals}));
y_approx_2 = double(subs(taylor_2, {x1, x2}, {x1_vals, x2_vals}));

% График 0-й степени
figure;
mesh(x1_vals, x2_vals, y_exact);  % Точная функция (синий)
hold on;
mesh(x1_vals, x2_vals, y_approx_0, 'FaceColor', 'r', 'FaceAlpha', 0.5);  % Аппроксимация 0-й степени (красный)
mesh(x1_vals, x2_vals, y_approx_1, 'FaceColor', 'g', 'FaceAlpha', 0.5);
mesh(x1_vals, x2_vals, y_approx_2, 'FaceColor', 'm', 'FaceAlpha', 0.5);
xlabel('x1');
ylabel('x2');
zlabel('f(x1, x2)');
title('Аппроксимация функции (0-я степень)');
legend('Точная функция', 'Аппроксимация 0-й степени');
grid on;
hold off;

% График 1-й степени
figure;
mesh(x1_vals, x2_vals, y_exact);  % Точная функция (синий)
hold on;
mesh(x1_vals, x2_vals, y_approx_1, 'FaceColor', 'g', 'FaceAlpha', 0.5);  % Аппроксимация 1-й степени (зеленый)
xlabel('x1');
ylabel('x2');
zlabel('f(x1, x2)');
title('Аппроксимация функции (1-я степень)');
legend('Точная функция', 'Аппроксимация 1-й степени');
grid on;
hold off;

% График 2-й степени
figure;
mesh(x1_vals, x2_vals, y_exact);  % Точная функция (синий)
hold on;
mesh(x1_vals, x2_vals, y_approx_2, 'FaceColor', 'm', 'FaceAlpha', 0.5);  % Аппроксимация 2-й степени (пурпурный)
xlabel('x1');
ylabel('x2');
zlabel('f(x1, x2)');
title('Аппроксимация функции (2-я степень)');
legend('Точная функция', 'Аппроксимация 2-й степени');
grid on;
hold off;