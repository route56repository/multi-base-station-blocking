function centers=generate_centers(lambda,X_cell,Y_cell)

    A=4*X_cell*Y_cell;

    %valor poisson
    N_points=poissrnd(lambda*A);

    %posicions rnd 
    x_centers=X_cell*(-1+2*rand(N_points,1));
    y_centers=Y_cell*(-1+2*rand(N_points,1));
    centers=[x_centers,y_centers];
end