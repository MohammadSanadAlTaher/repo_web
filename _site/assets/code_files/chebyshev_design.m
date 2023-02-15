clear; clc;
format long g

%%%% Constants %%%%
a=22.86.*10.^(-3); b=10.16.*10.^(-3); th = 0.5*10^(-3);
C = input("Input coupling factor: ");
D_m = input("Input minimum directivity: ");
N = input("Input number of holes: ")-1;
d_eq = input("Port 4 input 'i' = isolated, input 'm' = maximized, input 'na' = a/4 offset: ", 's');

%%%% Calculations at Operating Frequency %%%%
f_op = (9).*10.^9;
k_0 = 2.*pi.*f_op./(3.*10.^8); lambda_0 = (3.*10.^8)./f_op;
beta = sqrt(k_0.^2 - (pi./a).^2);
if strcmp(d_eq, 'i')
    d = a.*asin(lambda_0./(sqrt(6).*a))./pi;
elseif strcmp(d_eq, 'm')
    d = a.*asin(lambda_0./(sqrt(2.*(lambda_0.^2 - a.^2))))./pi;
elseif strcmp(d_eq, 'na')
    d = a/4;
end
fprintf("\nOffset: ")
fprintf("%f", d)
fprintf("\n")
lambda_g = 2.*pi./beta;
s = lambda_g./4; %spacing
fprintf("\nHole spacing: ")
fprintf("%f", s)
fprintf("\n")

if strcmp(d_eq, 'i') || strcmp(d_eq, 'na')
    T_f = -1j.*((2.*(k_0).^2)./(3.*beta.*a.*b)).*((sin((pi.*d)./(a))).^2) + 1j.*((4./(3.*a.*b))).*((beta.*(sin((pi.*d)./(a))).^2) + ((((pi).^2)./(beta.*a.^2))).*(cos((pi.*d)./(a))).^2);
    T_b = -1j.*((2.*(k_0).^2)./(3.*beta.*a.*b)).*((sin((pi.*d)./(a))).^2) - 1j.*((4./(3.*a.*b))).*((beta.*(sin((pi.*d)./(a))).^2) - ((((pi).^2)./(beta.*a.^2))).*(cos((pi.*d)./(a))).^2);
elseif strcmp(d_eq, 'm')
    T_b = -1j.*((2.*(k_0).^2)./(3.*beta.*a.*b)).*((sin((pi.*d)./(a))).^2) + 1j.*((4./(3.*a.*b))).*((beta.*(sin((pi.*d)./(a))).^2) + ((((pi).^2)./(beta.*a.^2))).*(cos((pi.*d)./(a))).^2);
    T_f = -1j.*((2.*(k_0).^2)./(3.*beta.*a.*b)).*((sin((pi.*d)./(a))).^2) - 1j.*((4./(3.*a.*b))).*((beta.*(sin((pi.*d)./(a))).^2) - ((((pi).^2)./(beta.*a.^2))).*(cos((pi.*d)./(a))).^2);
end

sec_theta_m = fzero(@(x) (10^(D_m/20)) - chebyshevT(N,x), 1);
theta_m = asec(sec_theta_m);
T_N = chebyshevT(N, sec_theta_m);
K = (10.^(-(C)./(20)))./(abs(T_f) .* T_N);
coef = [ceil(N/2)+1];
r = [N+1];

if mod(N, 2) == 0
    coef(ceil(N/4)+1) = 1/(2*pi)*integral(@(x)chebyshevT(N,sec_theta_m*cos(x)), -pi, pi);
    r(ceil(N/2)+1) = abs(((coef(ceil(N/4)+1))*(K))^(1/3));
end
for i = 1:ceil(N/2)
    coef(i) = (1/pi)*integral(@(x) cos((N-2*(i-1))*x).*chebyshevT(N, sec_theta_m*cos(x)), -pi, pi);
    r(i) = abs(((coef(i))*(K/2))^(1/3));
end
for i = 1:ceil(N/2)
    r(N+2-i) = r(i);
