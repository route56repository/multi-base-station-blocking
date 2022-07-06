function buildings=generate_buildings(lambda, L_max, X_cell, Y_cell)
    
    centers=generate_centers(lambda, X_cell, Y_cell);
    N_buildings=size(centers,1);

    %Random building shapes
    lengths=L_max*rand(N_buildings,1);
    angle=pi*rand(N_buildings,1);

    buildings = [-lengths/2 .* cos(angle), -lengths/2 .* sin(angle), ...
             +lengths/2 .* cos(angle), +lengths/2 .* sin(angle)];

    buildings=buildings+[centers,centers];
end
