# Exercice : Iris de Fisher

# 1. Chargement et exploration des données

# Charger le jeu de données Iris inclus par défaut dans R
I <- iris

# Afficher les 6 premières lignes du jeu de données
head(I)

# Afficher les dimensions du jeu de données
dim(I)


# 2. Analyse statistique

# Calcul des statistiques descriptives (moyenne, médiane, variance, écart-type)
# pour chaque caractéristique numérique

apply(I[, 1:4], 2, mean)    # Moyenne
apply(I[, 1:4], 2, median)  # Médiane
apply(I[, 1:4], 2, var)     # Variance
apply(I[, 1:4], 2, sd)      # Écart-type

# Vérification individuelle (exemple sur Sepal.Length)
mean(I$Sepal.Length)
median(I$Sepal.Length)
var(I$Sepal.Length)
sd(I$Sepal.Length)

# Pour les autres variables :
# Sepal.Width
mean(I$Sepal.Width); median(I$Sepal.Width); var(I$Sepal.Width); sd(I$Sepal.Width)

# Petal.Length
mean(I$Petal.Length); median(I$Petal.Length); var(I$Petal.Length); sd(I$Petal.Length)

# Petal.Width
mean(I$Petal.Width); median(I$Petal.Width); var(I$Petal.Width); sd(I$Petal.Width)

# Identifier les valeurs minimales et maximales pour chaque caractéristique
sapply(I[, 1:4], min)
sapply(I[, 1:4], max)


# 3. Visualisation

# Boîte à moustaches : longueur des sépales par espèce
library(ggplot2)
ggplot(I, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot() +
  labs(title = "Comparaison des distributions de la longueur des sépales",
       x = "Espèce",
       y = "Longueur des sépales (cm)") +
  theme_minimal()

# Nuage de points : Petal.Length vs Petal.Width par espèce
ggplot(I, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point() +
  labs(title = "Nuage de points : longueur vs largeur des pétales",
       x = "Longueur des pétales (cm)",
       y = "Largeur des pétales (cm)") +
  theme_minimal()


# 4. Préparation des données pour la classification

# Séparer les données en un ensemble d’apprentissage (80%) et un ensemble de test (20%)
set.seed(123)
index <- sample(1:nrow(I), 0.8 * nrow(I))
train <- I[index, ]
test <- I[-index, ]

# Normalisation des variables numériques
normalise <- function(x) {(x - min(x)) / (max(x) - min(x))}
train[, 1:4] <- as.data.frame(lapply(train[, 1:4], normalise))
test[, 1:4] <- as.data.frame(lapply(test[, 1:4], normalise))


# 5. Classification avec k-NN

library(class)

# Prédiction avec k = 3
prediction <- knn(train = train[, 1:4], test = test[, 1:4], cl = train$Species, k = 3)

# Affichage des prédictions et matrice de confusion
prediction
table(Predicted = prediction, Actual = test$Species)

# Évaluation de la précision pour différents k
k_values <- c(1, 3, 5, 7)
for (i in k_values) {
  pre <- knn(train = train[, 1:4], test = test[, 1:4], cl = train$Species, k = i)
  confusion <- table(Predicted = pre, Actual = test$Species)
  accuracy <- sum(diag(confusion)) / sum(confusion)
  cat("Précision pour k =", i, ":", round(accuracy * 100, 2), "%\n")
}
