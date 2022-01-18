# Rapport Big Data: TP 2 
-------------------------------------

 
Requirements :  
-----------
Avant de commencer notre TP, il faut assurer l'instalation suivante vu que on va utiliser mrjob et collections et plus précisément counter.  
```python
pip install collections
pip install mrjob
```

Partie I : 5 Questions sur les ventes
-----------
 - Dataset
 
On ce qui concerne la base de données nous avons des données sur les vents avec 6 variables (features).
 
L'information la plus importante ce qu'il y a des données manquantes comme la figure montre, il faut les gérer, pour cela nous avons utilisé gestion des exceptions (Try-catch) pour gérer cette erreur.
 
![image](https://user-images.githubusercontent.com/52492864/149978705-7297f02b-885f-454b-8817-d4d8b459cfee.png)

J'ai pris une subset de données que j'ai appelé minipurchases.txt. 

Exemple pour lancer la requête: 
-----------
```python
cat .\minipurchases.txt | python .\Q1_PurchasesByCategory.py
 ```
 
Partie I : Angramme avec map-reduce
-----------





Partie II : Requête originale et complexe avec map-reduce
-----------
 


