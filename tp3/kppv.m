function [Partition,distance_min] = kppv(DataA,DataT,labelA,K,ListeClass)
Na = size(DataA,1);
Na2 = size(DataA,2);
[Nt,~] = size(DataT);

Nt_test = Nt; % A changer, pouvant aller de 1 jusqu'à Nt

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);
nb_erreurs = 0;
distance_min = 10000000000;
nb_classes = length(ListeClass);
disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test

    %disp(['image test n°' num2str(i)])

    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
   
    d_carre = sum ((DataA - DataT).^2,1);

    % On ne garde que les indices des K + proches voisins
    [D_carree, ind_kppv] = sort(d_carre);
    ind_kppv = ind_kppv(1:K);

    % Comptage du nombre de voisins appartenant à chaque classe

    classes_kppv = labelA(ind_kppv);
    nech = zeros(nb_classes, 1);
    for j = 1:nb_classes
        nech(j) = length(find(classes_kppv == ListeClass(j)));
    end
    % Recherche de la classe contenant le maximum de voisins
    [~, ind_max] = max(nech);

    % Si l'image test a le plus grand nombre de voisins dans plusieurs
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    if(length(ind_max) == 1)
        classe_test = ListeClass(ind_max);
    else
        classe_test = labelA(ind_kppv(1));
    end

    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    Partition(i) = classe_test;
    if distance_min > D_carree(1)
        distance_min = D_carree(1);
    end
    % Mise a jour de la matrice de confusion
    %Confusion(labelA(i)+1, classe_test+1) = Confusion(labelA(i)+1, classe_test+1) + 1;

    % Mise a jour du nombre d'erreur 
    if classe_test ~= labelA(i)
        nb_erreurs = nb_erreurs + 1;
    end    
end