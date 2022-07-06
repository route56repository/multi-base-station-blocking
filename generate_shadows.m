function total_shadow=generate_shadows(buildings, coord_bs, X_cell, Y_cell)

    N_buildings=size(buildings(:,1));
    total_shadow = polyshape([0,0]);

    for i_buildings=1:N_buildings
        point1=buildings(i_buildings,1:2);
        point2=buildings(i_buildings,3:4);
        point3=square_intersection(point1, coord_bs, X_cell, Y_cell);
        point4=square_intersection(point2, coord_bs, X_cell, Y_cell);

        polygon=polyshape([point1; point2; point4; point3]);


        if abs(point3(1))==X_cell && abs(point4(2))==Y_cell
            point5=[point3(1), point4(2)];
            polygon=polyshape([point1; point2; point4; point5; point3]);
            

        elseif abs(point4(1))==X_cell && abs(point3(2))==Y_cell
            point5=[point4(1),point3(2)];
            polygon=polyshape([point1; point2; point4; point5; point3]);
            

        end

        total_shadow=union(total_shadow, polygon);

    end

end 