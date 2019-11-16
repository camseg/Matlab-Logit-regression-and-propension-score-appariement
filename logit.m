% Fonction Logit

% logit(y,x,varlist(optionnel))

% La fonction peut être utilisé avec 2 ou avec 3 arguments. 

% 'y' doit être une matrice de taille m x 1 où m est le nombre
% d'observations. y représente la variable dépendante et doit être binaire.

% 'x' doit être une matrice de taille m x n où m est le nombre
% d'observations et n est le nombre de variables explicatives uttilisés
% pour la régression. Le nombre d'observations doit être le même pour y et
% x.

%'varlist' est un array de taille m x 1 qui contient les noms des variables
%explicatives. Cet argument est optionnel.

%Avec 2 arguments, la fonction logit retourne une matrice des coefficients
%de taille n x 1. La première variable est la constante.

%Avec 3 arguments, la fonction logit retourne une table des coefficients
%avec les noms des variables et les coefficients.

function logit = logit(y, x, varlist)

% Établir la taille de la matrice de variable explicatives (m*n)
    
    m=size(x,1);
    n=size(x,2)+1;
    
% Ajouter une colonne de 1 au début de la matrice de variables
% indépendantes pour simplifier l'écriture (b1*1 + b2x2 +b3x3 ..)

    x_0 = ones(m,1);
    x = horzcat(x_0, x);
   
% Créer la matrice de coefficients initiaux (0) et ajouter une constante initiale(0)

    b = zeros(1,n);
    
% Définir les paramètres 

    d1 = inf;
    l = logvraisemblance(x, y, b);                                                                                                               
    delta = .000001;                                                        
    max_iterations = 15;                                                     
    i = 0;
    
% Créer la boucle d'itérations  

    while abs(d1) > delta & i < max_iterations  ;  
        
        i = i + 1;                                                                      
        g = gradient(y, x, b);                                                      
        hess = hessian(y, x, b, n);                                                 
        H_inv = inv(hess);                                                 
        DELTA = mtimes(H_inv,g.');       
        DELTA = DELTA.';                                                               
        
    % Mettre à jour les coefficients      
    
        b = b + DELTA;                                                                                                                                
        
    % Mettre à jour le log de vraisemblance
    
        sigmoid(x, b);
        l_new = logvraisemblance(x, y, b);                                                      
        d1 = l - l_new;                                                           
        l = l_new;

    end
    
% Retourner les résultats

% Si la fonction à 2 arguments, uniquement les coefficients sont retournés.
% Si la fonction à 3 arguments, une table est retournée.

    switch nargin
        
        case 2
            logit = b.' ;
            
        otherwise
            logit= b.';
            varlist = ["Constante", varlist].';
            varlist = cellstr(varlist);
            logit =table(logit,'RowNames',varlist);

    end
    end
