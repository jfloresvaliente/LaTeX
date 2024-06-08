close all
global pets

pets = {'Engraulis_ringens'};
check_my_pet(pets); 

estim_options('default'); 
estim_options('max_step_number',5e2); 
estim_options('max_fun_evals',1e3);   

estim_options('pars_init_method', 2); % 1: continuacion de estimacion, 2: parte de pars_init
estim_options('results_output', 2); % 
estim_options('method', 'no');

% estim_pars;
% return
% estim_options('pars_init_method', 1); % 1: continuacion de estimacion, 2: parte de pars_init
% estim_options('results_output', 4); % 
% estim_options('method', 'nm');

estim_pars;