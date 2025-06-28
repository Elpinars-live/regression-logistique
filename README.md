# Mise en place d'une régression logistique
 **Intro:** La régression logistique est une méthode de classification supervisée utilisée pour prédire la probabilité qu’un événement binaire se produise.    
> **prérequis:** il faut au préalabel avoir R
et [R tools](https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html)
> 
**l’objectif:** d’une régression logistique est de modéliser la probabilité d’occurrence d’un événement binaire (par exemple : succès/échec, présence maladie/pas malade) en fonction d’un ensemble de variables explicatives. Elle permet ainsi de prédire la classe la plus probable pour une observation, tout en estimant l’influence de chaque variable.
## 6 hypothèses à vérifié avant de procéder :

1. La variable à expliqué est une variable binaire à deux modalités (ou plus dans certains cas complexe):    
- simple exemple de variable binaire à expliquer : la présence d'une maladie 0/1, succès/échec (examen, concours, compétition,jeux,...)
      
2. La linéarité entre les variables explicatives et la fonction logit de la variable à expliquer :    
- La régression logistique suppose qu’il existe une relation linéaire entre chaque variable explicative et le logit de la variable de réponse.

**Comment vérifier cette hypothèse :**    
Le moyen le plus simple de voir si cette hypothèse est vérifiée est d’utiliser un test de [Box-Tidwell](méthode_box-tidwell_diabete.Rmd).

**comment adapter ses variables explicatives** (si elles sont significatives au test de box_tidwell):      
le plus simple est de convertir la variable avec un log, sur R df$variable_adapter <- log(df$variable)      
Mais dans certains cas même avec un log la variable reste inadaptée. Il faut alors utiliser [le package "mfp"](adapt-variable.R) qui va automatiquement chercher quels est la meilleur adaptation de la variable

3. Absence de multicolinéarité:     
- La régression logistique suppose qu’il n’y a pas de multicolinéarité grave entre les variables explicatives:
- quand deux variables explicatives sont fortement corrélées les unes aux autres, elles ne fournissent pas d’informations uniques ou indépendantes dans le modèle de régression.      
*exemple : on veux prédire la détente verticale d'un joueur de basket on va regarder des variables explicatives comme la taille du jouer et la pointure, des variables souvent corrélées*    
**Comment vérifier cette hypothèse :** le moyen le plus courant de détecter la multicolinéarité consiste à utiliser le facteur d’inflation de la variance (VIF), sur R utiliser la fonction VIF(modèle) avec un modèle glm():
    - VIF = 1 Il n'y a aucune corrélation entre les variables explicatives
    - VIF = 1 à 5 on détecte la présence de faible/moyenne corélation, mais cela reste acceptable
    - VIF > 5 indique la présence de corrélation potentiellement trop forte et peux fausser la regression      
[exemple de VIF sur R avec PimaIndiansDiabetes2](VIF_diabete.R).
4. Les observations sont indépendantes:


5. Pas de valeur aberrante:
La régression logistique suppose que les données ne contiennent pas de valeurs très anormales ou d’observations qui influencent fortement le modèle, on nomme ses observations les valeurs "aberrantes", des valeurs trop extrème qui on plus de chance d'être du à des erreurs (de saisie ou autre) et qui influencerais trop la moyenne et les modèles de regression.

**Comment vérifier cette hypothèse :**      
le moyen le plus courant de tester les valeurs aberrantes extrêmes et les observations influentes dans un ensemble de données consiste à calculer [la distance de Cook](distance_de_cook.R)       
([pour en savoir plus sur la distance de Cook](https://statorials.org/comment-identifier-les-points-de-donnees-influents-en-utilisant-la-distance-des-cuisiniers/))


6. La taille de l’échantillon est suffisamment grande:
La fiabilité d’une régression logistique dépend du nombre d’observations disponibles.

**Comment vérifier ?** • Pour chaque variable explicative, on recommande au minimum 10 événements du résultat le moins fréquent (en gros 10 fois au moins la modalité la plus rare par variable). • Exemple : 3 variables + un résultat rare à 20 % ⇒ (10 × 3) / 0,20 = 150 observations minimales (150 ligne minimum dans le jeu de données).

 **sur R:**
 > pour vérifier le nombre de ligne/observation dans un dataframe : nrow(df)      
 > puis effectuer le calcul: (10 * nombre_de_variable_explicatif) / 0.20      
 > comparer les deux résultats
