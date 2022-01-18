# Rapport Big Data: TP 2 
-------------------------------------

 
Requirements :  
-----------
Avant de commencer notre TP, il faut assurer l'instalation suivante vu que on va utiliser mrjob et collections et plus précisément counter.  
```python
pip install collections
pip install mrjob
```

Partie I
-----------
 - Dataset
 On ce qui concerne la base de données nous avons des vents avec 6 variables (features) qui sont :
 
date (format YYYY-MM-DD);
heure (format hh:mm);
ville d’achat;
catégorie de l’achat (parmi Book, Men’s Clothing, DVDs…);
somme dépensée par le client;
moyen de paiement (parmi Amex, Cash, MasterCard…).
 
L'information la plus importante ce que il y a des données manquante comme la figure montre qu'il faut gérer, nous avons utiliser gestion des exception (try-catch) pour gérer cette erreur.
 
 

Partie II
-----------
 


Exemple to run: 
-----------
```python
gent1 = HeuristicAgent('hur agent 1', 1)
agent1_ = AgentLeftMost('leftmost agent 2', 2)
env = Env(agents={'agent1': agent1, 'agent2': agent1_})
env.run(rounds=500)
```
 