end
fprintf("\nradii:\n")
fprintf("%f\n", r(1:end))
fprintf("\n")

theta_upper = pi - theta_m;
f_lower = ((3.*10.^8)./(2.*pi)).*(sqrt(((((2.*beta)./(pi).*theta_m).^2)+((pi./a).^2))));
f_upper = ((3.*10.^8)./(2.*pi)).*(sqrt(((((2.*beta)./(pi).*theta_upper).^2)+((pi./a).^2))));

%%%% Sweep Calculations %%%%
f_start = max(round(f_lower*10^(-9),0)*10^9-1*10^9, 7*10^9);
f_end = min(round(f_upper*10^(-9),0)*10^9+1*10^9, 13*10^9);
f_sweep = f_start:0.001*10.^9:f_end;
k_s = 2.*pi.*f_sweep./(3.*10.^8); lambda_0_s = (3.*10.^8)./f_sweep;
beta_s = sqrt(k_s.^2 - (pi./a).^2);

if strcmp(d_eq, 'i') || strcmp(d_eq, 'na')
    T_f_s = -1j.*((2.*(k_s).^2)./(3.*beta_s.*a.*b)).*((sin((pi.*d)./(a))).^2) + 1j.*((4./(3.*a.*b))).*((beta_s.*(sin((pi.*d)./(a))).^2) + ((((pi).^2)./(beta_s.*a.^2))).*(cos((pi.*d)./(a))).^2);
    T_b_s = -1j.*((2.*(k_s).^2)./(3.*beta_s.*a.*b)).*((sin((pi.*d)./(a))).^2) - 1j.*((4./(3.*a.*b))).*((beta_s.*(sin((pi.*d)./(a))).^2) - ((((pi).^2)./(beta_s.*a.^2))).*(cos((pi.*d)./(a))).^2);
elseif strcmp(d_eq, 'm')
    T_b_s = -1j.*((2.*(k_s).^2)./(3.*beta_s.*a.*b)).*((sin((pi.*d)./(a))).^2) + 1j.*((4./(3.*a.*b))).*((beta_s.*(sin((pi.*d)./(a))).^2) + ((((pi).^2)./(beta_s.*a.^2))).*(cos((pi.*d)./(a))).^2);
    T_f_s = -1j.*((2.*(k_s).^2)./(3.*beta_s.*a.*b)).*((sin((pi.*d)./(a))).^2) - 1j.*((4./(3.*a.*b))).*((beta_s.*(sin((pi.*d)./(a))).^2) - ((((pi).^2)./(beta_s.*a.^2))).*(cos((pi.*d)./(a))).^2);
end

cheby_var = sec(theta_m).*cos(beta_s.*s);
C_sweep = -20.*log10(K.*abs(T_f_s).*abs(chebyshevT(N, sec(theta_m)))); % subtract 6 if pair of apertures
D_sweep = 20.*log10(abs(T_f_s./T_b_s)) + 20.*log10(abs(chebyshevT(N, sec(theta_m))./(chebyshevT(N, cheby_var))));
D_sweep_array = 20.*log10(abs(chebyshevT(N, sec(theta_m))./(chebyshevT(N, cheby_var))));
D_sweep_fb = 20.*log10(abs(T_f_s./T_b_s));

%%%%% Coupling Factor with Thickness Estimation %%%%%
lambda_c_circ = [];
A = [];
A_tot = 0;
lambda_c_t = 0;
ap_th = 2*th;
for i =1:N+1
    lambda_c_circ(i) = (2.*pi.*r(i))./(1.841);
    A(i) = 0.065.*((r(i)).*2./ap_th)+1;
    A_tot = A_tot + A(i);
    lambda_c_t = lambda_c_t + lambda_c_circ(i);
