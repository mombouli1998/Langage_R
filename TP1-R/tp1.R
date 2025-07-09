# TP1
# Exercice 1
# Créer un vecteur contenant les nombres pairs de 2 à 10
vec <- seq(from = 2, to = 10, by = 2)

# Calculer la somme et la moyenne
somme <- sum(vec)
moyenne <- mean(vec)

# Affichage du vecteur, de la somme et de la moyenne
vec; somme; moyenne


# Exercice 2
# 1. Convertir les températures Fahrenheit en Celsius
TmpF <- data.frame(jour = c("lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"),
                   TF = c(53.6, 59.0, 50.0, 57.2, 64.4, 68.0, 60.8))

# Conversion correcte en Celsius
tmpC <- data.frame(jour = TmpF$jour, TC = (TmpF$TF - 32) * (5 / 9))

# Température moyenne de la semaine
mean(tmpC$TC)

# Affichage des jours avec des températures supérieures à 15°C
tmpC[tmpC$TC > 15, ]

# Température minimale et maximale
min(tmpC$TC)
max(tmpC$TC)

# Augmentation des températures de 2°C
tmpC$TC <- tmpC$TC + 2

# Affichage de l'histogramme des températures
library(ggplot2)
ggplot(tmpC, aes(x = jour, y = TC)) +
  geom_col() +
  labs(title = "Température par semaine en °C",
       x = "Jour de la semaine",
       y = "Température en °C") +
  theme_minimal()


# Exercice 3
conjoint1 <- c(1200, 1180, 1750, NA)

# 1. Afficher le minimum et le maximum en ignorant les valeurs manquantes
min(conjoint1, na.rm = TRUE)
max(conjoint1, na.rm = TRUE)

# Afficher la moyenne avec deux décimales
round(mean(conjoint1, na.rm = TRUE), 2)


# Exercice 4 : Analyse climatique
temperature <- c(3.4, 4.8, 8.4, 11.4, 15.8, 19.4, 22.2, 21.6, 17.6, 13.4, 7.6, 4.4)
precipitation <- c(47.2, 44.1, 50.4, 74.9, 90.8, 75.6, 63.7, 62.0, 87.5, 98.6, 81.9, 55.2)

# 1. Calculer la température moyenne annuelle
mean(temperature)

# 2. Calculer la somme totale des précipitations
sum(precipitation)

# 3. Visualiser les données avec ggplot2
climat <- data.frame(
  mois = c("Jan", "Fév", "Mar", "Avr", "Mai", "Juin", "Juil", "Aoû", "Sep", "Oct", "Nov", "Déc"),
  temperature = temperature,
  precipitation = precipitation
)

# Variation de la température annuelle
ggplot(climat, aes(x = factor(mois, levels = mois), y = temperature)) +
  geom_col(color = "red") +
  labs(title = "Variation de la température annuelle",
       x = "Mois de l'année",
       y = "Température (°C)") +
  theme_minimal()

# Variation des précipitations annuelles
ggplot(climat, aes(x = factor(mois, levels = mois), y = precipitation)) +
  geom_col(color = "blue") +
  labs(title = "Variation des précipitations annuelles",
       x = "Mois de l'année",
       y = "Précipitations (mm)") +
  theme_minimal()


# Exercice 5 : Calcul de revenus par ménage
conjoint1 <- c(1200, 1180, 1750, 2100)
conjoint2 <- c(1450, 1870, 1690, 0)
nb_personnes <- c(4, 2, 3, 2)

# Revenu total pour chaque foyer
(Revenue_total <- conjoint1 + conjoint2)

# Revenu par personne
(revenu_personne <- Revenue_total / nb_personnes)


# Exercice 6 : Jeu de données mtcars

# 1. Charger les données
Mtcars <- mtcars

# 2. Connaître la structure des données
typeof(Mtcars)

# 3. Afficher les premières lignes
Mtcars[1:5, ]

# 4. Ajouter une colonne nommée "consommation" (en L/100 km)
Mtcars$consommation <- 235.214583 / Mtcars$mpg

# 5. Afficher un résumé statistique des données
summary(Mtcars)

# 6. Afficher les voitures ayant une consommation > 20 litres
Mtcars[Mtcars$consommation > 20, ]

# 7. Afficher uniquement les colonnes consommation, hp et gear
Mtcars[, c("consommation", "hp", "gear")]

# 8. Calculer la moyenne de consommation des voitures à transmission manuelle
mean(Mtcars[Mtcars$am == 1, ]$consommation)

# Ou encore
tmanuelle <- Mtcars[Mtcars$am == 1, ]
mean(tmanuelle$consommation)

# 9. Graphique de la relation entre le poids et la consommation
ggplot(Mtcars, aes(x = wt, y = consommation)) +
  geom_point(size = 3, color = "red") +
  labs(title = "Relation entre le poids (wt) des véhicules et la consommation",
       x = "Poids (tonnes)",
       y = "Consommation (L/100 km)") +
  theme_minimal()
