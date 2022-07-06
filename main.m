clear all;
close all;

warning('off','all') %Do not display polyshape warnings

%% Simulation parameters

P_tx=33; %dBm
Pn=-104; %dBm
L_ref=25.6; %dB
alfa=4;

SNR_1m=P_tx-Pn-L_ref;

lambda_buildings=4.5*10^-4; % 0.0002%Densitat edificis 
lambda_bs=1e-5; %Densitat estacions base

L_max=50; %max length buildings

% X_cell i Y_cell han de ser divisibles per 6
X_cell=900; %1/2 amplada escenari
Y_cell=900; %1/2 llargada escenari

N_ciutats=50;

%% Deployment of the scenario

for k=26:N_ciutats
    disp(num2str(lambda_buildings))
    buildings=generate_buildings(lambda_buildings,L_max,X_cell,Y_cell);

    base_stations=generate_centers(lambda_bs, X_cell, Y_cell);

    N_base_stations=size(base_stations, 1);

    disp(['Num ciutat: ', num2str(k)])
    disp(['Num bs: ', num2str(N_base_stations)])


%     title_string='Scenario';
%     figure,
%     plot_scenario(buildings, base_stations, title_string);
    

    distancies=[];
    for n_bs=1:N_base_stations
        disp(['Calculant paràmetres bs#',num2str(n_bs),' ...'])
        coord_bs=base_stations(n_bs,1:2);

        shadows=generate_shadows(buildings, coord_bs, X_cell, Y_cell);

        % display scenario for each base station

%         title_string=['Shadows for bs#',num2str(n_bs)];
%         figure,
%         plot(shadows, 'FaceColor', rand(3,1))
%         hold on
%         plot_scenario(buildings, coord_bs, title_string);

        X_grid=X_cell/3;
        Y_grid=Y_cell/3;
        % matriu distancies (dintre grid petit)
        distancies=calcular_distancies(coord_bs, X_grid, Y_grid);
        distancies_total(n_bs,:,:)=distancies;

        % LOS/NLOS boolean+distancies
        [boolean_LOS, distancies_LOS]=calcular_LOS_NLOS(coord_bs,shadows, X_grid, Y_grid);
        boolean_LOS_total(n_bs, :,:)=boolean_LOS;
        distancies_LOS_total(n_bs,:,:)=distancies_LOS;

        % Càlcul SNR i capacitat

        [matriu_SNR, matriu_capacitat]=calcular_SNR_capacitat(distancies_LOS, SNR_1m, alfa, X_grid, Y_grid);

        matriu_SNR_total(n_bs,:,:)=matriu_SNR;
        matriu_capacitat_total(n_bs,:,:)=matriu_capacitat;


%         title_SNR='SNR considerant una estació base [dB]';
%         title_capacity='Capacitat considerant una estació base [bps/Hz]';
%         plot_SNR_capacity(matriu_SNR,matriu_capacitat, X_grid,Y_grid, title_SNR, title_capacity);

    end

    %% SNR i capacitat total a la ciutat


    matriu_SNR_NI=calcular_maxim(matriu_SNR_total, 0);
    matriu_capacitat_NI=calcular_maxim(matriu_capacitat_total, 1);

%     title_SNR='SNR [dB]';
%     title_capacity='Capacitat sense interferències [bps/Hz]';
%     plot_SNR_capacity(matriu_SNR_NI, matriu_capacitat_NI, X_grid,Y_grid, title_SNR, title_capacity);

    %% Buscar e.b més aprop en cada punt
    
    distanciesbs_LOS=distanciesbs(distancies_LOS_total);

    distancies1_LOS=distanciesbs_LOS(:,:,1);
    distancies2_LOS=distanciesbs_LOS(:,:,2);
    distancies3_LOS=distanciesbs_LOS(:,:,3);
    distancies4_LOS=distanciesbs_LOS(:,:,4);

    distancies1_LOS=distancies1_LOS(:);
    distancies2_LOS=distancies2_LOS(:);
    distancies3_LOS=distancies3_LOS(:);
    distancies4_LOS=distancies4_LOS(:);

    distanciesbs=distanciesbs(distancies_total);

    distancies1=distanciesbs(:,:,1);
    distancies2=distanciesbs(:,:,2);
    distancies3=distanciesbs(:,:,3);
    distancies4=distanciesbs(:,:,4);

    %% Càlcul SNR en cada posició suposant interferencies de les altres bs


    [matriu_SNR_I, matriu_capacitat_I]=calcular_SNR_capacitat_I(distanciesbs_LOS, SNR_1m, alfa,...
         X_grid, Y_grid);

