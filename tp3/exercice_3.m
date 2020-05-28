clear;
close all;
load donnees;
load exercice_1;
%load clusters;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

% Matrice de confusion
confusion = zeros(5);

% Seuil de reconnaissance a regler convenablement
s = 4.0e+01;

% Pourcentage d'information 
per = 0.95;

% Nombre de plus proches voisins dans la méthode kppv
k = 4;

% Tirage aleatoire d'une image de test :
individu = randi(37);
posture = randi(6);
chemin = './Images_Projet_2020';
fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg'];
Im=importdata(fichier);
I=rgb2gray(Im);
I=im2double(I);
image_test=I(:)';
 

% Affichage de l'image de test :
colormap gray;
imagesc(I);
axis image;
axis off;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = 8;

% N premieres composantes principales des images d'apprentissage :
C=(X_C*W)';
D_A = C(1:N,:);

% N premieres composantes principales de l'image de test :

image_test_centree = image_test - individu_moyen;
D_T = (image_test_centree * W)';
D_T = D_T(1:N);

% ListeClass :
ListeClass = [2, 4, 6, 37];

% Determination de l'image d'apprentissage la plus proche (plus proche voisin) :

[Partition, distance_min] = kppv(D_A,D_T,[2 2 2 2 4 4 4 4 6 6 6 6 37 37 37 37], k, ListeClass);
individu_reconnu = Partition;

% Affichage du resultat :
if  distance_min <= s
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
    ['Je reconnais l''individu numero ' num2str(individu_reconnu(1)+3)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
		'Je ne reconnais pas cet individu !'},'FontSize',20);
end

confusion = majConf(confusion, individu, individu_reconnu(1), ListeClass);