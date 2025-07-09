######TP3######
##EXERCICE1: Analyse des données
# 1. Nombre de lignes et de colonnes
nrow(pdh_export)
ncol(pdh_export)

# 2. Afficher le nom des colonnes
names(pdh_export)

# 3. Afficher la première ligne
pdh_export[1, ]

# 4. Vérifier que les données concernent uniquement la France
unique(pdh_export$country)

# 5. Combien de villes différentes ?
length(unique(pdh_export$city))

# 6. Prélèvements réalisés à Dijon
nrow(pdh_export[pdh_export$city == "DIJON", ])

# 7. Sources de prélèvement et nombre par source
table(pdh_export$matrix)

# 8. Période couverte : date la plus ancienne et la plus récente
min(pdh_export$date)
max(pdh_export$date)

# 9. Nombre de prélèvements par an
table(pdh_export$year)

# 10. Top 5 des villes avec le plus de prélèvements
sort(table(pdh_export$city), decreasing = TRUE)[1:5]



###Exercice 2 : Statistiques selon les 5 sources de prélèvement
# Moyenne, médiane et écart-type de pfas_sum par type de matrix
matrices <- unique(pdh_export$matrix)
my <- med <- sd <- numeric(0)

for (i in matrices) {
  values <- pdh_export[pdh_export$matrix == i, ]$pfas_sum
  my[i] <- mean(values, na.rm = TRUE)
  med[i] <- median(values, na.rm = TRUE)
  sd[i] <- sd(values, na.rm = TRUE)
}

my      # Moyennes
med     # Médianes
sd      # Écarts-types

# Quelles sont les sources de prélèvement à Dijon ?
unique(pdh_export[pdh_export$city == "DIJON", ]$matrix)

# Villes concernées par les prélèvements d’eau de mer
unique(pdh_export[pdh_export$matrix == "Sea water", ]$city)



#### Exercice 3 : Qualité des données
# 1. Mettre les noms de villes en majuscules
pdh_export$city <- toupper(pdh_export$city)

# 2. Valeurs manquantes par colonne
colSums(is.na(pdh_export))

# 3. Types de données par colonne
sapply(pdh_export, class)

# 5. Colonnes avec une seule valeur (donc non informatives)
v_unique <- function(x) length(unique(x)) == 1
as.data.frame(sapply(pdh_export, v_unique))

# 6. Suppression des colonnes non indispensables
data2 <- pdh_export[, c(-1, -4, -6:-14, -16)]
names(data2)

# 7. Nombre de colonnes dans le nouveau dataset
ncol(data2)


#### Exercice 4 : Exploitation des données au format json
library(jsonlite)
library(tidyverse)
library(tibble)

# 1. Conversion de pfas_values
data2 <- data2 %>%
  mutate(pfas_values = map(pfas_values, ~ fromJSON(.) %>% as_tibble())) %>%
  unnest(pfas_values, names_sep = "_")

# 2. Compter les substances détectées
table(data2$pfas_values_substance)

# 3. Les 5 substances les plus fréquentes
sort(table(data2$pfas_values_substance), decreasing = TRUE)[1:5]

# 4. Présence de PFOS, PFOA, PFDA et PFNA
Subs <- c("PFOS", "PFOA", "PFDA", "PFNA")
frequence <- sapply(Subs, function(x) sum(data2$pfas_values_substance == x))
frequence


###Exercice 5 : Analyse des prélèvements de Dijon
# 1. Substances détectées à Dijon
table(data2[data2$city == "DIJON", ]$pfas_values_substance)

# 2. Classement des villes selon la somme des PFAS > 1
villes <- unique(data2$city)
classement <- sapply(villes, function(x) sum(data2[data2$city == x, ]$pfas_sum, na.rm = TRUE))
classement <- sort(classement[classement > 1], decreasing = TRUE)
classement


###Exercice6library(tm)
library(wordcloud)
library(RColorBrewer)

# Données pour nuage de mots
substance_counts <- as.data.frame(table(data2$pfas_values_substance))
colnames(substance_counts) <- c("substance", "n")
substance_counts <- subset(substance_counts, n > 3)

# Nuage de mots
wordcloud(
  words = substance_counts$substance,
  freq = substance_counts$n,
  min.freq = 3,
  max.words = 50,
  random.order = FALSE,
  colors = brewer.pal(8, "Dark2")
)
title(main = "Substances détectées")

# Export final
write.csv(data2, "data4.csv", row.names = FALSE)
