% R�solution d'un �coulement de Poiseuille.

clear all;
close all;
clc;

%******************************************************
%********* Taille caract�ristique de la section  ******
%******    et fichier contenant le maillage    ********
%******************************************************

Echelle = 1; % En m � priori.

% *** mode : 0 carr�        ***
% ***        1 triangle     ***
% ***        2 cacaouette   ***

mode = 0 ;

%******************************************************
%************   Cr�ation du maillage      *************
% !! Sauter cette partie si le maillage existe d�j�. **
%***  Sinon la fonction "Mailleur_Simple...." cr�e ****
%****     le fichier "NomfichMaillage"             ****
%*** ou la fonction "Converti_Mailleur_Freefem" cr�e **
%*****  �galement le fichier "NomfichMaillage"     ****
%******************************************************
%******************************************************

switch mode

case {0}
% Si "Mailleur_Simple_..."
NomfichMaillage='triangulation_Rec'; % Nom du fichier de sauvegarde 
% du maillage
Longueur=Echelle; % En m � priori.
Largeur=Longueur; % En m � priori.
Nx=30; % Entr�e commune aux rectangles et aux triangles �quilat�raux.
Ny=15; % Uniquement pour les rectangles
Mailleur_Simple_Poiseuille_Rect(Longueur,Largeur,Echelle,Nx,Ny,NomfichMaillage);

case{1}
NomfichMaillage='triangulation_Tri';
Longueur=Echelle; % En m � priori.
Largeur=Longueur; % En m � priori.
Nx=30; % Entr�e commune aux rectangles et aux triangles �quilat�raux.
Ny=15; % Uniquement pour les rectangles
Mailleur_Simple_Poiseuille_TriEqui(Longueur,Echelle,Nx,NomfichMaillage);

case{2}
% Si Conversion depuis freefem++
% Le fichier ".msh" est r�put� �tre en coordonn�es r�duites
NomfichMaillage_freefem='Cacaouette_Avec_Trous.msh';
NomfichMaillage='Cacaouette_Avec_Trous';
Converti_Mailleur_Freefem(NomfichMaillage_freefem,NomfichMaillage,Echelle);

end

pause; % Pour examiner, sauvegarder ou imprimer le trac� du maillage.
close all;

%******************************************************
%      Rechargement du fichier de maillage            *
%******************************************************

% Nomfich = fichier contenant les donn�es cr�es par le mailleur.
NomfichMaillage=strcat(NomfichMaillage,'.mat');
if (~exist(NomfichMaillage,'file'))
    error('Le maillage n"existe pas.');
end

% On charge le maillage et les diverses donn�es utiles.
load(NomfichMaillage);

a = 1; % Chute de pression
mu = 1; % viscosit� constante du mod�le

%******************************************************
%            Tableau des matrices locales             *
%******************************************************

% Initialisation/d�claration des cellules de "tab".
tab = cell(2,NT); 

for k=1:NT
    tab{1,k}=0.0; % surface du triangle
    tab{2,k}=zeros(3,3); % Matrice local K_loc
end

% Calcul et affectation dans "tab" des matrices locales 
% K_loc et des surfaces de chaque triangle.

%................. � programmer ...................

close all;

% ******************************************************
% Assemblage de la matrice de rigidit� globale 
% et du vecteur de sollicitation global 
% ******************************************************

%................. � programmer ...................

% ******************************************************
% ************ Conditions aux limites   ****************
% ******************************************************

%................. � programmer ...................

% ******************************************************
% **     Calcul de la vitesse en r�solvant        ******
% **            le syst�me lin�aire                  ***
% ******************************************************

%................. � programmer ...................

% ******************************************************
% ***      Affichage de la solution par "patches"    ***
% ******************************************************

%................. � programmer ...................