%     title_SNR='SINR [dB]';
%     title_capacity='Capacitat amb interferències  [bps/Hz]';
%     plot_SNR_capacity(matriu_SNR_I, matriu_capacitat_I, X_grid,Y_grid, title_SNR, title_capacity);

    %% Càlcul SNR en cada posició suposant cooperació a nivell de senyal (cooperació entre 2 bs) + altres bs interferencies

    [matriu_SNR_coop_s2, matriu_capacitat_coop_s2]=calcular_SNR_capacitat_coop_s(distanciesbs_LOS, SNR_1m, alfa,...
        X_grid, Y_grid, 2);

%     title_SNR='SINR amb cooperació a nivell de senyal entre 2 bs [dB]';
%     title_capacity='Capacitat amb cooperació a nivell de capa física entre 2 bs [bps/Hz]';
%     plot_SNR_capacity(matriu_SNR_coop_s2, matriu_capacitat_coop_s2, X_grid,Y_grid, title_SNR, title_capacity);

    %% Càlcul SNR en cada posició suposant cooperació a nivell de senyal (cooperació entre 3 bs) + altres bs interferencies

    [matriu_SNR_coop_s3, matriu_capacitat_coop_s3]=calcular_SNR_capacitat_coop_s(distanciesbs_LOS, SNR_1m, alfa,...
        X_grid, Y_grid, 3);

%     title_SNR='SINR amb cooperació a nivell de senyal entre 3 bs [dB]';
%     title_capacity='Capacitat amb cooperació a nivell de capa física entre 3 bs [bps/Hz]';
%     plot_SNR_capacity(matriu_SNR_coop_s3, matriu_capacitat_coop_s3, X_grid,Y_grid, title_SNR, title_capacity);

    %% Càlcul SNR en cada posició suposant cooperació a nivell de senyal (cooperació entre 4 bs) + altres bs interferencies

    [matriu_SNR_coop_s4, matriu_capacitat_coop_s4]=calcular_SNR_capacitat_coop_s(distanciesbs_LOS, SNR_1m, alfa,...
        X_grid, Y_grid, 4);
%     title_SNR='SINR amb cooperació a nivell de senyal entre 4 bs [dB]';
%     title_capacity='Capacitat amb cooperació a nivell de capa física entre 4 bs [bps/Hz]';
%     plot_SNR_capacity(matriu_SNR_coop_s4, matriu_capacitat_coop_s4, X_grid,Y_grid, title_SNR, title_capacity);

    %% Càlcul SNR en cada posició suposant cooperació a nivell de senyal (cooperació entre 5 bs) + altres bs interferencies

    [matriu_SNR_coop_s5, matriu_capacitat_coop_s5]=calcular_SNR_capacitat_coop_s(distanciesbs_LOS, SNR_1m, alfa,...
        X_grid, Y_grid, 5);

%     title_SNR='SINR amb cooperació a nivell de senyal entre 5 bs [dB]';
%     title_capacity='Capacitat amb cooperació a nivell de capa física entre 5 bs [bps/Hz]';
%     plot_SNR_capacity(matriu_SNR_coop_s5, matriu_capacitat_coop_s5, X_grid,Y_grid, title_SNR, title_capacity);

    %% Càlcul SNR en cada posició suposant cooperació a nivell de multiplexat (cooperació entre 2 bs) + altres bs interferencies

    [matriu_SNR_coop_m2,matriu_capacitat_coop_m2]=calcular_SNR_capacitat_coop_m(distanciesbs_LOS, SNR_1m, alfa,...
        X_grid, Y_grid, 2);

%     title_SNR='SNR1 amb cooperació a nivell de multiplexat entre 2 bs [dB]';
%     title_capacity='Capacitat amb cooperació a nivell de capa MAC entre 2 bs [bps/Hz]';
%     plot_SNR_capacity(squeeze(matriu_SNR_coop_m2(1,:,:)), matriu_capacitat_coop_m2, X_grid,Y_grid, title_SNR, title_capacity);

    %% Càlcul SNR en cada posició suposant cooperació a nivell de multiplexat (cooperació entre 3 bs) + altres bs interferencies

    [matriu_SNR_coop_m3,matriu_capacitat_coop_m3]=calcular_SNR_capacitat_coop_m(distanciesbs_LOS, SNR_1m, alfa,...
        X_grid, Y_grid, 3);

