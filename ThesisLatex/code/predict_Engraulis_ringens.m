function [prdData, info] = predict_Engraulis_ringens(par, data, auxData)

% unpack par, data, auxData
cPar = parscomp_st(par); vars_pull(par); 
vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);

filterChecks = E_Hh >= E_Hb ||...           % maturity at hatching, birth
               0 >= E_Hh ||...              %0 >= N_B ||...
               del_M_larva > del_M_SL;% ||... % if shape for larva is larger than shape for standard length adult (ie. Lw larva shape < Lw standard length adult, then it is wrong 
               %del_M_TL > del_M_SL;            % if shape for total length is larger than shape for standard length (ie. Lw Total length < Lw standard length), then it is wrong 
                 
if filterChecks  
   info = 0;
   prdData = {};
   return;
end  

del_M_TL = 1/1.141 * del_M_SL; % fishbase E. ringens
       
%% compute temperature correction factors
  TC_ah = tempcorr(temp.ah, T_ref, T_A);
  TC_tb = tempcorr(temp.tb, T_ref, T_A);
  TC_tj = tempcorr(temp.tj, T_ref, T_A);
  TC_tp = tempcorr(temp.tp, T_ref, T_A);
  TC_am = tempcorr(temp.am, T_ref, T_A);
  TC_Ri = tempcorr(temp.Ri, T_ref, T_A);
  TC_tL= tempcorr(temp.tL, T_ref, T_A);
  TC_tL_larv_highT = tempcorr(temp.tL_larv_highT, T_ref, T_A);
  TC_tL_larv_lowT = tempcorr(temp.tL_larv_lowT, T_ref, T_A);
  TC_LN_2 = tempcorr(temp.LN_2, T_ref, T_A);
  
  
  % life cycle
  pars_tj = [g; k; l_T; v_Hb; v_Hj; v_Hp];
  [tau_j, tau_p, tau_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f);
  if info ~= 1 % numerical procedure failed
     fprintf('warning: invalid parameter value combination for get_tj \n')
  end
  
  % initial
  pars_UE0 = [V_Hb; g; k_J; k_M; v]; % compose parameter vector
  U_E0 = initial_scaled_reserve(f, pars_UE0);  % d.cm^2, initial scaled reserve
  E_0 = U_E0 * p_Am;  
  Vw_0 = U_E0 * p_Am * w_E/ mu_E/ d_E; % cm^3, egg volume --> reserve water content and egg water content can differ; needs checking
  
  % hatch   
  [U_H aUL] = ode45(@dget_aul, [0; U_Hh; U_Hb], [0 U_E0 1e-10], [], kap, v, k_J, g, L_m);
  a_h = aUL(2,1); aT_h = a_h/ TC_ah; % d, age at hatch at f and T  
  L_h = aUL(2,3);                   % cm, structural length at hatching at f
  E_h = aUL(2,2) * p_Am;            % J, reserve at hatch
  Lw_h = L_h / del_M_larva;         % cm, standard length at hatching at f
    
  % birth
  tT_b = (tau_b/ k_M - a_h) / TC_tb;           % d, age at birth at f and T
  L_b = L_m * l_b;                  % cm, structural length at birth at f
  Lw_b = L_b/ del_M_larva;                % cm, physical length at birth at f
  %Ww_b = L_b^3 * (1 + f * ome);       % g, wet weight at birth at f 
 
  % metamorphosis
  tT_j = (tau_j / k_M - a_h) / TC_tj ;  % d, time since hatching at metam 
  L_j = L_m * l_j;                  % cm, structural length at metam
  %Lw_j = L_j/ del_M_larva;               % cm, standard length at metam at f
  Lw_j = L_j/ del_M_SL;               % cm, standard length at metam at f
  %Ww_j = L_j^3 * (1 + f * ome);       % g, wet weight at metam
  

  % puberty 
  L_p = L_m * l_p;                  % cm, structural length at puberty at f
  Lw_p = L_p/ del_M_TL;                % cm, total length at puberty at f
  %Ww_p = L_p^3 *(1 + f * ome);        % g, wet weight at puberty 
  tT_p = (tau_p - tau_b)/ k_M/ TC_tp;   % d, time since birth at puberty at f and T

  
  % ultimate
  L_i = L_m * l_i;                  % cm, ultimate structural length at f
  Lw_i = L_i/ del_M_TL;                % cm, ultimate total length at f
  Ww_i = L_i^3 * (1 + f * ome);       % g, ultimate wet weight without reproduction buffer?

  % reproduction
  pars_R = [kap, kap_R, g, k_J, k_M, L_T, v, U_Hb, U_Hj, U_Hp];
  [R_i, UE0, Lb, Lj, Lp, info]  =  reprod_rate_j(L_i, f, pars_R);
  RT_i = TC_Ri * R_i;% #/d, max reprod rate

  % life span
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];  % compose parameter vector at T_ref
  t_m = get_tm_s(pars_tm, f, l_b);      % -, scaled mean life span at T_ref
  aT_m = t_m/ k_M/ TC_am;                  % d, mean life span at T

  % pack to output
  prdData.ah = aT_h;
  prdData.tb = tT_b;
  prdData.tj = tT_j;
  prdData.tp = tT_p;
  prdData.am = aT_m;
  prdData.V0 = Vw_0;
  prdData.E0 = E_0;
  prdData.Lh = Lw_h;
  prdData.Lb = Lw_b;
  prdData.Lj = Lw_j;
  prdData.Lp = Lw_p;
  prdData.Li = Lw_i;
  %prdData.Wwb = Ww_b;
  %prdData.Wwp = Ww_p;
  prdData.Wwi = Ww_i;
  prdData.Ri = RT_i;
  
  %% uni-variate data
  
  % time-length
  tvel = get_tj(pars_tj, f_tL, [], tL(:,1) * k_M * TC_tL);
  ELw = L_m * tvel(:,4) ./ del_M_SL; 
  
 % Rioual 2021 18.5C
  % conditions at hatch
  pars_UE0 = [V_Hb; g; k_J; k_M; v]; % compose parameter vector
  U_E0 = initial_scaled_reserve(f, pars_UE0);  % d.cm^2, initial scaled reserve
  LEH_0 = [L_h, E_h, E_Hh]; % initial conditions
  options = odeset('Events',@hbj);
  % High T
  [tt, LEH] = ode45(@ode_LEH, tL_larv_highT(:,1), LEH_0, options, par, f_tL_larv, TC_tL_larv_highT);
  L    = LEH(:,1); % cm, structural length
  E_H = LEH(:,3);% J, maturity 
  del_M = (del_M_larva .* (E_Hj- E_H) + del_M_SL .* (E_H- E_Hb)) ./ (E_Hj - E_Hb);
  Lw   = L ./ del_M; % cm, standard length
  ELw_larv_highT = Lw; % mm, standard length
  % Low T
  [tt, LEH] = ode45(@ode_LEH, [0; tL_larv_lowT(:,1)], LEH_0, options, par, f_tL_larv, TC_tL_larv_lowT);
  LEH(1,:)=[]; % remaove added 0
  L    = LEH(:,1); % cm, structural length
  E_H = LEH(:,3);% J, maturity 
  del_M = (del_M_larva .* (E_Hj- E_H) + del_M_SL .* (E_H- E_Hb)) ./ (E_Hj - E_Hb);
  Lw   = L ./ del_M; % cm, standard length
  ELw_larv_lowT = Lw; % mm, standard length

  
  % length-weight
  EWw = (LW(:,1) * del_M_TL).^3 * (1 + f * ome); % g, wet weight
  
  pars_R = [kap, kap_R, g, k_J, k_M, L_T, v, U_Hb, U_Hj, U_Hp];
  R_L =  reprod_rate_j(LN_2(:,1) * del_M_TL, f, pars_R);
  EN_2 = TC_LN_2 * R_L * 365 / N_B;
 
  
  % pack to output
  prdData.tL = ELw;
  prdData.LW = EWw;
  prdData.LN_2 = EN_2;

  prdData.tL_larv_lowT = ELw_larv_lowT;
  prdData.tL_larv_highT = ELw_larv_highT;
