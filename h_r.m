function h_r = h_r(T_int, T_ext, e_r)
%h_r Calculates radiant heat transfer coefficient
%   h_r in W/m^2K, T in K
T_surface = (T_int + T_ext) / 2; % Calcuklate approx surface temp as midpoint between int and ext temps

stefan_boltzmann = 5.6704e-8;
h_r = e_r * stefan_boltzmann * (T_surface^2 + T_ext^2) * (T_surface + T_ext);
end