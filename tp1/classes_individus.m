clear variables
close all

%% chargement du jeu de donn�es
load('dataset.mat')
nb_indiv = size(X,1);
nb_variables = size(X,2);

%% ACP

X_m = mean(X);
X_C = X - X_m;

sigma = (1/nb_indiv)*(X_C)'*X_C;
[U,D] = eig(sigma);
contraste = diag(D)/trace(D);

[contraste,i] = sort(contraste, 'descend');

U = U(:,i);

C = X_C*U;


%% Affichage 

% Affichage pourcentage information par axe

figure(1), clf
plot(contraste*100,'k-','linewidth',2);
title('Pourcentage d information contenue sur chaque composante principale')
xlabel('numéro de la composante principale');ylabel('pourcentage d information');

% Affichage sur la première composante principale

figure(2),clf
grid on
plot(C(:,1),zeros(nb_indiv),'r+','linewidth',1.5);
title('Projection des données sur la première composante principale')

% Affichage sur les deux premières composantes principales

figure(3), clf, 
grid on 
plot(C(:,1),C(:,2),'r+','linewidth',1.5);
title('Projection des données sur les deux premiers axes principaux')

% Affichage sur les trois premières composantes principales

figure(4),clf, 
grid on
plot3(C(:,1),C(:,2),C(:,3),'r+','linewidth',1.5);
title('Projection des données sur les trois premiers axes principaux')

% Affichage sur trois autres premières composantes principales

figure(5),clf, 
grid on
plot3(C(:,3),C(:,4),C(:,6),'r+','linewidth',1.5);
title('Projection des données sur trois autres premiers axes principaux (3, 4 et 6)')










