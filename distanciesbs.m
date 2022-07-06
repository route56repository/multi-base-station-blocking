function distanciesbs=distanciesbs(distancies_total)

    [N_bs, N_i, N_j]=size(distancies_total);

    for i=1:N_i
        for j=1:N_j
            D=sort(distancies_total(:,i,j));
            distanciesbs(i,j,:)=D;
        end
    end
end