% Matrice hessienne

function hes = hessian(y, x, b, n)  

%Créer la variable sigmoid(x, b) * (1-sigmoid(x, b))

sp = sigmoid(x, b) .*(1-sigmoid(x, b));

%Créer la matrice hessienne

hes = zeros(n);
  
    for i=1:n;
            for j=1:n;
                
%Comme la matrice est symétrique, pour accélérer l'exécution, on calcule seulement les variables situé en
%haut de la diagonale.

              if j>=i
                  
              hes(i,j)=sum(sp .* x(:,i) .* x(:,j));
              
              end      
              
            end
    end
    
% On reproduit la portion du haut de la matrice au bas de la diagonale.

 hes = hes+triu(hes,1).';
 
 hes;
 
end