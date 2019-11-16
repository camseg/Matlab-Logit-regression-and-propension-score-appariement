% Gradient

function grad = gradient(y, x, b)        
    
% Établir y moins la probabillité de la fonction logit

    ys = y-sigmoid(x, b);
    
%Calculer le gradient

    grad = ys .* x;
    
%Calculer la somme des colonnes

    grad = sum(grad);
    
end