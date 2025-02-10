clc
clear all
close all

format long

FILE = readmatrix('stocks.csv');  
[n, numvar] = size(FILE);
rend = (FILE(2:end, :) - FILE(1:end-1, :)) ./ FILE(1:end-1, :);

inertia_weight_choice = 0; % 0->w constant; 1->decreasing

runs = 3;
results = zeros(runs * 5, numvar + 5); % Adjust for 5 different values of pigre

%% data
media = mean(rend);
variance = cov(rend);

%% PSO setting 
P = 2 * numvar; % 200;
niter = 5000; % numero iterazioni
c1 = 1.49618;
c2 = 1.49618;
w = 0.7298;
vmaxx = zeros(1, numvar); % vettore di servizio
epsilon1 = 1.0e-005; % parametro di penalizzazione

pigre_values = [0.049149, 0.05, 0.06, 0.07, 0.08]; % Adjust for different values of pigre

idx = 1; % Index for results

for pigre = pigre_values
    for iii = 1:runs
        tic

        %% service vectors and matrices
        vmaxx = zeros(1, numvar);
        var_port = zeros(P, 1);
        med_port = zeros(P, 1);
        vinc_1 = zeros(P, 1); % vincolo di bilancio
        vinc_2 = zeros(P, 1); % vincolo di redditività
        app_1 = zeros(P, numvar);
        vinc_3 = zeros(P, 1); % x >= 0

        %% random initialization
        x = rand(P, numvar);
        vx = rand(P, numvar);
        f = ones(P, 1) * 1.0e+015;

        %% pbest, gbest and related values of the function;
        pbx = [x f];
        gx = zeros(1, numvar + 1);

        %%
        for k = 1:niter
            % 1) range for max speed
            for i = 1:numvar
                vmaxx(i) = abs(max(x(:, i)) - min(x(:, i)));
            end

            % 2) calcolo della funzione obiettivo
            for p = 1:P
                ... 
            end
            % calcolo funzione di fitness
            f = var_port + (1 / epsilon1) * (vinc_1 + vinc_2);
            %f = var_port+(1/epsilon1)*(vinc_1 + vinc_2 + vinc_3);

            % 3) confronto valore della funzione obiettivo con il pbest
            for p = 1:P
                if f(p) < pbx(p, numvar + 1)
                    pbx(p, numvar + 1) = f(p);
                    for i = 1:numvar
                        pbx(p, i) = x(p, i);
                    end
                end
            end

            % 4) identificazione particella con migliore posizione
            [minimo, posizione] = min(pbx(:, numvar + 1));
            gx(numvar + 1) = minimo;
            for i = 1:numvar
                gx(i) = pbx(posizione, i);
            end

            % 5) aggiornamento velocità e posizioni
            if inertia_weight_choice == 1
                w = 0.9 - k * 0.5 / niter;
            end
            for p = 1:P
                for i = 1:numvar
                    vx(p, i) = w * vx(p, i) + c1 * rand * (pbx(p, i) - x(p, i)) + c2 * rand * (gx(i) - x(p, i));
                    if vx(p, i) > vmaxx(i)
                        vx(p, i) = vmaxx(i);
                    end
                    x(p, i) = x(p, i) + vx(p, i);
                end
            end
            
            converg(k,:) = gx(:,end);

        end

        tc0 = toc;

        if iii <= 10
            figure
            plot(converg)
            title(['Fitness function - Iteration: ' num2str(iii)])
            grid on
            axis([0 niter 0 250])
            xlabel('Iterations')
            ylabel('Fitness')
        end

        portfolio = gx(1:end - 1)';
        fitness = gx(end);
        vinc_somma_percentuali = sum(gx(1:end - 1)) - 1;
        vinc_reddittivita = gx(1:end - 1) * media' - pigre;
        vinc_non_negativita = sum(max(0, -gx(1:end - 1)'));
        
        % Store results
        results(idx, 1:numvar) = portfolio';
        results(idx, numvar + 1) = fitness;
        results(idx, numvar + 2) = portfolio' * variance * portfolio;
        results(idx, numvar + 3) = media * portfolio - pigre;
        results(idx, numvar + 4) = sum(portfolio) - 1;
        results(idx, numvar + 5) = tc0;
        
        idx = idx + 1;
    end
end

%% true solution
tic

V1 = inv(variance);
e = ones(1, numvar);
alfa = media * V1 * media';
beta = media * V1 * e';
gamma = e * V1 * e';
NUME = (gamma * V1 * media' - beta * V1 * e') * pigre + (alfa * V1 * e' - beta * V1 * media');
DENO = alfa * gamma - beta^2;

tru_sol = NUME / DENO;

tc1 = toc;

%% results
xlswrite('results_pso_NEG',[results],'Results');
