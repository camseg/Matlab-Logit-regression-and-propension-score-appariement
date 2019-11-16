% Matrice hessienne

function hes = hessian(y, x, b, n)  

%Cr�er la variable sigmoid(x, b) * (1-sigmoid(x, b))

sp = sigmoid(x, b) .*(1-sigmoid(x, b));

%Cr�er la matrice hessienne

hes = zeros(n);
  
    for i=1:n;
            for j=1:n;
                
%Comme la matrice est sym�trique, pour acc�l�rer l'ex�cution, on calcule seulement les variables situ� en
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