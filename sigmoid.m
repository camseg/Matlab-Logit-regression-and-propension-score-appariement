% Fonction sigmoïde

% (1/(1+e^-z) = e^z/(1+e^z)
% où z = b0 + b1x1 + ... + bnxn


function sig = sigmoid(x, b)
z = b .* x;
z = sum(z,2);
sig = (1 ./(1+(exp(-z))));
end