---
layout: two-cols-header
---

# Two languages with similar syntax...
One basic sample

<!-- <div v-click="[1, 3]"> -->

::left::

## Bicep 
```bicep {all|1|2|3-4|all} {at:0} 
var myProject = 'my-project'
resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-${myProject}'
  location: 'canadaeast'
}
```

<!-- </div> -->
::right::
<!-- <div v-click="[2, 3]"> -->

## Terraform
```bicep {all|1-3|4|5-6|all} {at:0}
locals {
    my_project = "my-project"
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-my-resource-group"
  location = "canadaeast"
}
```
<!-- </div> -->

---
layout: two-cols
---

# Test

```js{all|1|2|all} {at:0}
const a = "Highlight me first!"
const b = "then me!"
```

```js{all|1|2|all} {at:0}
const thisVarChanged = "Highlight me first!"
const eyo = "then me!"
```

---
layout: two-cols-header
---

# Two languages with similar syntax...
Let's spice up things a little


::left::

<div v-click="1">

# Bicep

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

::right::

<div v-click="2">

# Terraform

```hcl
resource "azurerm_service_plan" "plan" {
  name                = "asp-my-app-service-plan"
  location            = "canadaeast"
  resource_group_name = "rg-my-resource-group"

  os_type  = "Linux"
  sku_name = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "app-my-app-service"
  location            = "canadaeast"
  resource_group_name = "rg-my-resource-group"

  service_plan_id     = azurerm_service_plan.plan.id
}
```
</div>

