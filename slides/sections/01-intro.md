---
layout: section
---

# Intro

---
layout: default
---

# Introduction
What the hell are we talking about ? <twemoji-thinking-face />


<v-click>

Two Infrastructure-as-Code tools:
- Bicep <twemoji-mechanical-arm />, a DSL provided by Microsoft
- Terraform <logos-terraform-icon />, a tool provided by HashiCorp

</v-click>

<v-click>

Why IaC ?
- Benefits of source-control
- Benefits of automation 

</v-click>

<v-click>

Declarative vs imperative
- Describe the expected result
- Describe the expected actions

</v-click>

<!-- 
- What are Bicep & Terraform (IaC, Imperative, ...)
- The similarities (syntax lookalike, commands, ...)
-->

---
layout: default
---

# Two languages with similar syntax...

<div v-click="[1, 3]">

```bicep
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
    name: 'rg-${project}'
  location: location
  tags: union(tags, { module: 'main.bicep' })
}
```

</div>

<div v-click="[2, 3]">

```hcl
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project}"
  location = var.location
  tags     = merge(local.tags, { module = "root" })
}
```
</div>

<div v-click="3">

```bicep
resource plan 'Microsoft.Web/serverfarms@2022-03-01' = {
    name: 'asp-my-app-service-plan'
  location: 'canadaeast'

  kind: 'app,linux'

  sku: {
    name: 'B1'
  }
}

resource app 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-my-app-service'
  location: 'canadaeast'

  properties: {
    serverFarmId: plan.id
  }
}
```
</div>