end
A_avg = A_tot./(N+1);
lambda_c_avg = lambda_c_t/(N+1);
atten_avg_center = (-2.*pi.*A_avg.*ap_th)./(lambda_c_avg).*(1-(lambda_c_avg./lambda_0).^2).^(0.5);
atten_avg_s = (-2.*pi.*A_avg.*ap_th)./(lambda_c_avg).*(1-(lambda_c_avg./lambda_0_s).^2).^(0.5);
expected_C = C - 20.*log10(exp(atten_avg_center)) % subtract 6 if pair of apertures
expected_C_s = C_sweep - 20.*log10(exp(atten_avg_s));

%%%% Plots %%%%
if strcmp(d_eq, 'i')
    hold on;
    axis([f_start*10^(-9) f_end*10^(-9) 0 80])
    plot(f_sweep*10^(-9), C_sweep, 'LineWidth', 5, Color=[0, 0.4470, 0.7410])
    plot(f_sweep*10^(-9), expected_C_s, 'LineWidth', 3, 'LineStyle', '-.', Color=[0.4660, 0.6740, 0.1880])
    plot(f_sweep*10^(-9), D_sweep, 'LineWidth', 5, Color=[0.8500, 0.3250, 0.0980])
    plot(f_sweep*10^(-9), D_sweep_array, 'LineWidth', 3, LineStyle=':', Color=[0.9290, 0.6940, 0.1250])
    plot(f_sweep*10^(-9), D_sweep_fb, 'LineWidth', 3, LineStyle=':', Color=[0.4940, 0.1840, 0.5560])
    yline(30, 'LineWidth', 2, 'LineStyle', '-.', Color=[0.25, 0.25, 0.25])
    set(gca, 'fontweight', 'bold','fontsize', 22)
    xlabel('f (GHz)', 'fontsize',22)
    ylabel('C, D (dB)', 'fontsize', 22)
    legend('C', 'C--expected', 'D', 'D from array factor', 'D from forward and backward waves', 'Interpreter','latex')
    hold off; grid on; set(figure(1), 'Position', [100 100 800 500]);

elseif strcmp(d_eq, 'na')
    hold on;
    axis([f_start*10^(-9) f_end*10^(-9) 0 100])
    plot(f_sweep*10^(-9), C_sweep, 'LineWidth', 5)
    plot(f_sweep*10^(-9), D_sweep, 'LineWidth', 5)
    plot(f_sweep*10^(-9), D_sweep_array, 'LineWidth', 5, LineStyle=':')
    plot(f_sweep*10^(-9), D_sweep_fb, 'LineWidth', 5, LineStyle=':')
    yline(30, 'LineWidth', 2, 'LineStyle', '-.', Color=[0.25, 0.25, 0.25])
    set(gca, 'fontweight', 'bold','fontsize', 22, 'YDir', 'reverse')
    xlabel('f (GHz)', 'fontsize',22)
    ylabel('C, D (dB)', 'fontsize', 22)
    legend('C', 'D', 'D from array factor', 'D from forward and backward waves', 'Interpreter','latex')
    hold off; grid on; grid minor;set(figure(1), 'Position', [100 100 800 500]);

elseif strcmp(d_eq, 'm')
    hold on;
    axis([f_start*10^(-9) f_end*10^(-9) 0 100])
    plot(f_sweep*10^(-9), C_sweep, 'LineWidth', 5)
    plot(f_sweep*10^(-9), D_sweep, 'LineWidth', 5)
    plot(f_sweep*10^(-9), D_sweep_array, 'LineWidth', 5, LineStyle=':')
    plot(f_sweep*10^(-9), D_sweep_fb, 'LineWidth', 5, LineStyle=':')
    yline(30, 'LineWidth', 2, 'LineStyle', '-.', Color=[0.25, 0.25, 0.25])
    set(gca, 'fontweight', 'bold','fontsize', 22, 'YDir', 'reverse')
    xlabel('f (GHz)', 'fontsize',22)
    ylabel('C, D (dB)', 'fontsize', 22)
    legend('C', 'D', 'D from array factor', 'D from forward and backward waves', 'Interpreter','latex')
    hold off; grid on; grid minor;set(figure(1), 'Position', [100 100 800 500]);
end