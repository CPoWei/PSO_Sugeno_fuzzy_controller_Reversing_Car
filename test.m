controlModel= readfis('controlModel_trained.fis');

fprintf('Press "Enter" to begin\n\n');
pause;

again = 'y';
while(again == 'y')
    x = input('Please enter initial coordinate X (range from 0 to 100)\n');
    y = input('Please enter initial coordinate Y (range from 0 to 100)\n');
    phi = input('Please enter initial angle "phi" (range from -90 to 270 in degrees)\n');
    alpha = input('Please enter step size "alpha" (alpha will be 1 in default if you just type in "Enter")\n');

    [status, x_p, y_p, phi_p, steps] = truck_reversing_fuzzy_controller(controlModel, x, y, phi, alpha, 1);
    fprintf(['x = %.2f\n', 'y = %.2f\n', 'phi = %.2f in degrees\n', 'steps = %d\n'], x_p, y_p, phi_p*180 / pi, steps);
    again = input('Try it again? [y/n]\n', 's');
end