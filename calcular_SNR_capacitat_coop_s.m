function [matriu_SNR_coop_s, matriu_capacitat_coop_s]=calcular_SNR_capacitat_coop_s(distancies, SNR_1m, alfa,...
    X_grid, Y_grid,N)

    SNR_1m_lineal=10^(SNR_1m/10);
    N_bs=size(distancies,3);
    
    for i=-X_grid:X_grid
        for j=-Y_grid:Y_grid

            SNR=(sum(distancies(i+X_grid+1,j+Y_grid+1,1:N).^(-alfa/2))^2*SNR_1m_lineal)/(1+SNR_1m_lineal*sum(distancies(i+X_grid+1,j+Y_grid+1,N+1:N_bs).^(-alfa)));
            
            matriu_capacitat_coop_s(i+X_grid+1,j+Y_grid+1)= log2(1+SNR); %bps/Hz (crec)
            matriu_SNR_coop_s(i+X_grid+1,j+Y_grid+1)= 10*log10(SNR); %dB
    
        end
    end
end
 