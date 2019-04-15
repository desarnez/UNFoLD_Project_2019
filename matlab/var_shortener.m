n1 = 1;
step = 5;
n2 = 4000;

run labbook1
c = 92;

load(pivmat(LB(c).ms, LB(c).mpt));
load(loadmat(LB(c).ms, LB(c).mpt));

u_comp_short = u_comp(:, :, n1:step:n2);
v_comp_short = v_comp(:, :, n1:step:n2);
o_comp_short = o_comp(:, :, n1:step:n2);
m_comp_short = m_comp(:, :, n1:step:n2);

piv_short.t = piv.t(n1:step:n2);
piv_short.tc = piv.tc(n1:step:n2);
piv_short.L = piv.L(n1:step:n2);
piv_short.D = piv.D(n1:step:n2);
piv_short.alpha = piv.alpha(n1:step:n2);
piv_short.alpha_mask = piv.alpha_mask(n1:step:n2);
piv_short.Cl = piv.Cl(n1:step:n2);
piv_short.Cd = piv.Cd(n1:step:n2);


% save('ms025mpt001_short.mat', 'piv', 'o_comp', 'v_comp', 'u_comp', 'm_comp', 'param')