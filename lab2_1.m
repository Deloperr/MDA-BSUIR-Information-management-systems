% Лабораторная работа 2, вариант 21
% Аппроксимация функции двух переменных рядами Тейлора

clc; clear; close all;

% 1. Определяем символьные переменные и функцию
syms x1 x2
f_sym = (2*x1 + x2 - 1)^2 - sin(4*x1 + 2*x2);

% 2. Задаем точку разложения
a1 = 0.5;
a2 = 0.5;

% 3. Вычисляем отрезки ряда Тейлора разного порядка
% Order = 1 -> Нулевой порядок (константа)
T0 = taylor(f_sym, [x1, x2], [a1, a2], 'Order', 1);
% Order = 2 -> Первый порядок (линейная аппроксимация)
T1 = taylor(f_sym, [x1, x2], [a1, a2], 'Order', 2);
% Order = 3 -> Второй порядок (квадратичная аппроксимация)
T2 = taylor(f_sym, [x1, x2], [a1, a2], 'Order', 3);

% 4. Создаем сетку для построения графиков
x1_vec = linspace(a1-0.3, a1+0.3, 40);
x2_vec = linspace(a2-0.3, a2+0.3, 40);
[X1_grid, X2_grid] = meshgrid(x1_vec, x2_vec);

% 5. Вычисляем значения функций на сетке
f_mat = matlabFunction(f_sym);
Z_exact = f_mat(X1_grid, X2_grid); % Точная функция

% Для аппроксимаций используем subs для подстановки значений
Z_approx_0 = double(subs(T0, {x1, x2}, {X1_grid, X2_grid}));
Z_approx_1 = double(subs(T1, {x1, x2}, {X1_grid, X2_grid}));
Z_approx_2 = double(subs(T2, {x1, x2}, {X1_grid, X2_grid}));

% 6. Построение графиков в одном окне
figure('Position', [100, 100, 1200, 800]);

% График 1: Точная функция
subplot(2, 2, 1);
mesh(X1_grid, X2_grid, Z_exact);
title('Точная функция: f(x_1, x_2)');
xlabel('x_1'); ylabel('x_2'); zlabel('f(x_1,x_2)');
colormap('jet'); colorbar;

% График 2: Аппроксимация 0-го порядка (константа)
subplot(2, 2, 2);
mesh(X1_grid, X2_grid, Z_approx_0);
title('Аппроксимация 0-го порядка (константа)');
xlabel('x_1'); ylabel('x_2'); zlabel('P_0(x_1,x_2)');
colormap('jet'); colorbar;

% График 3: Аппроксимация 1-го порядка (линейная)
subplot(2, 2, 3);
mesh(X1_grid, X2_grid, Z_approx_1);
title('Аппроксимация 1-го порядка (линейная)');
xlabel('x_1'); ylabel('x_2'); zlabel('P_1(x_1,x_2)');
colormap('jet'); colorbar;

% График 4: Аппроксимация 2-го порядка (квадратичная)
subplot(2, 2, 4);
mesh(X1_grid, X2_grid, Z_approx_2);
title('Аппроксимация 2-го порядка (квадратичная)');
xlabel('x_1'); ylabel('x_2'); zlabel('P_2(x_1,x_2)');
colormap('jet'); colorbar;

% 7. Анализ ошибок
figure;
% Ошибка для аппроксимации 2-го порядка
err = abs(Z_exact - Z_approx_2);
mesh(X1_grid, X2_grid, err);
title('Абсолютная ошибка |f(x_1,x_2) - P_2(x_1,x_2)|');
xlabel('x_1'); ylabel('x_2'); zlabel('Ошибка');
colorbar;

% 8. Количественный анализ ошибок
fprintf('АНАЛИЗ ТОЧНОСТИ\n');
fprintf('Точка разложения: (%.1f, %.1f)\n', a1, a2);
fprintf('Область анализа: x1 ∈ [%.1f, %.1f], x2 ∈ [%.1f, %.1f]\n\n', ...
        min(x1_vec), max(x1_vec), min(x2_vec), max(x2_vec));

% Вычисление среднеквадратичных ошибок
mse_0 = mean((Z_exact(:) - Z_approx_0(:)).^2);
mse_1 = mean((Z_exact(:) - Z_approx_1(:)).^2);
mse_2 = mean((Z_exact(:) - Z_approx_2(:)).^2);

% Вычисление максимальных ошибок
max_err_0 = max(abs(Z_exact(:) - Z_approx_0(:)));
max_err_1 = max(abs(Z_exact(:) - Z_approx_1(:)));
max_err_2 = max(abs(Z_exact(:) - Z_approx_2(:)));

% Вычисление ошибок в точке разложения
exact_at_point = double(subs(f_sym, {x1, x2}, {a1, a2}));
err_at_point_0 = abs(exact_at_point - double(subs(T0, {x1, x2}, {a1, a2})));
err_at_point_1 = abs(exact_at_point - double(subs(T1, {x1, x2}, {a1, a2})));
err_at_point_2 = abs(exact_at_point - double(subs(T2, {x1, x2}, {a1, a2})));

fprintf('МЕТРИКИ ОШИБОК:\n');
fprintf('%-25s %-12s %-12s %-12s\n', 'Метрика', 'P₀', 'P₁', 'P₂');
fprintf('%-25s %-12.4f %-12.4f %-12.4f\n', 'Среднеквадратичная', mse_0, mse_1, mse_2);
fprintf('%-25s %-12.4f %-12.4f %-12.4f\n', 'Максимальная', max_err_0, max_err_1, max_err_2);
fprintf('%-25s %-12.4f %-12.4f %-12.4f\n\n', 'В точке разложения', err_at_point_0, err_at_point_1, err_at_point_2);

% 9. Анализ сходимости в зависимости от расстояния от точки разложения
distances = sqrt((X1_grid - a1).^2 + (X2_grid - a2).^2);
errors_2 = abs(Z_exact - Z_approx_2);

% Группировка ошибок по расстояниям
distance_bins = 0:0.05:0.4;
mean_errors = zeros(size(distance_bins));
std_errors = zeros(size(distance_bins));

for i = 1:length(distance_bins)-1
    mask = (distances >= distance_bins(i)) & (distances < distance_bins(i+1));
    if any(mask(:))
        mean_errors(i) = mean(errors_2(mask));
        std_errors(i) = std(errors_2(mask));
    end
end

% График зависимости ошибки от расстояния
figure;
errorbar(distance_bins(1:end-1), mean_errors(1:end-1), std_errors(1:end-1), 'o-', 'LineWidth', 2);
xlabel('Расстояние от точки разложения');
ylabel('Средняя ошибка аппроксимации P₂');
title('Зависимость ошибки от расстояния до точки разложения');
grid on;

% 10. Сравнение относительной точности
relative_err_2 = abs(Z_exact - Z_approx_2) ./ (abs(Z_exact) + eps);
fprintf('Относительная точность P₂:\n');
fprintf('Медианная относительная ошибка: %.2f%%\n', median(relative_err_2(:))*100);
fprintf('90-й процентиль относительной ошибки: %.2f%%\n', prctile(relative_err_2(:), 90)*100);
fprintf('Максимальная относительная ошибка: %.2f%%\n\n', max(relative_err_2(:))*100);