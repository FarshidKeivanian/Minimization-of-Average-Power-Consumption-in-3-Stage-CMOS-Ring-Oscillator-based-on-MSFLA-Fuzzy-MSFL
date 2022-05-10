%  test6a stands for SFLA_VCO_3stage  for Channel Widths , 'T3b.sp' ,with

clc
%clear all
%close all

%% SFLA Parameters

nVars = 3; 
minVars =  [0.2 0.2 1];
%minVars = [0.2 0.2 1] % for T3b.sp
maxVars = [2 2 50];
%maxVars=[2 2 50]
Smax = 0.45 * (maxVars - minVars);

CostFcn = @test6b;

m = 10;
n = 10;
s = m * n;

q  = 5;  %5
Ns = 3;%3
Nt = 1;%1

nIter = 10;  %1000
nFcnEval = inf;
VTR = 0 ;       %  -1.65e-4        % Value-to-Reach

%% Initialization

empty_sol.X = zeros(1, nVars);
empty_sol.Cost = inf;

pop = repmat(empty_sol, s, 1);

bestCost = inf;
for ii = 1:s
    pop(ii).X = create_random_solution(minVars, maxVars);
    pop(ii).Cost = CostFcn(pop(ii).X);
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
               r = evolve_towards(Pw.X, Pb.X, Smax);
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
                    
                    % Evolve Pw towards Px
                   c = evolve_towards(Pw, Px, Smax);
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
                
                if B(q).Cost < Px.Cost
                    Px = B(q);
                end
            end % Ns
        end % Nt
        
        % Replace and sort
        Ak(subc) = B;
        [~, idx] = sort([Ak.Cost]);
        Ak = Ak(idx);
    end 
    
       
end % main loop

%plot(bestCosts)
disp(iFcnEval)
 
figure;
B=zeros(10,1);
B(1)=Ak(10,1).Cost+B(1);
B(2)=Ak(9,1).Cost+B(2);
B(3)=Ak(8,1).Cost+B(3);
B(4)=Ak(7,1).Cost+B(4);
B(5)=Ak(6,1).Cost+B(5);
B(6)=Ak(5,1).Cost+B(6);
B(7)=Ak(4,1).Cost+B(7);
B(8)=Ak(3,1).Cost+B(8);
B(9)=Ak(2,1).Cost+B(9);
B(10)=Ak(1,1).Cost+B(10);
hold on
plot(B,'b','LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Fitness = Best Dynamic Average Power with SFLA');
 