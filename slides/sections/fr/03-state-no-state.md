---
layout: section
---

# Seconde différence
<v-click>

## State ou pas de state ?

</v-click>

---

# Qu'est-ce que le state ?

<v-clicks>

## Un aspect spécifique à <logos-terraform-icon />

## Un fichier JSON avec toute notre infra
### En local par défaut <twemoji-house />...
### ... mais il faut le mutualiser <twemoji-handshake />...
### ... et le sécuriser <twemoji-face-screaming-in-fear />

## A quoi sert le state ?
### A éviter les collisions <twemoji-vertical-traffic-light />
### Lier la configuration à l'infrastructure
### Stocker des meta-data comme les dépendances...
### ...et d'autres trucs qui ne sont pas des ressources <twemoji-game-die />

</v-clicks>

---
layout: section
---

# On retourne dans le portail !

<!-- 
Tests à faire
- Dé-commenter le "some-container" et re-déployer
  - Re-commenter le "some-container" et déployer à nouveau
- Changer le nom logique d'une ressource (le rg)
  - What-if en Bicep: pas de changement
  - Apply en tf: suppression du rg (il faut utiliser le bloc moved)
- Créer un container "test" à la main et faire un apply en tf
  - Importer le container avec tf import 'module.static_website.azurerm_storage_container.test' et l'id dans l'erreur
- Tout renommer
  - Terraform: tf apply -var project=nouveau-nom (il supprime et re-créé tout)
  - Bicep: changer la variable project dans le main.bicep (il duplique à côté)
- Tout déployer dans Canada Central
  - Terraform: tf apply -var location=canadacentral (propose de tout recréer)
  - Bicep az deployment sub create -n deploy-tf-vs-bicep -l canadaeast -f main.bicep -p location=canadacentral (renvoie une erreur)
 -->

---
layout: image
image: no-state.png
---

---

# Et là, qu'est-ce que ça change ?

<v-clicks>

## Possibilité de supprimer des ressources

## Attention aux changements hors IaC <twemoji-warning />  
### qui ne viennent par forcément du portail <twemoji-face-with-monocle />

## Moins facile de faire du refactoring

## On peut y stocker autre chose que des ressources Azure

</v-clicks>

<!-- 
Changements hors IaC
- Exemple des App Services avec le certificat dans le KV
 -->