function distancies_LOS=calcular_distancies_LOS(coord_bs, shadows, X_cell, Y_cell)



    for i=-fin_x:fin_x
        for j=-finY:Y_cell
            P=[i,j];
            if isinterior(total_shadows,P)
                matriu_distancies(i+X_cell+1,j+Y_cell+1)=Inf;
            else
                d=((coord_bs(1)-i)^2+(coord_bs(2)-j)^2)^(1/2);
                matriu_distancies(i+X_cell+1,j+Y_cell+1)=d;
            end
        end
    end
    matriu_distancies=flipud(matriu_distancies.');
end