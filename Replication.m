clc
clear
close all

%% 1. Préparation des données


% Charger la base de données

[Data,VarLabel] = xlsread('Dataset.xls');

% Créer matrice capacity^2 et l'ajouter aux données

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


%% 2. Création des données pour les figures 3,4 et 5


% Créer la matrice des moyennes pour la figure 3 (capacity)

Fig3 = [mean(Data(Data(:,17)<20,1));
    mean(Data(Data(:,17)>=20 & Data(:,17)<50,1));
    mean(Data(Data(:,17)>=50 & Data(:,17)<100,1));
    mean(Data(Data(:,17)>100,1));];

% Créer la matrice des moyennes pour la figure 4 (Technology)

Fig4 = [mean(Data(Data(:,10)==1,1));
    mean(Data(Data(:,11)==1,1));
    mean(Data(Data(:,12)==1,1));
    mean(Data(Data(:,15)==1,1));
    mean(Data(Data(:,14)==1,1));
    mean(Data(Data(:,13)==1,1));];

% Créer la matrice des moyennes pour la figure 5 (Sponsor)

Fig5 = [mean(Data(Data(:,18)==1,1));
    mean(Data(Data(:,19)==1,1));
    mean(Data(Data(:,20)==1,1));
    mean(Data(Data(:,21)==1,1));
    mean(Data(Data(:,22)==1,1));
    mean(Data(Data(:,23)==1,1));
    mean(Data(Data(:,24)==1,1));];


%% 3. Analyse par régression


% Tableau 3, Colonne A

XT3A =  Data(:,[1 25 26 3 11 18 19 20 21 22 23 24 2 5 6 7 8]);

% Comme la variable SponsorFinancialInvestor prédit Y parfaitement, Stata
% l'élimine de la régression et élimine 49 observations

XT3A(XT3A(:, 11)== 1, :)= [];
XT3A(:,11) = [];

% Créer les matrices Y et X et effectuer la régression

YT3A=XT3A(:,1);
XT3A(:,1) = [];
varlist = VarLabel([25 26 3 11 18 19 20 21 22 24 2 5 6 7 8]);
CoefT3A = logit(YT3A,XT3A,varlist);

% Tableau 3, Colonne B

XT3B =  Data(:,[1 25 26 3 11 14 12 13 18 19 20 21 22 23 24 2 5 6 7 8]);

% Comme les variables SponsorFinancialInvestor et Lignite prédisent Y parfaitement, Stata
% les élimine de la régression et élimine 49 observations et 5 observations

XT3B(XT3B(:, 14)== 1, :)= [];
XT3B(:,14) = [];
XT3B(XT3B(:, 8)== 1, :)= [];
XT3B(:,8) = [];

% Créer les matrices Y et X et effectuer la régression

YT3B=XT3B(:,1);
XT3B(:,1) = [];
varlist = VarLabel([25 26 3 11 14 12 18 19 20 21 22 24 2 5 6 7 8]);
CoefT3B = logit(YT3B,XT3B,varlist);

% Tableau 3, Colonne C

XT3C =  Data(:,[1 25 26 3 11 18 19 20 21 22 23 24 2 5 6 7 8 29]);

% Comme la variable SponsorFinancialInvestor prédit Y parfaitement, Stata
% l'élimine de la régression et élimine 49 observations

XT3C(XT3C(:, 11)== 1, :)= [];
XT3C(:,11) = [];

% Créer les matrices Y et X et effectuer la régression

YT3C=XT3C(:,1);
XT3C(:,1) = [];
varlist = VarLabel([25 26 3 11 18 19 20 21 22 24 2 5 6 7 8 29]);
CoefT3C = logit(YT3C,XT3C,varlist);

% Tableau 3, Colonne D

XT3D =  Data(:,[1 25 26 3 11 18 19 20 21 22 23 24 2 5 6 7 8 28]);

% Comme la variable SponsorFinancialInvestor prédit Y parfaitement, Stata
% l'élimine de la régression et élimine 49 observations

XT3D(XT3D(:, 11)== 1, :)= [];
XT3D(:,11) = [];

% Créer les matrices Y et X et effectuer la régression

