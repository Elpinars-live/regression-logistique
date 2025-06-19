# mise en place d'une régression logistique
> **Intro:** La régression logistique est une méthode de classification supervisée utilisée pour prédire la probabilité qu’un événement binaire se produise.    
>
**l’objectif:** d’une régression logistique est de modéliser la probabilité d’occurrence d’un événement binaire (par exemple : succès/échec, présence maladie/pas malade) en fonction d’un ensemble de variables explicatives. Elle permet ainsi de prédire la classe la plus probable pour une observation, tout en estimant l’influence de chaque variable.
## 6 hypothèses à vérifié avant de procéder :

1. La variable à expliqué est une variable binaire à deux modalités (ou plus dans certains cas complexe):    
- simple exemple de variable binaire à expliquer : la présence d'une maladie 0/1, succès/échec (examen, concours, compétition...)
      
2. La linéarité entre les variables explicatives et la fonction logit de la variable à expliquer :    
- La régression logistique suppose qu’il existe une relation linéaire entre chaque variable explicative et le logit de la variable de réponse.    
**Comment vérifier cette hypothèse :**    
Le moyen le plus simple de voir si cette hypothèse est vérifiée est d’utiliser un test de [Box-Tidwell](méthode_box-tidwell_diabete.Rmd).
    
3. Absence de multicolinéarité:     
- La régression logistique suppose qu’il n’y a pas de multicolinéarité grave entre les variables explicatives:
- quand deux variables explicatives sont fortement corrélées les unes aux autres, elles ne fournissent pas d’informations uniques ou indépendantes dans le modèle de régression.      
*exemple : on veux prédire la détente verticale d'un joueur de basket on va regarder des variables explicatives comme la taille du jouer et la pointure, des variables souvent corrélées*    
**Comment vérifier cette hypothèse :** le moyen le plus courant de détecter la multicolinéarité consiste à utiliser le facteur d’inflation de la variance (VIF), sur R utiliser la fonction VIF(modèle) avec un modèle glm():
    - VIF = 1 Il n'y a aucune corrélation entre les variables explicatives
    - VIF = 1 à 5 on détecte la présence de faible/moyenne corélation, mais cela reste acceptable
    - VIF > 5 indique la présence de corrélation potentiellement trop forte et peux fausser la regression
   
5. Les observations sont indépendantes:    

6. Pas de valeur aberrante    

7. La taille de l’échantillon est suffisamment grande:    
