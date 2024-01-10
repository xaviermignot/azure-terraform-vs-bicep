---
layout: section
---

# Introduction

---

# Introduction
De quoi parle-t-on au juste ? <twemoji-thinking-face />

<v-click>

Deux outils d'Infrastructure-as-Code:
* Bicep <twemoji-mechanical-arm />, un DSL open-source par Microsoft
* Terraform <logos-terraform-icon />, un outil qui a 2 versions
  - La version originale d'HashiCorp en BSL
  - Le fork OpenTofu open-source propulsé par la Fondation Linux

</v-click>

<v-click>

Mais pourquoi fait-on de l'IaC ?
- Pour ce qu'apporte le source-control
- Et aussi l'automatisation

</v-click>

<v-click>

Mode déclaratif ou impératif ?
- Déclaratif: on décrit le résultat attendu
- Impératif: on décrit les actions à réaliser

</v-click>

---
layout: two-cols-header
---

# Un exemple de code tout simple
## D'abord avec Bicep <twemoji-mechanical-arm />

::left::

<v-clicks at="0">

* Déclaration d'une variable locale
* Une ressource avec un type
* Les paramètres de la resource

</v-clicks>

::right::

```bicep {all|1|2|3-4|all} {lines:true, at:0}
var myProject = 'my-project'
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-${myProject}'
  location: 'canadaeast'
}
```

---
layout: two-cols-header
---

# Un exemple de code tout simple
## Maintenant avec Terraform <logos-terraform-icon />

::left::

```hcl {all|1-3|4|5-6|all}
locals {
  my_project = "my-project"
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.my_project}"
  location = "canadaeast"
}
```

::right::

<v-clicks at="0">

* Déclaration d'une variable locale
* Une ressource avec un type
* Les paramètres de la resource

</v-clicks>

---

# Un exemple de code tout simple

## Avec Bicep <twemoji-mechanical-arm />
```bicep {all|1|2|3-4|all} {at:0}
var myProject = 'my-project'
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-${myProject}'
  location: 'canadaeast'
}
```

## Avec Terraform <logos-terraform-icon />
```ts {all|1|2|3-4|all} {at:0}
locals {  my_project = "my-project" }
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.my_project}"
  location = "canadaeast"
}
```

---
layout: statement
---

# Ce n'est pas juste une question de multi-cloud <twemoji-winking-face />

<!-- 
- What are Bicep & Terraform (IaC, Imperative, ...)
- The similarities (syntax lookalike, commands, ...)
-->

