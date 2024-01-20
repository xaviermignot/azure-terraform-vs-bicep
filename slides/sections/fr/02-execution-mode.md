---
layout: section
---

# Première différence

<v-clicks>

## Le mode d'exécution
### (Qu'est-ce qui se passe lorsque chaque outil tourne ?)

</v-clicks>

---
layout: section
---

# On commence par une démo !

<!-- 
1. Organisation du repo
2. Lancement en Bicep (avec un déploiement et un scope)  
```
az deployment sub create -n deploy-tf-vs-bicep -l canadaeast -f main.bicep -p location=canadaeast
```
3. Petit parcours du code Bicep, et montrer le déploiement dans le portail (avec le template ARM)
4. Lancement avec Terraform (pas de fichier ni de scope à préciser, ni de déploiement)
5. Petit parcours du code
6. Explication de la différence de comportement
  - Côté Bicep, un seul appel d'API et tout se passe dans Azure
  - Côté Terraform, de multiples appels
-->

---
layout: image
image: execution-mode-bicep.png
---

---
layout: image
image: execution-mode-terraform.png
---

---

# Qu'est-ce que ça change ?

<v-clicks>

## Interaction avec d'autres outils, APIs, ou clouds
### Bicep est "limité" à l'API Azure Resource Manager
## L'organisation du code n'est pas la même
## Tout doit être "calculé" au début du déploiement
### Exemple [ici](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/loops#loop-limits) et [là](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-files#loadjsoncontent)
  
</v-clicks>

<!-- 
Limitation à l'API Resource Manager
- Impossible de créer des blobs
- Impossible de créer des objets dans Azure Ad (App Registrations, groupes, etc.)
- Montrer le deployment script
Organisation du code
- En Bicep, 1 fichier = 1 déploiement
S'il y a du temps, montrer le module isEven (Bicep en priorité)
- Dé-commenter le code dans resources.bicep
- Transformer la variable en output
Expliquer la différence sur les fichiers (non variablilisés en Bicep)
 -->