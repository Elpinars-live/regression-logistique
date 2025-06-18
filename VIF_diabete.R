#exemple de vérification de code vif sur R

# 0) Installation et chargement
# Fixer un miroir CRAN sans interaction
options(repos = c(CRAN = "https://cran.univ-paris1.fr"))
install.packages(c("mlbench","car"))  # si nécessaire
library(mlbench); library(car)

# 1) Jeu de données
data(PimaIndiansDiabetes2)
df <- na.omit(PimaIndiansDiabetes2)
head(df)

#initialisation des variables explicative
vars <- c("glucose","pressure","triceps","insulin","mass","pedigree","age")

#vérification des VIF, avec modèle glm(simple)
formule <- paste0("diabetes ~ ",
                  paste(vars, collapse=" + "), collapse=" + ") #format d'écriture pour le moddèle glm
mod_multi<- glm(as.formula(formule),
                    data = df, family = binomial) #modèle glm



formule <- paste0("diabetes ~ ",
                  paste(vars, collapse=" + "), collapse=" + ")
mod_multi<- glm(as.formula(formule),
                    data = df, family = binomial)

#vérification des vif
vif(mod_multi) #dans ce dataset les vif sont inferieur à 5 on est bon, pas de multicolinéarité
