% MSFLA with cognitive behavior for 3 stage ring oscillator , Minimization
% of Average Power with optimum layout and Temperature
clc
clear all
close all

%% SFLA Parameters


nVars = 3; 
minVars =  [0.2 0.2 1];
%minVars = [0.2 0.2 1] % for T3b.sp
maxVars = [2 2 50];
%maxVars=[2 2 50]
Smax = 0.45 * (maxVars - minVars);

%nVars = 3;
%minVars = -5.12 * ones(1, nVars);
%maxVars = 5.12 * ones(1, nVars);
%Smax = 0.45 * (maxVars - minVars);

CostFcn = @test6b;
%CostFcn = @(x) sum(x.^2);

m = 5;
n = 5;
s = m * n;

%q  = 4;  5
q = 4;
%Ns = 2;3
Ns =2;
Nt = 1;

nIter = 10;
nFcnEval = inf;
VTR = 0; %1e-4;                 % Value-to-Reach

%% Initialization

empty_sol.X = zeros(1, nVars);
empty_sol.Cost = inf;
empty_sol.Pbest = empty_sol;

pop = repmat(empty_sol, s, 1);

bestCost = inf;
for ii = 1:s
    pop(ii).X = create_random_solution(minVars, maxVars);
    pop(ii).Cost = CostFcn(pop(ii).X);
    pop(ii).Pbest.X = pop(ii).X;
    pop(ii).Pbest.Cost = pop(ii).Cost;
    if pop(ii).Cost < bestCost
        bestCost = pop(ii).Cost;
    end
end

complexes = reshape(1:s, m, n);

Pi = 2*(n+1-(1:n))/(n*(n+1));

%% Main Loop

iIter = 0;
iFcnEval = s;

bestCosts = [];
while iIter < nIter & iFcnEval < nFcnEval & bestCost > VTR
    
    % Sort population
    [~, idx] = sort([pop.Cost]);
    pop = pop(idx);
    bestCost = pop(1).Cost;
    disp(bestCost)
    bestCosts = [bestCosts bestCost];
    
    Px = pop(1);
    % Complex evolution: FLA
    for k = 1:m
        Ak = pop(complexes(k,:));
        
        for t = 1:Nt
            
            % Select q members from Ak
            subc = sort(randsample_w(Pi, q));
            B = Ak(subc);
            for j = 1:Ns
                % Sort B and determine Pb, Pw
                [~,idx] = sort([B.Cost]);
                B = B(idx);
                
                Pb = B(1);
                Pw = B(q);
                
                % Evolve Pw towards Pb
                r = evolve_towards_pxpb(Pw, Pb, Smax);
                if ~is_within(r, minVars, maxVars);
                    Fr = inf;
                else
                    Fr = CostFcn(r);
                    iFcnEval = iFcnEval + 1;
                end
                if Fr < B(q).Cost
                    B(q).X = r;
                    B(q).Cost = Fr;
                else
                    
                    % Evolve Pw towards Px (The best position that have had
                    % by now - based on the memort content)
                    c = evolve_towards_pxpb(Pw, Px, Smax);
                    if ~is_within(c, minVars, maxVars)
                        Fc = inf;
                    else
                        Fc = CostFcn(c);
                        iFcnEval = iFcnEval + 1;
                    end
                    if Fc < B(q).Cost
                        B(q).X = c;
                        B(q).Cost = Fc;
                    else
                        % Create random soluion
                        z = create_random_solution(minVars, maxVars);
                        Fz = CostFcn(z);
                        iFcnEval = iFcnEval + 1;
                        
                        B(q).X = z;
                        B(q).Cost = Fz;
                    end
                end
                
                if B(q).Cost < B(q).Pbest.Cost
                    B(q).Pbest.X = B(q).X;
                    B(q).Pbest.Cost = B(q).Cost;
                end
                
                if B(q).Cost < Px.Cost
                    Px = B(q);
                end
            end % Ns
        end % Nt
        
        % Replace and sort
        Ak(subc) = B;
        [~, idx] = sort([Ak.Cost]);
        Ak = Ak(idx);
    end % k
    
    % Replace memeplex into population
    pop(complexes(k,:)) = Ak;
    
end % main loop

%plot(bestCosts)
%disp(iFcnEval)
B=zeros(25,1);
B(1)=pop(25,1).Cost+B(1);
B(2)=pop(24,1).Cost+B(2);
B(3)=pop(23,1).Cost+B(3);
B(4)=pop(22,1).Cost+B(4);
B(5)=pop(21,1).Cost+B(5);
B(6)=pop(20,1).Cost+B(6);
B(7)=pop(19,1).Cost+B(7);
B(8)=pop(18,1).Cost+B(8);
B(9)=pop(17,1).Cost+B(9);
B(10)=pop(16,1).Cost+B(10);
B(11)=pop(15,1).Cost+B(11);
B(12)=pop(14,1).Cost+B(12);
B(13)=pop(13,1).Cost+B(13);
B(14)=pop(12,1).Cost+B(14);
B(15)=pop(11,1).Cost+B(15);
B(16)=pop(10,1).Cost+B(16);
B(17)=pop(9,1).Cost+B(17);
B(18)=pop(8,1).Cost+B(18);
B(19)=pop(7,1).Cost+B(19);
B(20)=pop(6,1).Cost+B(20);
B(21)=pop(5,1).Cost+B(21);
B(22)=pop(4,1).Cost+B(22);
B(23)=pop(3,1).Cost+B(23);
B(24)=pop(2,1).Cost+B(24);
B(25)=pop(1,1).Cost+B(25);
figure;
plot(B,'--g','LineWidth',2);
xlabel('Iteration');
ylabel('Best Fitness = Best Dynamic Average Power with Modified SFLA with Cognitive Behavior');