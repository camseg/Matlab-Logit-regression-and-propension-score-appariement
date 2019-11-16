% Fonction de maximum de vraisemblance en log

% L(b)= p(y|x,b)

function logv = logvraisemblance(x, y, b)
prob = sigmoid(x, b);
logv =sum(y .* exp(prob) +   (1-y) .* exp(1 - prob));
end