%     title_SNR='SNR1 amb cooperació a nivell de multiplexat entre 3 bs [dB]';
%     title_capacity='Capacitat amb cooperació a nivell de capa MAC entre 3 bs [bps/Hz]';
%     plot_SNR_capacity(squeeze(matriu_SNR_coop_m3(1,:,:)), matriu_capacitat_coop_m3, X_grid,Y_grid, title_SNR, title_capacity);

    %% Càlcul SNR en cada posició suposant cooperació a nivell de multiplexat (cooperació entre 2 bs) + altres bs interferencies

    [matriu_SNR_coop_m4,matriu_capacitat_coop_m4]=calcular_SNR_capacitat_coop_m(distanciesbs_LOS, SNR_1m, alfa,...
        X_grid, Y_grid, 4);

%     title_SNR='SNR1 amb cooperació a nivell de multiplexat entre 4 bs [dB]';
%     title_capacity='Capacitat amb cooperació a nivell de capa MAC entre 4 bs [bps/Hz]';
%     plot_SNR_capacity(squeeze(matriu_SNR_coop_m4(1,:,:)), matriu_capacitat_coop_m4, X_grid,Y_grid, title_SNR, title_capacity);

    %% Càlcul SNR en cada posició suposant cooperació a nivell de multiplexat (cooperació entre 5 bs) + altres bs interferencies

    [matriu_SNR_coop_m5,matriu_capacitat_coop_m5]=calcular_SNR_capacitat_coop_m(distanciesbs_LOS, SNR_1m, alfa,...
        X_grid, Y_grid, 5);

%     title_SNR='SNR1 amb cooperació a nivell de multiplexat entre 5 bs [dB]';
%     title_capacity='Capacitat amb cooperació a nivell de capa MAC entre 5 bs [bps/Hz]';
%     plot_SNR_capacity(squeeze(matriu_SNR_coop_m5(1,:,:)), matriu_capacitat_coop_m5, X_grid,Y_grid, title_SNR, title_capacity);
%       
    %% Guaradar .mat (CANVIAR ID CIUTAT)

    save (['ciutat',num2str(k),'.mat'], 'lambda_buildings','lambda_bs','distancies_total', 'boolean_LOS_total', 'distancies_LOS_total' ,'matriu_SNR_NI', ...
        'matriu_capacitat_NI', 'distancies1_LOS', 'distancies2_LOS', 'distancies3_LOS', 'distancies4_LOS', ...
        'distancies1', 'distancies2', 'distancies3', 'distancies4', 'matriu_SNR_I', 'matriu_capacitat_I', ...
        'matriu_SNR_coop_s2', 'matriu_capacitat_coop_s2', 'matriu_SNR_coop_s3', 'matriu_capacitat_coop_s3', ...
        'matriu_SNR_coop_s4', 'matriu_capacitat_coop_s4', 'matriu_SNR_coop_s5', 'matriu_capacitat_coop_s5', ...
        'matriu_SNR_coop_m2' ,'matriu_capacitat_coop_m2', 'matriu_SNR_coop_m3', 'matriu_capacitat_coop_m3', ...
        'matriu_SNR_coop_m4', 'matriu_capacitat_coop_m4', 'matriu_SNR_coop_m5', 'matriu_capacitat_coop_m5');

    clear distanciesbs_LOS distancies_LOS_total distanciesbs distancies_total boolean_LOS_total distancies_LOS_total matriu_SNR_NI ...
        matriu_capacitat_NI distancies1_LOS distancies2_LOS distancies3_LOS distancies4_LOS ...
        distancies1 distancies2 distancies3 distancies4 matriu_SNR_I matriu_capacitat_I ...
        matriu_SNR_coop_s2 matriu_capacitat_coop_s2 matriu_SNR_coop_s3 matriu_capacitat_coop_s3 ...
        matriu_SNR_coop_s4 matriu_capacitat_coop_s4 matriu_SNR_coop_s5 matriu_capacitat_coop_s5 ...
        matriu_SNR_coop_m2 matriu_capacitat_coop_m2 matriu_SNR_coop_m3 matriu_capacitat_coop_m3 ...
        matriu_SNR_coop_m4 matriu_capacitat_coop_m4 matriu_SNR_coop_m5 matriu_capacitat_coop_m5);
end
