function mainPara = initialParticle(controlModel, mainPara, testPara)

    mfParaNum = mainPara.mfParaNum;
    population = mainPara.population;
    
    for i = 1 : population;
        X_rand = 100.*rand(5, mfParaNum);
        vX_rand = zeros(5, mfParaNum); 
        Phi_rand = -90 + 360.*rand(7, mfParaNum);
        vPhi_rand = zeros(7, mfParaNum);
        Theta_rand = (-30) + 60.*rand(7, (mfParaNum - 1));
        vTheta_rand = zeros(7, (mfParaNum - 1));
         
        X_rand = mat2cell(X_rand, ones(1, 5));
        Phi_rand = mat2cell(Phi_rand, ones(1, 7));
        Theta_rand = mat2cell(Theta_rand, ones(1, 7));
        mainPara.para_cell(i, :) = {X_rand, Phi_rand, Theta_rand};
          
        vX_rand = mat2cell(vX_rand, ones(1, 5));
        vPhi_rand = mat2cell(vPhi_rand, ones(1, 7));
        vTheta_rand = mat2cell(vTheta_rand, ones(1, 7)); 
        mainPara.velocity.vel(i, :) = {vX_rand, vPhi_rand, vTheta_rand};
        
        [controlModel.input(1).mf.params] = mainPara.para_cell{i, 1}{:};
        [controlModel.input(2).mf.params] = mainPara.para_cell{i, 2}{:};
        [controlModel.output.mf.params] = mainPara.para_cell{i, 3}{:};
 
        [docking_error, ~] = singleEvalError(controlModel, testPara, 0);
        mainPara.dockingError(i, 1) = docking_error;
        
    end
    
    mainPara.dockingError((end - 1), 1) = mean(mainPara.dockingError((1 : population), 1));
    [mainPara.dockingError(end, 1), index] = min(mainPara.dockingError((1 : population), 1));
    mainPara.outstanding.para_cell = mainPara.para_cell;
    mainPara.outstanding.particle = mainPara.para_cell(index, :);
    fprintf('Generation : 1 | mean_docking_error : %.4f | outstanding_docking_error : %.4f\n', mainPara.dockingError((end - 1), 1), ...
                                                                                               mainPara.dockingError(end, 1));
                                                                                           
end

%[c.input(1).mf.params] = d{:}
%r = a + (b-a).*rand(N,1)
%writefis(r, '/Users/jibowei/Desktop/r.fis')


