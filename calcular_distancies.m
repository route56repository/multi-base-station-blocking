function distancies=calcular_distancies(coord_bs, X_grid, Y_grid)

    for i=-X_grid:X_grid
        for j=-Y_grid:Y_grid
            distancies(i+X_grid+1,j+Y_grid+1)=((coord_bs(1)-i)^2+(coord_bs(2)-j)^2)^(1/2);
        end
    end
    distancies=flipud(distancies.');

end
