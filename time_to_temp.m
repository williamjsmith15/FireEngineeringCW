function temp = time_to_temp(time, temp_ambient)
%TIME_TO_TEMP Convert time to temperature for FE Coursework
%   Time in min, temp in deg c
temp = 345 * log10((8*time) + 1) + temp_ambient;
end