YT3D=XT3D(:,1);
XT3D(:,1) = [];
varlist = VarLabel([25 26 3 11 18 19 20 21 22 24 2 5 6 7 8 28]);
CoefT3D = logit(YT3D,XT3D,varlist);

% Tableau 3, Colonne E

XT3E =  Data(:,[1 25 26 3 11 27 18 19 20 21 22 23 24 2 5 6 7 8]);

% Comme la variable SponsorFinancialInvestor prédit Y parfaitement, Stata
% l'élimine de la régression et élimine 49 observations

XT3E(XT3E(:, 12)== 1, :)= [];
XT3E(:,12) = [];

%On élimine aussi les observations pour lesquelles le Capex/Opex n'est pas
%disponible.

XT3E(XT3E(:, 6)== 0, :)= [];

% Créer les matrices Y et X et effectuer la régression

YT3E=XT3E(:,1);
XT3E(:,1) = [];
varlist = VarLabel([25 26 3 11 27 18 19 20 21 22 24 2 5 6 7 8]);
CoefT3E = logit(YT3E,XT3E,varlist);

% Tableau 3, Colonne F

XT3F =  Data(:,[1 25 26 3 11 27 2 5 6 7 8 19]);

% On retient uniquement les observations pour RegMun Uttility

XT3F(XT3F(:, 12)== 0, :)= [];
XT3F(:,12) = [];

%On élimine aussi les observations pour lesquelles le Capex/Opex n'est pas
%disponible.

XT3F(XT3F(:, 6)== 0, :)= [];

% Créer les matrices Y et X et effectuer la régression

YT3F=XT3F(:,1);
XT3F(:,1) = [];
varlist = VarLabel([25 26 3 11 27 2 5 6 7 8]);
CoefT3F = logit(YT3F,XT3F,varlist);

% Tableau D1, Colonne G

XTDG =  Data(:,[1 25 26 3 11 2 5 6 7 8 19 18 20 22 ]);

% On retient uniquement les observations pour RegMunUtility,
% BigFourUtility, ForeignUtility et Industry

Deleterow = zeros(length(XTDG),1);

for i = 1:length(XTDG)

if sum(XTDG(i,[11 12 13 14])) < 1  
    
Deleterow(i,:)= 1;

end

end

XTDG = [XTDG Deleterow];
XTDG(XTDG(:, 15)== 1, :)= [];
XTDG(:,15) = [];

% Créer les matrices Y et X et effectuer la régression

YTDG=XTDG(:,1);
XTDG(:,1) = [];
varlist = VarLabel([25 26 3 11 2 5 6 7 8 19 18 20 22]);
CoefTDG = logit(YTDG,XTDG,varlist);

% Tableau D1, Colonne H

XTDH =  Data(:,[1 25 26 3 11 14 12 13 2 5 6 7 8 19 18 20 22 ]);

% On retient uniquement les observations pour RegMunUtility,
% BigFourUtility, ForeignUtility et Industry

Deleterow = zeros(length(XTDH),1);

for i = 1:length(XTDH)

if sum(XTDH(i,[14 15 16 17])) < 1  
    
Deleterow(i,:)= 1;

end

end

XTDH = [XTDH Deleterow];
XTDH(XTDH(:, 18)== 1, :)= [];
XTDH(:,18) = [];

clear Deleterow i

% Comme la variable lignite prédit Y parfaitement, Stata
% l'élimine de la régression et élimine les observations

XTDH(XTDH(:, 8)== 1, :)= [];
XTDH(:,8) = [];

% Créer les matrices Y et X et effectuer la régression

YTDH=XTDH(:,1);
XTDH(:,1) = [];
varlist = VarLabel([25 26 3 11 14 12 2 5 6 7 8 19 18 20 22]);
CoefTDH = logit(YTDH,XTDH,varlist);

% Tableau D1, Colonne I

XTDI =  Data(:,[1 25 26 3 11 2 5 6 7 8 19 18 20 22 29]);

% On retient uniquement les observations pour RegMunUtility,
% BigFourUtility, ForeignUtility et Industry

Deleterow = zeros(length(XTDI),1);

