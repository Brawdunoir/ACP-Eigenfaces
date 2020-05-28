clear variables;clc
% tolerance relative minimum pour l'ecart entre deux iteration successives 
% de la suite tendant vers la valeur propre dominante 

eps = 1e-8;
% nombre d iterations max pour atteindre la convergence 
% (si i > MaxIter, l'algo finit)
MaxIter = 5000; 

% Generation d une matrice Carré aleatoire A de taille n x n.

n = 15; p = 5; m = 3;
P = 5*randn(n,p);


A = P*P';
normA = norm(A, 'fro');

%% Methode de la puissance iteree 
% Point de depart de l'algorithme de la puissance iteree : un ensemble de m
% vecteurs aleatoires, normalises

V = rand(n, m);
V = mgs(V);

V1 = V;
V2 = V;

cv = false;
k1 = 0;  % pour compter le nombre d'iterations effectuees

err1 = 0; % residu de la norme du vecteur propre. On sort de la boucle 
% quand err1 <eps 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PREMIERE MEHODE : L'ALGORITHME DE LA PUISSANCE ITERE TEL QUE DONNE DANS L'ENONCE APPLIQUE AU
%VECTEUR V
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W1 = zeros(m,1);
Vout1 = zeros(n,m);

for j = 1:m
    cv = false;
    k1 = 0;
    err1 = 0;
    x = V1(:,j);
    x= x/norm(x);
    lambda = x'*A*x;
    
    
    while(~cv)
   
        mu1 = lambda;
        x = A*x;
        x = x/norm(x);
        lambda = x'*A*x;
        k1 = k1 + 1;
        err1 = abs((lambda-mu1)/abs(mu1));
        cv = or(k1 > MaxIter, err1 < eps);
    end
    
    W1(j,1) = lambda;
    Vout1(:,j) = x;
    
end

[W1, indice] = sort(W1, 'descend');
Vout1 = Vout1(:, indice);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DUXIEME METHODE : L'ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS L'ENONCE AVEC
%ORTHONORMALISATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ W2, Vout2, k2, flag ] = subspace_iter_v0( A, m, eps, MaxIter )

[Q, D] = eig(A);
[D, i] = sort(diag(D), 'descend');
Q = Q(:, i);
diff1 = sum(sum(abs(abs(Vout1)-abs(Q(:,1:m)))));
diff2 = sum(sum(abs(abs(Vout2)-abs(Q(:,1:m)))));

% Résultats

fprintf('Ecart relatif entre la première méthode et eig sur les vecteurs propres trouvees = %1.2e\n', diff1);
fprintf('Ecart relatif entre la deuxième méthode et eig sur les vecteurs propres trouvees = %1.2e\n', diff2);
fprintf('Valeurs propres de A trouvés avec eig %1.2e\n',D(1:m));
fprintf('Valeurs propres de A trouvés avec première méthode %1.2e\n',W1(1:m));
fprintf('Valeurs propres de A trouvés avec deuxième méthode %1.2e\n',W2(1:m));


