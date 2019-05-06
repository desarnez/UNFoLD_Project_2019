yyaxis left
plot(piv.tc(150:end), piv.Cl(150:end), 'DisplayName', 'Cl')
legend show
hold on
for n = 1:3
    area([piv.tc(n_LEV(n,1)), piv.tc(n_LEV(n,2))], [2, 2], 'facealpha', 0.2, 'linestyle', 'none', 'DisplayName', 'LEV')
    area([piv.tc(n_TEV(n,1)), piv.tc(n_TEV(n,2))], [2, 2],'facecolor', 'blue', 'facealpha', 0.2, 'linestyle', 'none', 'DisplayName', 'TEV')
    if n == 1
        legend('autoupdate', 'off')
    end
end
axis([piv.tc(150), piv.tc(end), 0, 1.8])
xlabel('t_{c} [s]');
ylabel('Cl');
hold on

yyaxis right
ylabel('Circulation');
legend('autoupdate','on')
plot(piv.tc(150:end), abs(gamma2.circulationCCW(150:end)),'-b', 'DisplayName', 'TEV Circulation');
plot(piv.tc(150:end), abs(gamma2.circulationCW(150:end)),'-g', 'DisplayName', 'LEV Circulation');
legend show
legend('Location', 'NorthWest'),legend('boxoff')
yyaxis left