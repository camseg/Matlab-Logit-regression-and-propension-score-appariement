% Fonction Logit

% logit(y,x,varlist(optionnel))

% La fonction peut �tre utilis� avec 2 ou avec 3 arguments. 

% 'y' doit �tre une matrice de taille m x 1 o� m est le nombre
% d'observations. y repr�sente la variable d�pendante et doit �tre binaire.

% 'x' doit �tre une matrice de taille m x n o� m est le nombre
% d'observations et n est le nombre de variables explicatives uttilis�s
% pour la r�gression. Le nombre d'observations doit �tre le m�me pour y et
% x.

%'varlist' est un array de taille m x 1 qui contient les noms des variables
%explicatives. Cet argument est optionnel.

%Avec 2 arguments, la fonction logit retourne une matrice des coefficients
%de taille n x 1. La premi�re variable est la constante.

%Avec 3 arguments, la fonction logit retourne une table des coefficients
%avec les noms des variables et les coefficients.

function logit = logit(y, x, varlist)

% �tablir la taille de la matrice de variable explicatives (m*n)
    
    m=size(x,1);
    n=size(x,2)+1;
    
% Ajouter une colonne de 1 au d�but de la matrice de variables
% ind�pendantes pour simplifier l'�criture (b1*1 + b2x2 +b3x3 ..)

    x_0 = ones(m,1);
    x = horzcat(x_0, x);
   
% Cr�er la matrice de coefficients initiaux (0) et ajouter une constante initiale(0)

    b = zeros(1,n);
    
% D�finir les param�tres 

    d1 = inf;
    l = logvraisemblance(x, y, b);                                                                                                               
    delta = .000001;                                                        
    max_iterations = 15;                                                     
    i = 0;
    
% Cr�er la boucle d'it�rations  

    while abs(d1) > delta & i < max_iterations  ;  
        
        i = i + 1;                                                                      
        g = gradient(y, x, b);                                                      
        hess = hessian(y, x, b, n);                                                 
        H_inv = inv(hess);                                                 
        DELTA = mtimes(H_inv,g.');       
        DELTA = DELTA.';                                                               
        
    % Mettre � jour les coefficients      
    
        b = b + DELTA;                                                                                                                                
        
    % Mettre � jour le log de vraisemblance
    
        sigmoid(x, b);
        l_new = logvraisemblance(x, y, b);                                                      
        d1 = l - l_new;                                                           
        l = l_new;

    end
    
% Retourner les r�sultats

% Si la fonction � 2 arguments, uniquement les coefficients sont retourn�s.
% Si la fonction � 3 arguments, une table est retourn�e.

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
