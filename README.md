# Rapport SPARQL 
--------------------

Sujet : Nobel prizes
-----------

Durant ce TP nous allons interroger la base de données des Nobel prises utilisant SPARQL et pour cela nous allons utiliser le point d'accès suivant : 
https://data.nobelprize.org/sparql

Avant de faire toute requete il faut intéroger la base de données pour savoir les triplets pour cela nous avons utlisé le code suivant : 

```SPARQL
Select ?url ?predicat ?value
Where{
 ?url ?predicat ?value. 
}
```

![Triplets](https://user-images.githubusercontent.com/52492864/145552801-2da996e7-b934-4db3-910b-bb7c0971e253.PNG)


## Requête 1 :
------------------
Pour la première requête en s'interesse de savoir les lauréats qu'on reste active dans le domaine de la recherche durant la période de COVID (2019-2021) et plus précisément les femmes.
Pour répondre à cette question nous avons utilisé la requête suivante :

```SPARQL
PREFIX nobel: <http://data.nobelprize.org/terms/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

SELECT DISTINCT ?url ?name ?gender ?prize ?prize_name ?year ?category
WHERE{
  ?url rdf:type nobel:Laureate.
  ?url foaf:name ?name.
  ?url foaf:gender ?gender.
  ?url nobel:nobelPrize ?prize.
  ?prize rdfs:label ?prize_name.
  ?prize nobel:year ?year.
  ?prize nobel:category ?category.
  filter(?gender = 'female' && ?year >2019)
}
```

Les résultats sont affichées ci-dessus : 

![requete1](https://user-images.githubusercontent.com/52492864/145575887-9d9ec916-ee3d-4091-8faf-1a9f17d71bb7.PNG)

Le RDF est le suivant : 

![requete1 rdf](https://user-images.githubusercontent.com/52492864/145578081-524d0f2c-ab53-40cf-9a10-ed406261a37e.PNG)

## Requête 2 :
------------------
