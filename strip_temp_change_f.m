function new_temp = strip_temp_change_f(T_f, T_n, T_n1, h_f, k_n, k_n1, density_n, c_n, step_dist, time_int)
%STRIP_TEMP_CHANGE_F Gives new temp of strip on fire side
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
factor_1 = (T_f - T_n) / ((1 / h_f) + (step_dist / (2*k_n)));
factor_2 = (T_n - T_n1) / ((step_dist / (2*k_n)) + (step_dist / (2*k_n1)));

temp_change = (factor_1 - factor_2) / factor_3;

new_temp = T_n + temp_change;
end