for i = 1:length(XTDI)

if sum(XTDI(i,[11 12 13 14])) < 1
    
Deleterow(i,:)= 1;

end

end

XTDI = [XTDI Deleterow];
XTDI(XTDI(:, 16)== 1, :)= [];
XTDI(:,16) = [];

clear Deleterow i

% Créer les matrices Y et X et effectuer la régression

YTDI=XTDI(:,1);
XTDI(:,1) = [];
varlist = VarLabel([25 26 3 11 2 5 6 7 8 19 18 20 22 29]);
CoefTDI = logit(YTDI,XTDI,varlist);
clear varlist

 %% 4. Présentation des figures
 
[aFig3]=imread('aFigure3.PNG');
[aFig4]=imread('aFigure4.PNG');
[aFig5]=imread('aFigure5.PNG');

%% 
%Figure 3
Fig3 = flipud(Fig3);

figure3=figure('Position', [100, 100, 1000, 400]);
subplot(1,2,1);
barh(Fig3)
title('Use of project finance by size of project')
somenames={'>100 MW' '50-100 MW' '20-50 MW' '10-20 MW' };
set(gca,'yticklabel',somenames)
subplot(1,2,2); 
image(aFig3)
set(gca,'visible','off')


%%
%Figure 4

Fig4 = flipud(Fig4);

figure4=figure('Position', [100, 100, 1000, 400]);
subplot(1,2,1);
barh(Fig4)
title('Use of project finance by feed-in tariff eligibility and technology')
somenames={'Lignite' 'Hard coal' 'Natural gas' 'Solar PV' 'Wind offshore' 'Wind onshore' };
set(gca,'yticklabel',somenames)
subplot(1,2,2); 
image(aFig4)
set(gca,'visible','off')


%%
%Figure 5
Fig5 = flipud(Fig5);

figure5=figure('Position', [100, 100, 1000, 400]);
subplot(1,2,1);
barh(Fig5)
title('Use of project finance by type of sponsor.')
somenames={'Citizen-owned' 'Big Four utility' 'Regional/municipal utility' 'Foreign utility/IPP' 'Project developer' 'Industry' 'Financial investor'};
set(gca,'yticklabel',somenames)
subplot(1,2,2); 
image(aFig5)
set(gca,'visible','off')

%% 5. Présentation des tableaux

% Regrouper les tables de résultats en respectant le format des tableaux de
% l'article et présenter les figures/tableaux de l'article pour comparaison

% Table 3

Table3 = outerjoin(CoefT3A,CoefT3B,'Keys','Row');
Table3 = outerjoin(Table3, CoefT3C,'Keys','Row');
Table3 = outerjoin(Table3, CoefT3D,'Keys','Row');
Table3 = outerjoin(Table3, CoefT3E,'Keys','Row');
Table3 = outerjoin(Table3, CoefT3F,'Keys','Row');

% Comme outerjoin ordonne les variables en ordre alphabétique, on doit les
% réorganiser comme dans l'article

Order = [6;3;4;13;21;11;14;5;15;20;17;19;18;16;12;2;1;7;8;9;10];
Table3 = Table3(Order,:);

% Et renommer les colonnes 'A' 'B' 'C' 'D' 'E' 'F'

Table3.Properties.VariableNames = {'A' 'B' 'C' 'D' 'E' 'F'}

aTable3=imread('aTable3.PNG');
aTable3 = imresize(aTable3,.70);

figure
imshow(aTable3)

%%
% Table D.1

TableD1 = outerjoin(CoefTDG,CoefTDH,'Keys','Row');
TableD1 = outerjoin(TableD1, CoefTDI,'Keys','Row');

% Comme outerjoin ordonne les variables en ordre alphabétique, on doit les
% réorganiser comme dans l'article

Order = [4;2;3;11;17;9;12;13;16;14;15;10;1;5;6;7;8];
TableD1 = TableD1(Order,:);
TableD1.Properties.VariableNames = {'G' 'H' 'I'}

aTableD1=imread('aTableD1.PNG');
aTableD1 = imresize(aTableD1,.70);

figure
imshow(aTableD1)

%%
