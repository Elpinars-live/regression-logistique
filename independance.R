#exemple d'adaptation de variable avec mfp sur R
options(repos = c(CRAN = "https://cran.univ-paris1.fr"))
install.packages(c("mlbench","car","mfp"))  # si nécessaire
library(mlbench); library(car); library(mfp)

# 1) Jeu de données
data(PimaIndiansDiabetes2)
df <- na.omit(PimaIndiansDiabetes2)
head(df)

#vraiable adapter (pas forécement utile pour cette hypothèse)
df$age2 <- (df$age / 10)^(-2)

#creation d'un nouveau moddèle avec fp() pour adapter les variables automatique
mod1 <- glm(diabetes ~ age2 + glucose + pressure + triceps +
    insulin + mass + pedigree,
  family = binomial, data = df
)

#dans le cas ou il y'aurait eu une variable date:
# Assure-toi que la variable date est bien au format Date
#df$date <- as.Date(df$date)
# Puis trie le dataframe selon la date (ordre croissant)
#df <- df[order(df$date), ]

# 1. reprendre le modèle mod1
mod1 <- mod1 #inutile
# 2. Extraire les résidus (Pearson ou de deviance)
residus <- resid(mod1, type = "deviance")  # ou type = "pearson"
# 3. Tracer les résidus en fonction de l’ordre des observations
plot(residus, type = "p", main = "Résidus en fonction de l’ordre", 
     xlab = "Index de l’observation", ylab = "Résidu")
abline(h = 0, col = "red", lty = 2)

#on observe une répartition aléatoire l'hypothèse est vérifié

prop_negatifs
prop_positifs

