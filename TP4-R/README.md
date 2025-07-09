# Visualisation cartographique des données PFAS en France

Ce projet permet de visualiser géographiquement la concentration de substances PFAS à travers la France.

## Fichiers inclus

- `carte_pfas_france.html` : Carte interactive initiale des prélèvements
- `carteData3.html` : Carte avec correction des coordonnées géographiques
- `carte_personnalise.html` : Carte avancée avec visualisation par intensité
- `regions_pfas_stats.csv` : Statistiques par région (optionnel)

## Méthodologie

### 1. Préparation des données
- Sélection des colonnes pertinentes (ville, coordonnées, concentration PFAS)
- Filtrage des points sans coordonnées géographiques
- Correction des coordonnées aberrantes (valeurs négatives)
- Ajout manuel de données manquantes (ex: Dijon)

### 2. Visualisations cartographiques
- **Carte de base** : Marqueurs standards avec popup d'information
- **Carte avancée** : 
  - Cercles colorés selon l'intensité de PFAS
  - Légende explicative
  - Titre contextuel
  - 4 niveaux de couleur :
    - Rouge : ≥ 50 PFAS (concentration élevée)
    - Violet : 20-49 PFAS
    - Bleu : 5-19 PFAS
    - Gris : < 5 PFAS

### 3. Analyse par région
- Jointure spatiale avec le découpage administratif des régions
- Calcul des statistiques régionales :
  - Concentration moyenne en PFAS
  - Nombre de prélèvements par région

## Résultats clés

1. **Répartition géographique** :
   - [Nombre] points de prélèvement valides
   - Concentrations principales à [villes/régions concernées]

2. **Points aberrants corrigés** :
   - Villes avec coordonnées négatives : [liste des villes]

3. **Analyse régionale** :
   - Région avec la plus haute concentration moyenne : [nom région]
   - Région avec le plus de prélèvements : [nom région]

## Prérequis

- R (version 4.0 ou supérieure)
- Packages R :
  - `leaflet`
  - `dplyr`
  - `htmlwidgets`
  - `sf` (pour l'analyse par région)
- Connexion internet (pour charger les fonds de carte)

## Exécution

1. Télécharger l'ensemble des fichiers
2. Exécuter le script R dans l'ordre :
   - Préparation des données
   - Génération des cartes
   - Analyse régionale (optionnel)
3. Les fichiers HTML s'ouvrent automatiquement dans le navigateur

## Résultats cartographiques


> **Note** : Les cartes interactives nécessitent d'être téléchargées et ouvertes dans un navigateur web.
## Auteur

MOMBOULI Trinité

