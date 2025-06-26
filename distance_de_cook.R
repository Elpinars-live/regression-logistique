#librairie utilisé
library(ggplot2)
library(gridExtra)

#on reprend le modèle multiple avec toutes nos variable pour notre regression logisitique
mod_multi # mod_multi <- glm(diabetes ~ glucose + pressure + triceps + insulin + mass + pedigree + age,  data=df, family=binomial)

#trouve la Cook distance pour chaque observation dans le jeu de donnée
cooksD <- cooks.distance(mod_multi)

# graphique de la distance de Cook avec une ligne horizontale a 4/(n-p) et voir ce qui se passe
n <- nrow(df) #n est le nombre d'observation dans le jeu de données
p <- length(coef(mod_multi))  # nb de paramètres (incluant l'intercept)
plot(cooksD, main = "Cooks Distance for Influential Obs")
abline(h = 4/(n-p), col = "blue", lty = 3) # rajoute la limite (pour p predicteur)

influents <- which(cooksD > 4/n)
df[influents, ]   # affiche les lignes influentes
nrow(df[influents, ]) #Il y a 28 lignes influentes donc trop forte et influent trop le modèle (que l'on appelle valeur "aberrante") que l'on va retirer du modèle

# pour les supprimer, on prend df[-influents, ]
df_clean <- df[-influents, ] #un nouveau df sans les valeurs aberrantes


#pour creuser plus loin:
infl <- influence.measures(mod_multi)
summary(infl)        # résume Cook, hat-values, DFBETAs pour chaque coefficient
