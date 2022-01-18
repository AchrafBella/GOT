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

Pour répondre à cette question j'ai écris une fonction mapper: qui renvoie une liste des caracters trier de mot et le mot meme, le but c'est de regrouper les mots similaires. Et un reducer qui reconstitue les mots. 

![image](https://user-images.githubusercontent.com/52492864/149981165-784a18fa-3545-48d7-983f-e592b96fa0c8.png)

J'ai stocké les résultat dans un fichier all_angrammes.txt 

Exemple pour lancer la requête: 
-----------
```python
cat .\words_alpha.txt | python .\anagramme.py > .\all_angrammes.txt
 ```

Partie II : Requête originale et complexe avec map-reduce
-----------
 
Le but de cette requete est de permettre aux décideurs de voir l'argent générer chaque mois ainsi que de savoir le pourcentage de chaque moyenne de paiement. 



![data](https://user-images.githubusercontent.com/52492864/149981942-22370f4c-9d3b-4ebe-a9ca-6b21b06d30ca.PNG)
















