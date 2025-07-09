#Exercice1
library(leaflet)
library(dplyr)
library(htmlwidgets)

# Sélection colonnes d'intérêt
t <- pdh_export[, c(2, 3, 5, 17)]

# Filtrer les données avec lat/lon non manquants
t <- t %>% filter(!is.na(lat) & !is.na(lon))

# Création carte leaflet avec popup et label
carte <- leaflet(data = t) %>%
  addTiles() %>%
  addMarkers(
    lng = ~lon,
    lat = ~lat,
    popup = ~paste0("<strong>Ville :</strong> ", city, "<br>",
                    "<strong>Somme PFAS :</strong>", pfas_sum),
    label = ~paste(city, ": ", pfas_sum, "PFAS")
  ) %>%
  setView(lng = 2.2137, lat = 46.603354, zoom = 6)

# Sauvegarde et ouverture
saveWidget(carte, "carte_pfas_france.html", selfcontained = TRUE)
browseURL("carte_pfas_france.html")


#exercice2
# 1. Villes avec latitude négative
l_negative <- t[t$lat < 0, ]$city
print(l_negative)

# 2. Suppression des lignes avec lat < 0 ou lon < 0
t <- t %>% filter(!(lat < 0) & !(lon < 0))

# Conversion en tibble et ajout ligne pour Dijon avec valeur manquante de pfas_sum
library(tibble)
data3 <- as_tibble(t)
data3 <- add_row(data3, lat = 47.3215806, lon = 5.0414701, city = "DIJON", pfas_sum = NA)

# Affichage
print(data3)

# Affichage carte pour data3
carteData3 <- leaflet(data = data3) %>%
  addTiles() %>%
  addMarkers(
    lng = ~lon,
    lat = ~lat,
    popup = ~paste0("<strong>ville :</strong>", city, "<br>",
                    "<strong>Somme PFAS :</strong>", pfas_sum),
    label = ~paste(city, ": ", pfas_sum, "PFAS")
  ) %>%
  setView(lng = 2.2137, lat = 46.603354, zoom = 6)

saveWidget(carteData3, "carteData3.html", selfcontained = TRUE)
browseURL("carteData3.html")


#Exercice 4 : Personnaliser la carte
# Remplacer NA par 0 dans pfas_sum
data4 <- data3 %>% mutate(pfas_sum = ifelse(is.na(pfas_sum), 0, pfas_sum))

# Fonction pour définir la couleur selon pfas_sum
getColor <- function(pfas_sum) {
  if (pfas_sum >= 50) {
    "red"
  } else if (pfas_sum >= 20) {
    "violet"
  } else if (pfas_sum >= 5) {
    "blue"
  } else {
    "gray"
  }
}

data4$color <- sapply(data4$pfas_sum, getColor)

# Carte avec cercles colorés
carte_personnalise <- leaflet(data4) %>%
  addTiles() %>%
  addCircleMarkers(
    lng = ~lon,
    lat = ~lat,
    radius = 5,
    color = ~color,
    fillOpacity = 0.7,
    popup = ~paste0("<strong>Ville :</strong>", city, "<br>",
                    "<strong>Somme PFAS :</strong> ", pfas_sum),
    label = ~paste(city, ": ", pfas_sum, "PFAS")
  ) %>%
  addLegend(
    position = "bottomright",
    colors = c("red", "violet", "blue", "gray"),
    labels = c("Valeurs élevées (≥ 50)",
               "Moyennes-hautes (20 à 49)",
               "Moyennes-basses (5 à 19)",
               "Faibles (< 5)"),
    title = "Concentration de PFAS"
  ) %>%
  addControl(
    html = "<strong style='font-size:16px;'>PFAS détectés de 2015 à 2024</strong>",
    position = "topright"
  ) %>%
  setView(lng = 2.2137, lat = 46.603354, zoom = 6)

carte_personnalise

saveWidget(carte_personnalise, "carte_personnalise.html", selfcontained = TRUE)
browseURL("carte_personnalise.html")


#Exercice5library(sf)

# Import GeoJSON des régions françaises
region <- st_read("https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/regions.geojson")

# Conversion des prélèvements en objet sf
data3_sf <- st_as_sf(data3, coords = c("lon", "lat"), crs = 4326, agr = "constant")

# Jointure spatiale : associer prélèvements à une région
data3_region <- st_join(data3_sf, region, join = st_within)

# Résumé par région : moyenne et nombre de prélèvements
stats_region <- data3_region %>%
  st_drop_geometry() %>%
  group_by(nom) %>%
  summarise(
    mean_pfas = mean(pfas_sum, na.rm = TRUE),
    count = n()
  )

print(stats_region)
