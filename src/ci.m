%% Testing data
% clc; clear;
% 
% DOY = 1;
% 
% tau = 0.75;
% P_a = 1014;
% SZA = 0;
% 
% PAR_clear = 1800;
% S_t_clear = 1150;
% PAR = 1000;
% 
% CI = ci(DOY, tau, P_a, SZA, PAR_clear, S_t_clear, PAR);

function CI = ci(DOY, tau, P_a, SZA, PAR_clear, S_t_clear, PAR)
    %% extraterrestrial radiation
    E_sc = 1367; % Solar constant (W/m^2)
    
    b = 2*pi*DOY/365;
    R = 1.00011 + 0.034221.*cos(b) + 0.00128.*sin(b) + 0.000719.*cos(2*b) + 0.000077.*sin(2*b);
    
    E_a = E_sc*R;
    
    % plot(DOY, E_a)
    % xlabel('Day of Year')
    % ylabel('Extraterrestrial Radiation (W/m^2)')
    % title('Annual Variation in Extraterrestrial Radiation')
    
    %% potential direct irradiance
    S_po = E_a;
    
    m = P_a/10/101.3/cos(SZA);
    S_p = S_po*tau^m;
    
    %% total potential shortwave radiation
    S_b = S_p*cos(SZA);
    S_d = 0.3*(1 - tau^m)*S_po*cos(SZA);
    S_t = S_b + S_d;    
    
    %% potential PAR
    CF = mean(PAR_clear/S_t_clear);
    PAR_0 = CF*S_t;
    
    %% CI
    CI = PAR/PAR_0;

end