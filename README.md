# regression-logistique
mise en place d'une régression logistique                                
6 hypothèse à vérifié avant de procéder:                    

1. la variable à expliqué est une variable binaire à deux modalité (ou plus dans certains cas complexe):    
    - simple exemple de variable binaire à expliquer présence d'une maladie 0/1
      
2. la linéarité entre les variables explicatives et la fonction logit de la variable à expliquer:    
  -La régression logistique suppose qu’il existe une relation linéaire entre chaque variable explicative et le logit de la variable de réponse
    Comment vérifier cette hypothèse :    
    Le moyen le plus simple de voir si cette hypothèse est vérifiée est d’utiliser un test de Box-Tidwell.
    
3. absence de multicolinéarité:    
     - 
    
4. les observations sont indépendantes:    

5. pas de valeur aberrante    

6. la taille de l’échantillon est suffisamment grande:    
