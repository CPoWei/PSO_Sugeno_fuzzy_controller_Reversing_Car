function mainPara = particleEvolve(mainPara)
   
    phi_1 = rand(1, 1);
    phi_2 = rand(1, 1);
    
    %Migration 
    for i = 1 : mainPara.population;
        %load parameter
        para_X = cell2mat(mainPara.para_cell{i, 1});
        para_Phi = cell2mat(mainPara.para_cell{i, 2});
        para_Theta = cell2mat(mainPara.para_cell{i, 3});
        
        locOutstanding_para_X = cell2mat(mainPara.outstanding.para_cell{i, 1});
        locOutstanding_para_Phi = cell2mat(mainPara.outstanding.para_cell{i, 2});
        locOutstanding_para_Theta = cell2mat(mainPara.outstanding.para_cell{i, 3});
        
        vX = cell2mat(mainPara.velocity.vel{i, 1});
        vPhi = cell2mat(mainPara.velocity.vel{i, 2});
        vTheta = cell2mat(mainPara.velocity.vel{i, 3});
        
        %calculate velocity
        vX = vX + mainPara.C1*phi_1*(locOutstanding_para_X - para_X) ...
                + mainPara.C2*phi_2*(cell2mat(mainPara.outstanding.particle{1, 1}) - para_X);
        vPhi = vPhi + mainPara.C1*phi_1*(locOutstanding_para_Phi - para_Phi) ...
                + mainPara.C2*phi_2*(cell2mat(mainPara.outstanding.particle{1, 2}) - para_Phi);
        vTheta = vTheta + mainPara.C1*phi_1*(locOutstanding_para_Theta - para_Theta) ...
                        + mainPara.C2*phi_2*(cell2mat(mainPara.outstanding.particle{1, 3}) - para_Theta);
              
        vX(abs(vX) > mainPara.velocity.max(1, 1)) = mainPara.velocity.max(1, 1)*sign(vX(abs(vX) > mainPara.velocity.max(1, 1)));
        vPhi(abs(vPhi) > mainPara.velocity.max(1, 2)) = mainPara.velocity.max(1, 2)*sign(vPhi(abs(vPhi) > mainPara.velocity.max(1, 2)));
        vTheta(abs(vTheta) > mainPara.velocity.max(1, 3)) = mainPara.velocity.max(1, 3)*sign(vTheta(abs(vTheta) > mainPara.velocity.max(1, 3)));

        %calculate position
        para_X = para_X + vX;
        para_Phi = para_Phi + vPhi;
        para_Theta = para_Theta + vTheta;
        
        para_X(para_X > 100) = 100;
        para_X(para_X <= 0) = 0.001;

        para_Phi(para_Phi > 270) = 270;
        para_Phi(para_Phi < -90) = -90;
        para_Phi(para_Phi == 0) = 0.001;

        para_Theta(para_Theta > 30) = 30;
        para_Theta(para_Theta < -30) = -30;
        para_Theta(para_Theta == 0) = 0.001;
        
        vX = mat2cell(vX, ones(1, 5));
        para_X = mat2cell(para_X, ones(1, 5));
        vPhi = mat2cell(vPhi, ones(1, 7));
        para_Phi = mat2cell(para_Phi, ones(1, 7));
        vTheta = mat2cell(vTheta, ones(1, 7));
        para_Theta = mat2cell(para_Theta, ones(1, 7));
        
        mainPara.velocity.vel(i, :) = {vX, vPhi, vTheta};
        mainPara.para_cell(i, :) = {para_X, para_Phi, para_Theta};
        
    end
    
end







