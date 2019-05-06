%% Initialisation

colors = [0.49, 0.18, 0.56;
    0.93, 0.69, 0.13;
    0.00, 0.45, 0.74;
    0.47, 0.67, 0.19;
    0.30, 0.75, 0.93;
    0.86, 0.33, 0.10];

% Vortices indices
n_LEV = [280, 370; 429, 470; 547, 600];
n_TEV = [381, 440; 490, 554; 610, 662];

% Filtering properties 
a =1;
windowsSize = 30;
b = (1/windowsSize)*ones(1, windowsSize);

%% Cl & Circulation in Vortex
figure,
title('Cl & Circulation inside vortices')
hold on,
xlabel 't_{c} [s]')

yyaxis left,
plot(piv.tc, filter(b,a,piv.Cl), 'DisplayName', 'Cl')
ylabel('Lift')


yyaxis right
plot(piv.tc, abs(filter(b,a,gamma2.circulationCW)), '-', 'DisplayName', 'LEV Circulation')
plot(piv.tc, filter(b,a,gamma2.circulationCCW), '-', 'DisplayName', 'TEV Circulation', 'color', colors(1,:))
ylabel('Circulation')

legend show
legend('autoupdate', 'off')

% yyaxis left
% for n = 1:3
%     area([piv.tc(n_LEV(n,1)), piv.tc(n_LEV(n,2))], 1.1*max(piv.Cl)*ones(1,2), 'facealpha', 0.2, 'linestyle', 'none')
%     area([piv.tc(n_TEV(n,1)), piv.tc(n_TEV(n,2))], 1.1*max(piv.Cl)*ones(1,2), 'facecolor', 'blue', 'facealpha', 0.2, 'linestyle', 'none')
% end

%% Cl & Circulation in all field
figure,
title('Cl & Circulation inside vortices')
hold on,
xlabel 't_{c} [s]')

yyaxis left,
plot(piv.tc, filter(b,a,piv.Cl), 'DisplayName', 'Cl')
ylabel('Lift')


yyaxis right
plot(piv.tc, abs(filter(b,a,circulationCW)), '-', 'DisplayName', 'Negative Circulation')
plot(piv.tc, filter(b,a,circulationCCW), '-', 'DisplayName', 'Positive Circulation', 'color', colors(1,:))
ylabel('Circulation')

legend show
legend('autoupdate', 'off')%% 
%%
figure
for n=1:3 
    LEV_display_name = strcat('LEV', num2str(n));
    TEV_display_name = strcat('TEV', num2str(n));
    
    Delta_t_TEV = n_TEV(n,2)-n_TEV(n,1);
    Delta_t_LEV = n_LEV(n,2)-n_LEV(n,1);
    
    subplot(1,2,1)
    title('Leading Edge Vortices Circulation History')
    hold on
    plot(piv.tc(76:76+Delta_t_LEV), abs(filter(b,a,gamma2.circulationCW(n_LEV(n,1):n_LEV(n,2)))), 'color', colors(2*n-1,:), 'DisplayName', LEV_display_name)
    
    subplot(1,2,2)
    title('Trailing Edge Vortices Circulation History')
    hold on
    plot(piv.tc(76:76+Delta_t_TEV), abs(filter(b,a,gamma2.circulationCCW(n_TEV(n,1):n_TEV(n,2)))), 'color', colors(2*n-1,:), 'DisplayName', TEV_display_name)
    
end
legend show

%% Cl, flux & vortex circulation

figure,
title('Cl, flux & vortex circulation')
hold on,

% Flux plot
yyaxis left
plot(piv.tc, [nan*ones(1,250), filter(b,a,abs(circulation_box(251:end)))], 'DisplayName', 'Flux')
ylabel('Circulation Flux')

yyaxis right
plot(piv.tc, piv.Cl)
hold on,
plot(piv.tc, abs(filter(b,a,gamma2.circulationCW)), '-', 'DisplayName', 'LEV Circulation', 'color', colors(1,:))

legend show
legend('autoupdate', 'off')

for n = 1:3
    area([piv.tc(n_LEV(n,1)), piv.tc(n_LEV(n,2))], 1.1*max(piv.Cl)*ones(1,2), 'facealpha', 0.2, 'linestyle', 'none')
    area([piv.tc(n_LEV(n,1)), piv.tc(n_LEV(n,2))], 1.1*max(piv.Cl)*ones(1,2), 'facecolor', 'blue', 'facealpha', 0.2, 'linestyle', 'none')
end
