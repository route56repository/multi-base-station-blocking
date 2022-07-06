function [matriu_SNR, matriu_capacitat]=calcular_SNR_capacitat(distancies_LOS,SNR_1m, alfa, X_grid, Y_grid)
    for i=-X_grid:X_grid
        for j=-Y_grid:Y_grid
    
            %Calcul SNR
            SNR_total=SNR_1m-alfa*10*log10(distancies_LOS(i+X_grid+1,j+Y_grid+1));

            matriu_SNR(i+X_grid+1,j+Y_grid+1)=SNR_total;
            matriu_capacitat(i+X_grid+1,j+Y_grid+1)=log2(1+(distancies_LOS(i+X_grid+1,j+Y_grid+1)^(-alfa))*10^(SNR_1m/10));

        end
    end
end
