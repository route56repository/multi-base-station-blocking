function intersection=square_intersection(point, coord_bs, X_cell, Y_cell)

    point(1)=point(1)-coord_bs(1);
    point(2)=point(2)-coord_bs(2);



    if(point(1)==0) ||abs(point(2)/point(1)*(X_cell-coord_bs(1))+coord_bs(2))>Y_cell || ...
            abs(point(2)/point(1)*(-coord_bs(1)-X_cell)+coord_bs(2))>Y_cell 
        y=sign(point(2))*Y_cell;
        x=coord_bs(1)+(sign(point(2))*Y_cell-coord_bs(2))*point(1)/point(2);
        if abs(x)>X_cell
        x=sign(point(1))*X_cell;
        y=coord_bs(2)+(sign(point(1))*X_cell-coord_bs(1))*point(2)/point(1);
        %display('sha equivocat')
        end
    
    else
        x=sign(point(1))*X_cell;
        y=coord_bs(2)+(sign(point(1))*X_cell-coord_bs(1))*point(2)/point(1);
    end

    intersection=round([x,y]);

end

