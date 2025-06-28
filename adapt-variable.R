#exemple d'adaptation de variable avec mfp à une regression logistique sur R
options(repos = c(CRAN = "https://cran.univ-paris1.fr"))
install.packages(c("mlbench","car","mfp"))  # si nécessaire
library(mlbench); library(car); library(mfp)

# 1) Jeu de données
data(PimaIndiansDiabetes2)
df <- na.omit(PimaIndiansDiabetes2)
head(df)

#creation d'un nouveau moddèle avec fp() pour adapter les variables automatique
mod_fp <- mfp(
  diabetes ~ fp(age) + glucose + pressure + triceps +
    insulin + mass + pedigree,
  family = binomial, data = df
)

# 3) résumé du modèle
summary(mod_fp)

#on transforme alors la variable age de cette façon: I((age/10)^-2)

#on peut vérifier avec un boxTidwell si maintenant l'age est adapte au modele
#on reprend la variable age adapté:
df$age2    <- (df$age/10)^(-2) #on la renomme après age2
df$age2_bt <- df$age2 * log(df$age/10) #pour les adaptations à puissance on utilise la formule suivante X^p × log(X)
#donc on refait tout le processus (dans une boucle on va adapter a un box de tidwell les variables explicatives)
vars2 <- c("glucose","pressure","triceps","insulin","mass","pedigree","age2")
for (v in vars2) {
  df[[paste0(v,"_bt")]] <- df[[v]] * log(df[[v]])
}

formule_bt2 <- paste0("diabetes ~ ",
                      paste(vars2, collapse=" + "), " + ",
                      paste(paste0(vars2,"_bt"), collapse=" + "))
mod_bt_multi2 <- glm(as.formula(formule_bt2),
                     data = df, family = binomial)

summary(mod_bt_multi2)
#la variable age2_bt n'est pas significatif on est donc bien adapté au modèle de regression logistique
