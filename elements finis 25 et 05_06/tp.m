% R�solution d'un �coulement de Poiseuille.

clear all;
clc;
close all;

%******************************************************
%********* Taille caract�ristique de la section  ******
%******    et fichier contenant le maillage    ********
%******************************************************

Echelle = 1; % En m � priori.

% *** mode : 0 carr�        ***
% ***        1 triangle     ***
% ***        2 cacaouette   ***

mode = 1 ;

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
  
for k = 1:NT
    A= Num(:,k);

    %coord des sommets
    x1 = Som(1,A(1));
    x2 = Som(1,A(2));
    x3 = Som(1,A(3));

    y1 = Som(2,A(1));
    y2 = Som(2,A(2));
    y3 = Som(2,A(3));

    %aire du triangle
    tab{1,k} = 1/2 * abs( ( (x2-x1)*(y3-y1) ) - ((x3-x1)*(y2-y1)));

    %matrice de rigidit� locale
    Kloc = zeros(3,3);

    Kloc(1,1) = ((x3-x2)^2 + (y3-y2)^2)/2;
    Kloc(2,2) = ((x3-x1)^2 + (y3-y1)^2)/2;
    Kloc(3,3) = ((x2-x1)^2 + (y2-y1)^2)/2;

    Kloc(1,2) =-((x3-x1)*(x3-x2))-((y3-y1)*(y3-y2)) ;
    Kloc(1,3) =((x2-x1)*(x3-x2))+((y2-y1)*(y3-y2)) ;
    Kloc(2,3) =-((x2-x1)*(x3-x1))-((y2-y1)*(y3-y1));
    
    tab{2,k}= mu/(4*tab{1,k})*(Kloc+Kloc');

    %vecteur de sollicitation local
    Floc = ones(3,1);
    Floc = a*tab{1,k}/4*Floc;

    Uloc =  tab{2,k}\Floc;

    %conditions aux limites
    if Som(3,A(1)) ~= 0
        Uloc(1) = 0;
    end

    if Som(3,A(2)) ~= 0
        Uloc(2) = 0;
    end

    if Som(3,A(3)) ~= 0
        Uloc(3) = 0;
    end

end


% ******************************************************
% Assemblage de la matrice de rigidit� globale 
% et du vecteur de sollicitation global 
% ******************************************************
Kglob = zeros(NS,NS);
Fglob = zeros(NS,1);
for k = 1:NT
    mapping = Num(:,k);
    
    %on ajoute les valeurs des Klocs correspondants aux bons sommets
    for i = 1:3
        for j = 1:3
            Kglob(mapping(i),mapping(j)) = Kglob(mapping(i),mapping(j)) + tab{2,k}(i,j);
        end
    end
     %on ajoute les valeurs des Flocs correspondants aux bons sommets
    for i = 1:3
        Fglob(mapping(i)) = Fglob(mapping(i)) + Floc(i);
    end

end


% ******************************************************
% ************ Conditions aux limites   ****************
% ******************************************************



% ******************************************************
% **     Calcul de la vitesse en r�solvant        ******
% **            le syst�me lin�aire                  ***
% ******************************************************



% ******************************************************
% ***      Affichage de la solution par "patches"    ***
% ******************************************************

%................. � programmer ...................


close all;