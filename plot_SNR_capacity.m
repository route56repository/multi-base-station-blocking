function plot_SNR_capacity(matriu_SNR,matriu_capacitat, X_grid,Y_grid, title_SNR, title_capacity)

    x_vec=-X_grid:X_grid;
    y_vec=-Y_grid:Y_grid;

    figure,
    matriu_SNR(matriu_SNR(:,:)>45)=45;
    imagesc(x_vec, y_vec, matriu_SNR)
    colorbar('Ticks',[-20,-10,0,10,20,30,40,50])
    xlabel('x coord [m]')
    ylabel('y coord [m]')
    title(title_SNR);

    figure,
    matriu_capacitat(matriu_capacitat(:,:)>20)=20;
    imagesc(x_vec, y_vec, matriu_capacitat)
    title(title_capacity);
    xlabel('x coord [m]')
    ylabel('y coord [m]')
    colorbar('Ticks',[0,5,10,15,20])

end