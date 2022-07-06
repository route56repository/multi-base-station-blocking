function [matriu_SNR_I, matriu_capacitat_I]=calcular_SNR_capacitat_I(distancies, SNR_1m, alfa,...
    X_grid, Y_grid)
    
    SNR_1m_lineal=10^(SNR_1m/10);
    N_bs=size(distancies,3);

    for i=-X_grid:X_grid
        for j=-Y_grid:Y_grid   
             SNR=(distancies(i+X_grid+1,j+Y_grid+1,1)^(-alfa)*SNR_1m_lineal)/(1+SNR_1m_lineal*sum(distancies(i+X_grid+1,j+Y_grid+1,2:N_bs).^(-alfa)));
             matriu_SNR_I(i+X_grid+1,j+Y_grid+1)=10*log10(SNR);
             matriu_capacitat_I(i+X_grid+1,j+Y_grid+1)=log2(1+SNR);
        end
    end
end
