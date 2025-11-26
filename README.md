# Mise en place d'une régression logistique

**Intro :** La régression logistique est une méthode de classification supervisée utilisée pour prédire la probabilité qu’un événement binaire se produise.  
> **Prérequis :** il faut au préalable avoir R  
> et [Rtools](https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html)

**L’objectif :** une régression logistique permet de modéliser la probabilité d’occurrence d’un événement binaire (par exemple : succès/échec, présence d’une maladie/absence) en fonction de variables explicatives.

## 6 hypothèses à vérifier avant de procéder :

1. La variable à expliquer est une variable binaire à deux modalités (ou plus dans certains cas complexes) :  
- exemple simple de variable binaire à expliquer : la présence d'une maladie 0/1, succès/échec (examen, concours, compétition, jeux, ...)

2. La linéarité entre les variables explicatives et la fonction logit de la variable à expliquer :  
- La régression logistique suppose qu’il existe une relation linéaire entre chaque variable explicative et le logit de la variable de réponse.

Comment vérifier cette hypothèse :  
Le moyen le plus simple de voir si cette hypothèse est vérifiée est d’utiliser un test de [Box-Tidwell](méthode_box-tidwell_diabete.Rmd).

Comment adapter ses variables explicatives (si elles sont significatives au test de Box-Tidwell) :  
Le plus simple est de transformer la variable avec un log, par exemple sur R : df$variable_adaptée <- log(df$variable)  
Mais dans certains cas, même avec un log la variable reste inadaptée. Il faut alors utiliser [le package "mfp"](adapt-variable.R) qui va automatiquement chercher la meilleure transformation de la variable.

3. Absence de multicolinéarité :  
- La régression logistique suppose qu’il n’y ait pas de multicolinéarité grave entre les variables explicatives.  
- Quand deux variables explicatives sont fortement corrélées entre elles, elles n’apportent pas d’informations indépendantes au modèle.  
  Exemple : pour prédire la détente verticale d'un joueur de basket, on pourrait regarder la taille du joueur et sa pointure, des variables souvent corrélées.

Comment vérifier cette hypothèse : le moyen le plus courant de détecter la multicolinéarité consiste à utiliser le facteur d’inflation de la variance (VIF). Sur R, utiliser la fonction VIF([...])  
- VIF = 1 : il n'y a aucune corrélation entre les variables explicatives  
- VIF entre 1 et 5 : présence de faible/moyenne corrélation, généralement acceptable  
- VIF > 5 : corrélation potentiellement trop forte pouvant fausser la régression  
[exemple de VIF sur R avec PimaIndiansDiabetes2](VIF_diabete.R).

4. Les observations sont indépendantes :  
Dans une régression logistique, chaque ligne de ton tableau doit représenter une observation totalement indépendante des autres.

Autrement dit :  
- Tu ne dois pas avoir plusieurs lignes qui concernent le même individu (ex. : les résultats de plusieurs jours pour une même personne).  
- Il ne doit pas y avoir de lien logique ou chronologique entre les lignes (comme si une observation dépendait de la précédente).

Le modèle suppose que chaque observation est une “nouvelle information” venue d’un individu ou d’un événement distinct. Si certaines lignes se « répondent » entre elles, cela peut fausser le modèle.

Comment vérifier cette hypothèse :  
La manière la plus simple est de créer [un graphique des résidus](independance.R) en fonction du temps (c’est‑à‑dire de l’ordre des observations) et d’observer s'il existe une tendance ou une autocorrélation.

5. Pas (ou peu) de valeurs aberrantes :  
La régression logistique suppose que les données ne contiennent pas de valeurs très atypiques ou d’observations qui influencent fortement le modèle ; on nomme ces observations des valeurs "aberrantes".

Comment vérifier cette hypothèse :  
Le moyen le plus courant pour détecter les valeurs aberrantes extrêmes et les observations influentes consiste à calculer [la distance de Cook](distance_de_cook.R)  
([pour en savoir plus sur la distance de Cook](https://statorials.org/comment-identifier-les-points-de-donnees-influents-en-utilisant-la-distance-des-cuisiniers/)).

6. La taille de l’échantillon est suffisamment grande :  
La fiabilité d’une régression logistique dépend du nombre d’observations disponibles.

Comment vérifier ?  
Pour chaque variable explicative, on recommande au minimum 10 événements de la modalité la moins fréquente (en gros, au moins 10 occurrences de la modalité la plus rare par variable).

Sur R :  
> pour vérifier le nombre de lignes/observations dans un dataframe : nrow(df)  
> puis effectuer le calcul : (10 * nombre_de_variables_explicatives) / 0.20  
> comparer les deux résultats

## Le modèle final glm()  
Vous pouvez maintenant profiter de votre régression logistique : vous venez de créer un modèle de prédiction (plus ou moins performant). Que faire ensuite ?  
- Repérer les variables significativement associées à la variable cible avec des p‑values inférieures à 0.05 (par défaut on préfère une p‑value < 0.05, mais ce seuil dépend du contexte).  
- Calculer les odds‑ratios et leurs intervalles de confiance pour mesurer l'intensité des associations.  
- Tester le modèle de prédiction que vous venez de créer en utilisant predict().
