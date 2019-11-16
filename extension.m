clc
clear


%% 1. Préparation des données


% Charger la base de données

[Data,VarLabel] = xlsread('Dataset.xls');

% Créer la matrice capacity^2 et l'ajouter aux données

CapacityScaled = Data(:,17) / (2*std(Data(:,17)));
CapacityScaled2 = CapacityScaled.^2;

Data = [Data CapacityScaled CapacityScaled2];
VarLabel = [VarLabel, "CapacityScaled", "CapacityScaled^2"];
clear CapacityScaled CapacityScaled2

% Générer la variable capex/opex

CapexOpexNorm = zeros(size(Data,1),1);

for i = 1:length(Data)
    
    if Data(i,14)==1
        CapexOpexNorm(i,1)= .187;
    elseif Data(i,13)==1
        CapexOpexNorm(i,1) = 0.179;
    elseif Data(i,15)==1
        CapexOpexNorm(i,1) = 0.116 ;
    elseif Data(i,10)==1
        CapexOpexNorm(i,1) = 0.694 ; 
    elseif Data(i,11)==1
        CapexOpexNorm(i,1) = 0.543 ; 
    elseif Data(i,12)==1
        CapexOpexNorm(i,1) = 1.430  ;
    end
    
end

Data = [Data CapexOpexNorm];
VarLabel = [VarLabel, "CapexOpex"];
clear CapexOpexNorm i

%Générer les variables d'interactions

Big4NoMerchantRisk = Data(:,18) .* (1- Data(:,3));
CapacityMerchantRisk = Data(:,25) .* Data(:,3);

Data = [Data Big4NoMerchantRisk CapacityMerchantRisk];
VarLabel = [VarLabel, "Big4NoMerchantRisk", "CapacityMerchantRisk"];
clear Big4NoMerchantRisk CapacityMerchantRisk

% Comme la variable SponsorFinancialInvestor prédit Y parfaitement on l'élimine de la régression avec 49 observations

x =  Data(:,[1 25 26 3 11 18 19 20 21 22 23 24 2]);

x(x(:, 11)== 1, :)= [];
x(:,11) = [];

% Créer les variable et on effectue le logit
y=x(:,1);
x(:,1) = [];
coef = logit(y,x);

%% 2. Calcul du score de propension

% On ajoute une colonne de un pour la constante et on calcule le score de
% propension en transformant le log de vrai-semblance en probabilité.
% y = log ( p / ( 1 - p ) ) donc: e^score / ( e^score + 1 )


x_0 = ones(size(x,1),1);
x = horzcat(x_0, x);

coef = coef';

pscore = coef .* x;
pscore =sum(pscore,2);
pscore = exp(pscore);
pscore = pscore./(pscore+1)

clear x_0 escore coef

% Pour l'exercice, on génère aussi une variable qui représente le taux
% d'intérêt obtenu par les projets. Le taux est de 3 à 8 %.

n = size(x,1);
int = (rand(n,1)*5)+3;

% On ajoute le score aux données, on crée les groupes traité et non
% traité
x(:,1) = [];
x = [y x int pscore];

xt = x;
xt(xt(:, 1)== 0, :)= [];

xnt = x;
xnt(xnt(:, 1)== 1, :)= [];

clear score n int
%% 2. Validation du support commun
% Créer un graphique de la région de suppot commun des scores de propension

% Créer une matrice des densités

n_t = size(xt,2);
n_nt = size(xnt,2);
d = zeros(1,11);

for i = 2:11
  d(i)=d(i-1)+.1;
end

dt = zeros(1,11);

for i=2:11
 dt(i)= sum(xt(:,n_t)>d(i-1) & xt(:,n_t)<d(i));
end

dnt = zeros(1,11);

for i=2:11
 dnt(i)= sum(xnt(:,n_nt)>d(i-1) & xnt(:,n_nt)<d(i));
end

% Puis le graphique de support commun
figure(1)
plot(d,dt,d,dnt)
xlim([0 1])
ylim([0 40])
title('Densité des scores de propension')
legend('Financement par projet','Non financé par projet')
xlabel('Score')
ylabel("Nombre d'observations")

clear d dt dnt

% Finalement, on élimine les observations hors de la zone de support commun

n_t=size(xt,2);
n_nt=size(xnt,2);

minxt = min(xt(:,n_t));

maxxnt = max(xnt(:,n_nt));

xt(xt(:, n_t)> maxxnt, :)= [];
xnt(xnt(:, n_nt)< minxt, :)= [];

clear n n_t n_nt minxt maxxnt

%% 3. Qualité du score de propension
% On vérifie s'il existe des différences significatives entre les groupes
% traité et non traité pour les caractéristiques employés

% Calcul des moyennes
n=size(xt,2);

meant = zeros(n-1,1);

for i = 1:(n-1)
    
meant(i) = mean(xt(:,i+1));

end

n=size(xnt,2);

meannt = zeros(n-1,1);

for i = 1:(n-1)
    
meannt(i) = mean(xnt(:,i+1));

end

%Calcul des variances

n=size(xt,2);

vart = zeros(n-1,1);

for i = 1:(n-1)
    
vart(i) = var(xt(:,i+1));

end

n=size(xnt,2);

varnt = zeros(n-1,1);

for i = 1:(n-1)
    
varnt(i) = var(xnt(:,i+1));

end

moyenne = [meant vart meannt varnt];

m = size(moyenne,1);
mt = size(xt,1);
mnt = size(xnt,1);
tstat = zeros(m,1);

for i = 1:m
    tstat(i) = abs((moyenne(i,1)-moyenne(i,3))/sqrt((moyenne(i,2)/mt)+(moyenne(i,4)/mnt)));
end


Comparaison = table(meant , vart , meannt , varnt , tstat);

Comparaison.Properties.VariableNames = {'Moyenne_T' 'Variance_T' 'Moyenne_NT' 'Variance_NT' 'T_stat'}
    
  clear n m mt mnt meant meannt vart varnt tstat i moyenne

 %% 4. Effectuer l'appariement
 
 % Effectuer l'appariement par plus proche voisin
 % Chaque observation du groupe traité est appareilée avec l'observation la plus proche du groupe non traité

n_xt = size(xt,2);
n_xnt = size(xnt,2);

% Créer un index des match

S_T = xt(:,n_xt);
S_NT = xnt(:,n_xnt);
 
A = repmat(S_NT,[1 length(S_T)]);
[Minv,IndexVoisin] = min(abs(A-S_T'));

% Créer une matrice des taux d'intérêt des traité en colonne 1
% et des pairs non traité en colonne 2

i_traite = xt(:,n_xt-1);
i_nt = xnt(:,n_xnt-1);
i_ntmatch = i_nt(IndexVoisin);

% Calculer l'effet moyen de traitement qui est la différence moyenne entre
% le taux d'intérêt des observations en financement par projet comparé à
% leur pairs qui ne sont pas en financemnet par projet

effet_traitement = mean(i_traite - i_ntmatch)

clear n_xt n_xnt Minv i_traite i_nt i_ntmatch S_T S_NT A IndexVoisin

%%

%Note : On obtient un effet moyen de traitement différent à chaque fois
%puisque le taux d'intérêt est généré aléatoirement entre 3 et 8%
