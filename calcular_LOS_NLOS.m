function [matriu_booleans, matriu_distancies]=calcular_LOS_NLOS(coord_bs, shadows, X_grid, Y_grid)
    
    % LOS=1, NLOS=0

    for i=-X_grid:X_grid
        for j=-Y_grid:Y_grid
            if isinterior(shadows, i,j)
                matriu_booleans(i+X_grid+1,j+Y_grid+1)=0;
                matriu_distancies(i+X_grid+1,j+Y_grid+1)=Inf;
            else
                matriu_booleans(i+X_grid+1,j+Y_grid+1)=1;
                matriu_distancies(i+X_grid+1,j+Y_grid+1)=((coord_bs(1)-i)^2+(coord_bs(2)-j)^2)^(1/2);
            end
        end
    end
    matriu_booleans=flipud(matriu_booleans.');
    matriu_distancies=flipud(matriu_distancies.');

end