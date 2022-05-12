
format compact

% Parameters
t_FRP = 90; %Hard code for now (min)  ? vid 12 of 13
slab_thickness = 100; %Hard code (mm) and engineers toolbox
k = 0.57; %Hard code for now (W/m K) 
% no_strips = 500; %Hard code for now 1mm strips ****
% no_time_step = 90000; %Hard code for now 0.1 min intervals *****
% time_interval = t_FRP / no_time_step
% step_dist = slab_thickness / no_strips
temp_ambient = 20; %Hard code for now
density = 2070; %Hard code for now (kg/m^3) 
c = 900; %Hard code for now (J/kg K) 

cases = transpose([[1000,1800000]]);

% cases = transpose( [
%     [5,180];
%     [10,180];
%     [50,180];
%     [100,180];
%     [500,180];
%     [1000,180];
%     [5,1800];
%     [10,1800];
%     [50,1800];
%     [100,1800];
%     [500,1800];
%     [1000,1800];
%     [5,18000];
%     [10,18000];
%     [50,18000];
%     [100,18000];
%     [500,18000];
%     [1000,18000];
%     [5,180000];
%     [10,180000];
%     [50,180000];
%     [100,180000];
%     [500,180000];
%     [1000,180000];
%     [5,1800000];
%     [10,1800000];
%     [50,1800000];
%     [100,1800000];
%     [500,1800000];
%     [1000,1800000]]);


cases_results = ["# Dist Steps", "# Time Steps", "Val @ 50mm", "Val @ 100mm"];
count = 1;

for z = cases

no_strips = z(1); 
no_time_step = z(2); 
time_interval = t_FRP / no_time_step
step_dist = slab_thickness / no_strips

% Set up array to hold strip temps
temps = zeros(no_strips + 2, 1);
% Set all to ambient temp for start
for i = 1:no_strips + 2
    temps(i,1) = temp_ambient;
end



% Loop through each time step
for i = 0:no_time_step
    % Get time and temp for specific time
    time = i * time_interval;
    temp = time_to_temp(time, temp_ambient);

    % Set new fire temp
    temps(1,1) = temp;

    % Work out h_f & h_a
    e_r = 0.5; %Temp value ****
    h_f = 25 + h_r(temps(2,1) + 273, temps(1,1) + 273, e_r); %25 - see video 4 of 13 slide 4
    h_a = 4 + h_r(temps(no_strips + 1, 1) + 273, temps(no_strips + 2, 1) + 273, e_r); % 4 As comment above

    % Step through strips
    for j = 2:no_strips + 1 %Go from 2 as starts with outside temp
        if j == 2 %Special case for first strip using h_f
            temps(j, 1) = strip_temp_change_f(temps(j-1,1), temps(j,1), temps(j+1,1), h_f, k, k, density, c, step_dist, time_interval);
            continue
        end
        if j == no_strips + 1 %Special case for last strip using h_a
            temps(j, 1) = strip_temp_change_a(temps(j-1,1), temps(j,1), temps(j+1,1), k, k, h_a, density, c, step_dist, time_interval);
            continue
        end

        temps(j, 1) = strip_temp_change(temps(j-1,1), temps(j,1), temps(j+1,1), k, k, k, density, c, step_dist, time_interval);
        
          
        
    end

end

count = count + 1;
x_50 = true;
cases_results(count, 1) = no_strips; 
cases_results(count, 2) = no_time_step;


for i = 1:no_strips + 2
    x = step_dist * (i-1);
    temps(i,2) = x;
    if x > 50 && x_50
        cases_results(count, 3) = temps(i,1);
        x_50 = false;
    end
    if x == 100
        cases_results(count, 4) = temps(i,1);
    end
end

end

plot(temps(:, 2), temps(:, 1))





