% test5a stands for PSO_VCO_3stage   for Temprature    , 'V3.sp' ,    with PSO
clc;
clear;
close all;
tic; 
%% problem definition

costfunction=@test5b;
nvar=1;
varsize=[1 nvar];
varmin=1;
varmax=50;

%% IPO parameters

maxit=10;
%npop=10;
npop=6;
   
%better
%c1 = 1;
%c2 =1;
%shift1= 500;
%shift2= 500;
%scale1=0.02;
%scale2=0.02;


     %     c1 = 0.2248273331;
  %        c2 = 2.2829730221;
  %       shift1 = 121.0439751601;
    %     shift2 = 149.6747546522;
    %     scale1 = 0.0558110177;
 %         scale2 = 0.5248145911;
       
        mm=[]
        nn=[]
        

%% initialization

empty_ball.position=[];
empty_ball.cost=[];
empty_ball.velocity=[];
empty_ball.acceleration=[];

ball=repmat(empty_ball,npop,1);
globalbest.cost=inf;

for i=1:npop
    
    % initialize position
    ball(i).position=unifrnd(varmin,varmax,varsize);
    
    % initialize velocity
    ball(i).velocity=zeros(varsize);
    
    % initialize acceleration
    ball(i).acceleration=zeros(varsize);
    
    % evaluation
    ball(i).cost=costfunction(ball(i).position);
    
    % update globalbest
    if ball(i).cost<globalbest.cost

        globalbest.position=ball(i).position;
        globalbest.cost=ball(i).cost;
    end
end


meanfits=zeros(maxit,1);
bests=zeros(maxit,1);


%% IPO main loop
for it=1:maxit
    sumcost=0;
    for i=1:npop
    for j=1:npop
        
       df=ball(j).cost-ball(i).cost;
       if df < 0
           ball(i).acceleration=ball(i).acceleration...
           +sin(atan(df./(ball(i).position-ball(j).position)));
       end
        
    end
    

        
 %   k1 = c1 ./ (1 + exp((it - shift1) .* scale1));
 %  k2 = c2 ./ (1 + exp(-(it - shift2) .* scale2));
    
 k1 = 0.5;
 k2 = 0.5;
    %update velocity
    ball(i).velocity=globalbest.position-ball(i).position;
    
    
    %update position
    ball(i).position=ball(i).position+k1.*rand(varsize)...
        .*ball(i).acceleration+k2.*rand(varsize).*ball(i).velocity;
    
    %Apply position limits
     tmpmaxchk = ball(i).position > varmax;
    tmpminchk = ball(i).position< varmin;
    ball(i).position = ball(i).position .* ~(tmpmaxchk | tmpminchk) + varmax .* tmpmaxchk + varmin .* tmpminchk;
    
    
    
    % evaluation
    ball(i).cost=costfunction(ball(i).position);
    
 

 if ball(i).cost<globalbest.cost
          globalbest.position=ball(i).position;
          globalbest.cost=ball(i).cost;
 end

 
    
    sumcost=sumcost+ball(i).cost;
    
 
    bests(it) = globalbest.cost;
    end
meanfits(it)=sumcost/npop;
disp(['Iteration' num2str(it) ':bestcost=' num2str(bests(it))]);

end
figure;
plot(bests,'LineWidth',2);
% semilogy(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Fitness = The Least Power Dissipation');
toc;