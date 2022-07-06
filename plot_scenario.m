function plot_scenario(buildings, base_stations, title_string)

    plot(base_stations(:,1),base_stations(:,2),'^', 'MarkerEdgeColor','r','MarkerFaceColor','r')
    hold on

    N_buildings=size(buildings, 1);
    for n=1:N_buildings
        x_vec=[buildings(n,1),buildings(n,3)];
        y_vec=[buildings(n,2),buildings(n,4)];
        plot(x_vec, y_vec, 'b', 'LineWidth', 2 )
        hold on 
    end
    title(title_string)
    xlabel('x coord [m]')
    ylabel('y coord [m]')
end