end

% used for growth:
function dLEH = ode_LEH(t, LEH, p, f, TC)
% Input: 
% p: structure 'par' 
% c: structure 'Cpar' obtained by cPar = parscomp_st(par)
% f: scaled, scaled functional response, 
% s_M: scalar, -, acceleration factor post metamorphosis
% TC, scalar, -, temperature correction factor
% L_b, scaler, cm, structural length at birth at f
% L_j, scaler, cm, structural length at metamorphosis at f

persistent L_b L_j 

% --------------- unpack LEHR ------------------------------------------
L   =  max(0,LEH(1)); % cm, volumetric structural length
E   =  max(0,LEH(2)); % J,   energy in reserve 
EH  =  max(0,LEH(3)); % J, E_H maturity

% acceleration
if EH < p.E_Hb
    s_M = 1; L_b = L;
elseif EH >= p.E_Hb && EH < p.E_Hj
    s_M = L/L_b; L_j = L;
else
    s_M = L_j/L_b;
end

% Temperature and shape correct the relevant paramters
vT    = s_M * p.v * TC; 
pT_Am = s_M * p.z * p.p_M/ p.kap * TC;
pT_M  = p.p_M * TC; 
kT_J  = p.k_J * TC; 
%
pA  = f * pT_Am * L^2 * (EH >= p.E_Hb);           % J/d, assimilation
r   = (E * vT/ L - pT_M * L^3/ p.kap)/ (E + p.E_G * L^3/ p.kap);
pC  = E * (vT/ L - r); % J/d, mobilisation 
dE  = pA - pC;               % J/d, change in energy in reserve
dL  = r/ 3 * L;              % cm/d, change in structural length
dEH = ((1 - p.kap) * pC - kT_J * EH) * (EH < p.E_Hp);    % J/d, change in cum energy invested in maturation (it is implied here that no rejuvenation occurs).

% pack dLEHR
dLEH = [dL; dE; dEH];    
end

% event hatch,birth,end-of-acceleration
function [value,isterminal,direction] = hbj(t, LEH, p, f, TC)
  value = LEH(1) - [p.E_Hh, p.E_Hb, p.E_Hj]; % trigger E_H = E_Hh, E_Hn, E_Hj
  isterminal = [0 0 0]; % continue
  direction  = []; % get all the zeros
end 