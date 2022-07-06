function [matriu_SNR,matriu_capacitat_coop_m]=calcular_SNR_capacitat_coop_m(distancies, SNR_1m, alfa,...
    X_grid, Y_grid,N)

    SNR_1m_lineal=10^(SNR_1m/10);
    N_bs=size(distancies,3);
    
    for i=-X_grid:X_grid
        for j=-Y_grid:Y_grid
            
            %Calcul SNR
            for n=1:N
                SNR(n)=N*SNR_1m_lineal*distancies(i+X_grid+1,j+Y_grid+1,n)^(-alfa)/(1+SNR_1m_lineal*sum(distancies(i+X_grid+1,j+Y_grid+1,N+1:N_bs).^(-alfa)));%lineal

                matriu_SNR(n,i+X_grid+1,j+Y_grid+1)=10*log10(SNR(n)); %dB
            end

            matriu_capacitat_coop_m(i+X_grid+1,j+Y_grid+1)=1/N*sum(log2(1+SNR));
   
        end
    end
end
 