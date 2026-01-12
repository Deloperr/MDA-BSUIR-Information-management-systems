% Очистка командного окна и памяти
clc;
clear;

% Определение символьной переменной
syms x;

% Исходная функция
f = (x-1)^2 - sin(2*x);

% Определение точки для разложения
x0 = 1;  % Точка, в которой будет производиться разложение

% Разложение функции в ряд Тейлора до 2-й степени
taylor_0 = taylor(f, x, x0, 'Order', 1);  % 0-я степень
taylor_1 = taylor(f, x, x0, 'Order', 2);  % 1-я степень
taylor_2 = taylor(f, x, x0, 'Order', 3);  % 2-я степень

disp('Ряд Тейлора 0-й степени:');
disp(taylor_0);
disp('Ряд Тейлора 1-й степени:');
disp(taylor_1);
disp('Ряд Тейлора 2-й степени:');
disp(taylor_2);

% Построение сетки значений
x_vals = 0:0.01:2;  % Значения x от 0 до 2
y_exact = ((x_vals-1).^2) - sin(2*x_vals);  % Точная функция

% Аппроксимированные функции (ряды Тейлора)
y_approx_0 = double(subs(taylor_0, x, x_vals));
y_approx_1 = double(subs(taylor_1, x, x_vals));
y_approx_2 = double(subs(taylor_2, x, x_vals));

% График всех аппроксимаций
figure;
plot(x_vals, y_exact, 'b-', 'LineWidth', 2);  % Точная функция (синий)
hold on;
plot(x_vals, y_approx_0, 'r--', 'LineWidth', 1.5);  % Аппроксимация 0-й степени
plot(x_vals, y_approx_1, 'g:', 'LineWidth', 1.5);   % Аппроксимация 1-й степени
plot(x_vals, y_approx_2, 'm-.', 'LineWidth', 1.5);  % Аппроксимация 2-й степени

xlabel('x');
ylabel('f(x)');
title('Аппроксимация функции f(x) = (x-1)^2 - sin(2x)');
legend('Точная функция', 'Аппроксимация 0-й степени', 'Аппроксимация 1-й степени', 'Аппроксимация 2-й степени');
grid on;
hold off;

% График ошибок
figure;
plot(x_vals, abs(y_exact - y_approx_0), 'r--', 'LineWidth', 1.5);
hold on;
plot(x_vals, abs(y_exact - y_approx_1), 'g:', 'LineWidth', 1.5);
plot(x_vals, abs(y_exact - y_approx_2), 'm-.', 'LineWidth', 1.5);

xlabel('x');
ylabel('Абсолютная ошибка');
title('Ошибки аппроксимации');
legend('Ошибка 0-й степени', 'Ошибка 1-й степени', 'Ошибка 2-й степени');
grid on;
hold off;