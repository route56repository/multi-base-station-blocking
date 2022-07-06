function matriu_total=calcular_maxim(matrius, id)
    [N_bs,N_i, N_j]=size(matrius);
   
    for i=1:N_i
        for j=1:N_j
            if id==0
                maxim=-Inf;
            else
                maxim=0;
            end
            for n_bs=1:N_bs
                if maxim<matrius(n_bs,i,j)
                    maxim=matrius(n_bs,i,j);
                end
            end
            matriu_total(i,j)=maxim;
        end
    end
% end

