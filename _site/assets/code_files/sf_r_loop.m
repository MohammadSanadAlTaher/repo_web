clear; clc;

phi = 0:pi/1000:2*pi;

a_s = 1; b_s = 1; x_s = 6; y_s = 6; n_1 = -2.5; n_2 = 10; n_3 = 10; % change for different shapes

r_phi = (((abs(cos((x_s.*phi)./4))./a_s).^(n_2)) + ((abs(sin((y_s.*phi)./4))./a_s).^(n_3))).^(-(1/n_1));

r_t = input("input maximum distance from center to edge of shape: ")

r_phi_max1 = max(r_phi); r_phi_max2 = max(r_phi);

r_phi_cur = 1; r_phi_prev = 0.9; % Trigger one of the cases
del = 0.0005; i = 9; % Switch immediately
while r_phi_max1 < r_t
    i = i+1;
    if(mod(i, 10) == 0)
        switch (max(r_phi_cur) >= max(r_phi_prev))
            case 0
                del = -del;
            case 1
                del = del;
        end
    end

    r_phi_prev = (((abs(cos((x_s.*phi)./4))./a_s).^(n_2)) + ((abs(sin((y_s.*phi)./4))./a_s).^(n_3))).^(-(1/n_1));
    a_s=a_s+del; b_s=b_s+del;
    r_phi_cur = (((abs(cos((x_s.*phi)./4))./a_s).^(n_2)) + ((abs(sin((y_s.*phi)./4))./a_s).^(n_3))).^(-(1/n_1));
    r_phi = (((abs(cos((x_s.*phi)./4))./a_s).^(n_2)) + ((abs(sin((y_s.*phi)./4))./a_s).^(n_3))).^(-(1/n_1));
    r_phi_max1 = max(r_phi);
end


r_phi_cur = 0.9; r_phi_prev = 1; % % Trigger desired case
while r_phi_max2 > r_t
    i = i+1;
    if(mod(i, 10) == 0)
        switch (max(r_phi_cur) <= max(r_phi_prev))
            case 0
                del = -del;
            case 1
                del = del;
        end
    end

    r_phi_prev = (((abs(cos((x_s.*phi)./4))./a_s).^(n_2)) + ((abs(sin((y_s.*phi)./4))./a_s).^(n_3))).^(-(1/n_1));
    a_s=a_s+del; b_s=b_s+del;
    r_phi_cur = (((abs(cos((x_s.*phi)./4))./a_s).^(n_2)) + ((abs(sin((y_s.*phi)./4))./a_s).^(n_3))).^(-(1/n_1));
    r_phi = (((abs(cos((x_s.*phi)./4))./a_s).^(n_2)) + ((abs(sin((y_s.*phi)./4))./a_s).^(n_3))).^(-(1/n_1));
    r_phi_max2 = max(r_phi);
end


polarplot(phi, r_phi,'LineWidth', 4)
grid on;

a_s, b_s

