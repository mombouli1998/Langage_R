# 🌱 Apprentissage du langage R : Analyse et Visualisation de Données

Bienvenue dans ce dépôt dédié à l'exploration du langage **R** à travers des projets concrets d'analyse et de visualisation de données. L'objectif est de développer des compétences solides en traitement, nettoyage, et représentation graphique de données avec R.

---

## 🧠 Objectifs pédagogiques

- Maîtriser les bases de la manipulation de données avec **R**
- Appliquer des méthodes statistiques de base
- Créer des visualisations percutantes
- Travailler avec des jeux de données variés (CSV, JSON, géospatiaux)
- Comprendre l'importance de la qualité des données

---

## 📂 Contenu du dépôt

### 1. 📊 Analyse exploratoire des données – *Iris de Fisher*
- Utilisation du dataset classique `iris`
- Statistiques descriptives
- Création de graphiques (boxplots, histogrammes, scatter plots)

### 2. 📉 Statistiques de base
- Moyenne, médiane, variance, écart-type
- Corrélation et régression linéaire simple
- Tests statistiques élémentaires

### 3. 🧹 Qualité et préparation des données
- Détection et gestion des valeurs manquantes
- Nettoyage des données incohérentes
- Transformation des variables (facteurs, dates, etc.)

### 4. 🔎 Exploitation de données au format JSON
- Lecture et parsing de fichiers JSON
- Transformation de données nested
- Intégration avec d'autres jeux de données

### 5. ☁️ Graphique "nuage de mots"
- Génération de word clouds à partir de textes
- Prétraitement linguistique : suppression des stopwords, lemmatisation
- Mise en forme et personnalisation graphique

### 6. 🔄 Mise à jour automatisée des données
- Récupération de données en ligne (API ou web scraping)
- Automatisation avec `cronR` ou `taskscheduleR` (selon l’OS)
- Archivage des versions de données

### 7. 🗺️ Visualisation géographique

#### Personnaliser une carte avec R (ggplot2 + sf + leaflet)
- Importation et manipulation de shapefiles
- Ajout de couches personnalisées et infobulles interactives

#### Carte choroplèthe : concentrations de PFAS par région
- Chargement de données environnementales
- Jointure avec des données géospatiales (régions de France)
- Création d’une carte choroplèthe avec palette de couleurs adaptées

---

## 📦 Packages utilisés

```r
tidyverse   # Manipulation et visualisation de données
jsonlite    # Lecture de fichiers JSON
wordcloud   # Création de nuages de mots
leaflet     # Cartes interactives
sf          # Données géospatiales
ggplot2     # Visualisation de données
rgdal       # Lecture de shapefiles
lubridate   # Manipulation des dates
