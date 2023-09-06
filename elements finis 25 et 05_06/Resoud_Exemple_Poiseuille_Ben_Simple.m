% Résolution d'un écoulement de Poiseuille.

clear all;
close all;
clc;

%******************************************************
%********* Taille caractéristique de la section  ******
%******    et fichier contenant le maillage    ********
%******************************************************

Echelle = 1; % En m à priori.

% *** mode : 0 carré        ***
% ***        1 triangle     ***
% ***        2 cacaouette   ***

mode = 0 ;

%******************************************************
%************   Création du maillage      *************
% !! Sauter cette partie si le maillage existe déjà. **
%***  Sinon la fonction "Mailleur_Simple...." crée ****
%****     le fichier "NomfichMaillage"             ****
%*** ou la fonction "Converti_Mailleur_Freefem" crée **
%*****  également le fichier "NomfichMaillage"     ****
%******************************************************
%******************************************************

switch mode

case {0}
% Si "Mailleur_Simple_..."
NomfichMaillage='triangulation_Rec'; % Nom du fichier de sauvegarde 
% du maillage
Longueur=Echelle; % En m à priori.
Largeur=Longueur; % En m à priori.
Nx=30; % Entrée commune aux rectangles et aux triangles équilatéraux.
Ny=15; % Uniquement pour les rectangles
Mailleur_Simple_Poiseuille_Rect(Longueur,Largeur,Echelle,Nx,Ny,NomfichMaillage);

case{1}
NomfichMaillage='triangulation_Tri';
Longueur=Echelle; % En m à priori.
Largeur=Longueur; % En m à priori.
Nx=30; % Entrée commune aux rectangles et aux triangles équilatéraux.
Ny=15; % Uniquement pour les rectangles
Mailleur_Simple_Poiseuille_TriEqui(Longueur,Echelle,Nx,NomfichMaillage);

case{2}
% Si Conversion depuis freefem++
% Le fichier ".msh" est réputé être en coordonnées réduites
NomfichMaillage_freefem='Cacaouette_Avec_Trous.msh';
NomfichMaillage='Cacaouette_Avec_Trous';
Converti_Mailleur_Freefem(NomfichMaillage_freefem,NomfichMaillage,Echelle);

end

pause; % Pour examiner, sauvegarder ou imprimer le tracé du maillage.
close all;

%******************************************************
%      Rechargement du fichier de maillage            *
%******************************************************

% Nomfich = fichier contenant les données crées par le mailleur.
NomfichMaillage=strcat(NomfichMaillage,'.mat');
if (~exist(NomfichMaillage,'file'))
    error('Le maillage n"existe pas.');
end

% On charge le maillage et les diverses données utiles.
load(NomfichMaillage);

a = 1; % Chute de pression
mu = 1; % viscosité constante du modèle

%******************************************************
%            Tableau des matrices locales             *
%******************************************************

% Initialisation/déclaration des cellules de "tab".
tab = cell(2,NT); 

for k=1:NT
    tab{1,k}=0.0; % surface du triangle
    tab{2,k}=zeros(3,3); % Matrice local K_loc
end

% Calcul et affectation dans "tab" des matrices locales 
% K_loc et des surfaces de chaque triangle.

%................. à programmer ...................

close all;

% ******************************************************
% Assemblage de la matrice de rigidité globale 
% et du vecteur de sollicitation global 
% ******************************************************

%................. à programmer ...................

% ******************************************************
% ************ Conditions aux limites   ****************
% ******************************************************

%................. à programmer ...................

% ******************************************************
% **     Calcul de la vitesse en résolvant        ******
% **            le système linéaire                  ***
% ******************************************************

%................. à programmer ...................

% ******************************************************
% ***      Affichage de la solution par "patches"    ***
% ******************************************************

%................. à programmer ...................

