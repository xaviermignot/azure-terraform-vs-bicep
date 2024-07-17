---
layout: section
---

# Introduction

---

# Introduction
De quoi parle-t-on au juste ? <twemoji-thinking-face />

<v-click>

### Deux outils d'Infrastructure-as-Code:

</v-click>
<v-clicks depth="2">

- Bicep <twemoji-mechanical-arm />, un DSL open-source par Microsoft
- Terraform <logos-terraform-icon />, un outil qui a 2 versions
  - La version originale d'HashiCorp en BSL
  - Le fork OpenTofu open-source propulsé par la Fondation Linux

</v-clicks>

<v-click>

### Avec plusieurs points communs

</v-click>
<v-clicks depth="2">

- Mode déclaratif (vs impératif)
- Un workflow similaire: validate, plan/what-if, apply
- Deux syntaxes qui se ressemblent

</v-clicks>

---
clicks: 5
---

# Un exemple de code tout simple

## Avec Bicep <twemoji-mechanical-arm />

```bicep {all|1|2|3-4|6|all}
var myProject = 'my-project'
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-${myProject}'
  location: 'canadaeast'
}
output rgName string = rg.name
```

## Avec Terraform <logos-terraform-icon />

```hcl {all|1|2|3-4|6|all}{at:1}
locals {  my_project = "my-project" }
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.my_project}"
  location = "canadaeast"
}
output "rg_name" { value = azurerm_resource_group.rg.name }
```

---
layout: statement
---

# Ce n'est pas juste une question de multi-cloud <twemoji-winking-face />
