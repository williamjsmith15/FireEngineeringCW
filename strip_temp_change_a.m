function new_temp = strip_temp_change_a(T_1n, T_n, T_a, k_1n, k_n, h_a, density_n, c_n, step_dist, time_int)
%STRIP_TEMP_CHANGE_A Gives new temp of strip on ambient side
%   Temps of current (n) prev (1n) and next (n1) Strip in K or deg c
%   (doesnt matter...)
%   Ks of Currnet (n) prev (1n) and next (n1) Strip in W/m k
%   Density kg/m^3, c J/kg K
%   Step distance mm, time interval min

%Convert to SI units
step_dist = step_dist / 1000;
time_int = time_int * 60;

%Simplify calc
factor_3 = (step_dist * c_n * density_n) / time_int;
factor_1 = (T_1n - T_n) / ((step_dist / (2*k_1n)) + (step_dist / (2*k_n)));
factor_2 = (T_n - T_a) / ((1 / (2*k_n)) + (step_dist / h_a));

temp_change = (factor_1 - factor_2) / factor_3;

new_temp = T_n + temp_change;
end