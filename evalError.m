function mainPara = evalError(controlModel, mainPara, testPara, traErrSwitch)
    
    population = mainPara.population;
    
    X = testPara.X;
    Y = testPara.Y;
    Phi = testPara.Phi;
    X_exp = repmat(X, length(Y), 1);
    X_exp = X_exp(:);
    Y_exp = repmat(Y', 1, length(X));
    Y_exp = Y_exp(:);
    
    for i = 1 : population;
        docking_error = 0;
        trajectory_error = 0;
        
        [controlModel.input(1).mf.params] = mainPara.para_cell{i, 1}{:};
        [controlModel.input(2).mf.params] = mainPara.para_cell{i, 2}{:};
        [controlModel.output.mf.params] = mainPara.para_cell{i, 3}{:};
        
        for j = 1 : length(Phi);
            phi = Phi(1, j);
            for k = 1 : length(X)*length(Y);
                x = X_exp(k, 1);
                y = Y_exp(k, 1);
                [~, x_p, y_p, phi_p, steps] = truck_reversing_fuzzy_controller(controlModel, x, y, phi, 1, 0);
                docking_error = docking_error + sqrt(((0.5*pi - phi_p) / pi)^2 + ((50 - x_p) / 50)^2 + ((100 - y_p) / 100)^2);
                if traErrSwitch == 1
                    trajectory_error = trajectory_error + (steps / sqrt((50 - x)^2 + (100 - y)^2));
                    %fprintf('(%d/%d)\n', (j + length(X)*length(Y)*(k - 1)), length(X)*length(Y)*length(Phi));
                end
            end
        end
        docking_error = docking_error / (length(X)*length(Y)*length(Phi));
        if mainPara.dockingError(i, 1) > docking_error
            mainPara.dockingError(i, 1) = docking_error;
            mainPara.outstanding.para_cell(i, :) = mainPara.para_cell(i, :);
        end
        if traErrSwitch == 1
            trajectory_error = trajectory_error / (length(X)*length(Y)*length(Phi));
            if mainPara.trajectoryError(i, 1) > trajectory_error
                mainPara.trajectoryError(i, 1) = trajectory_error;
            end
        end
        
    end
    
    mainPara.dockingError((end - 1), 1) = mean(mainPara.dockingError((1 : population), 1));
    [mainPara.dockingError(end, 1), index] = min(mainPara.dockingError((1 : population), 1));
    mainPara.outstanding.particle = mainPara.para_cell(index, :);
    
end