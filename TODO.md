# Terraform Modules - TODO & Modernization Plan

**Last Updated**: 2026-06-09

---

## ✅ Completed Items

### 2026-06-09

#### Container Registry Module
- ✅ Restructured README: title + `## Summary` + "How to use it?" moved outside the `BEGIN_TF_DOCS` markers (previously inside; would be wiped on regen)
- ✅ Renamed `output.tf` → `outputs.tf` for cross-module consistency; added `workload` output
- ✅ Consolidated scattered `public_network_access_enabled` + `trusted_services_bypass_firewall_enabled` into a cohesive `firewall_settings` object — **custom 2-field shape** (no `allowed_subnet_ids` because Azure deprecated VNet rules for ACR and the azurerm provider no longer exposes them)
- ✅ Integrated `private_endpoint` module via consolidated `private_endpoint_settings` (subresource `registry`); service-bus-style **Premium-only** SKU gating — Premium can have PEP optionally; Basic/Standard must have `private_endpoint_settings = null`. Enforced via plan-time precondition. PEP module ref `f41a116c9f31892191b5e3f146a1e361bfc57322`

**Design Decisions**:
- ℹ️ `firewall_settings` uses a **custom 2-field shape** rather than the standard 3-field shape. The standard pattern's `allowed_subnet_ids` is omitted because ACR no longer supports VNet rules at the Azure level. Documented in the variable description for future readers.

#### App Configuration Module
- ✅ Integrated `private_endpoint` module via consolidated `private_endpoint_settings` (subresource `configurationStores`); PEP module ref `f41a116c9f31892191b5e3f146a1e361bfc57322`
- ✅ Service-bus-style SKU↔PEP gating: Standard/Premium **must** supply `private_endpoint_settings`; Free/Developer **must not** (PEP unsupported on those tiers). Enforced via two plan-time preconditions.
- ✅ README prose updated to explain the SKU gating; one new example for Standard with PEP, one for Standard with PEP + public access; TF_DOCS regenerated

**Design Decisions**:
- ℹ️ `location` omitted from name — app-scoped tier convention (consistent with KV, storage, service_bus, app_insights)
- ℹ️ `firewall_settings` consolidation **not applicable** — only `public_network_access_enabled` exposed today; wrapping a single bool adds nesting without value. IP-based filtering on higher tiers would be a new feature, not a consolidation refactor.

#### Naming Tier Convention (doc fix)
- ✅ Corrected the convention table to reflect that **app-scoped** modules omit `location` from the name (KV, storage, service_bus, app_insights, app_configuration). Earlier draft incorrectly claimed location appears in every tier.

#### Redis Cache Module
- ✅ Integrated `private_endpoint` module (subresource `redisCache`) via the consolidated `private_endpoint_settings` pattern; PEP module ref `f41a116c9f31892191b5e3f146a1e361bfc57322`
- ✅ Restructured README: title + Summary moved above `BEGIN_TF_DOCS`; "How to use it?" section moved below `END_TF_DOCS` (was previously inside the markers and would be wiped on regen)
- ✅ All examples updated to include `private_endpoint_settings`
- ✅ Made `sequence_number` optional (default `null`) — aligns to the [Naming Tier Convention](#naming-tier-convention) for data-tier modules; added `sequence_suffix` local; `-NNN` suffix appended only when non-null
- ✅ Naming precondition relaxed to no longer require `sequence_number`
- ✅ Canonical examples dropped explicit `sequence_number = N`; intro adds the data-tier power-user note

**Design Decision**:
- ℹ️ `firewall_settings` consolidation **not applicable** for redis_cache. The module exposes only `public_network_access_enabled` (single bool, already top-level); wrapping it in a `firewall_settings` object adds nesting without value. The IP-based `azurerm_redis_firewall_rule` resource is not exposed today and would be a new feature, not a consolidation refactor.

### 2026-06-08

#### SQL Server Module
- ✅ Consolidated PEP wiring: dropped `network_settings` + `private_dns_zone_ids` in favour of `private_endpoint_settings` (typed object, required, no default)
- ✅ Switched `firewall_settings.allowed_subnets` (triple object + `data.azurerm_subnet` lookup) to `allowed_subnet_ids` (list of full subnet resource IDs); dropped the data lookup
- ✅ Bumped PEP module ref to `f41a116c9f31892191b5e3f146a1e361bfc57322` (PEP module now accepts `subnet_id` directly)
- ✅ Composite `<vnet>/<subnet>` `for_each` key for VNet rules → collision-proof by construction (no precondition needed) and readable state addresses
- ✅ Regex-based ID parsing in `local.tf` (`parsed_allowed_subnets` + `vnet_rules`) — self-documenting, fail-fast on malformed IDs
- ✅ Declared `azuread` provider in `required_providers` (closes tflint `terraform_required_providers` warning)
- ✅ Made `sequence_number` optional (default `null`) — aligns to the new [Naming Tier Convention](#naming-tier-convention) for data-tier modules; `-NNN` suffix is only appended when non-null
- ✅ Naming precondition relaxed to no longer require `sequence_number`
- ✅ README examples refreshed to new variable shape; `BEGIN_TF_DOCS` block regenerated

### 2026-06-02

#### Service Bus Module
- ✅ Added `override_name` variable (nullable, trimspace validation)
- ✅ Added `company_prefix` variable (nullable, 1-5 chars)
- ✅ Made `workload` nullable with non-empty validation
- ✅ Renamed resource from `service_bus` to `main` for naming convention compliance
- ✅ Removed hardcoded `"nmbrs"` prefix from naming (now sourced from `company_prefix`)
- ✅ Wired `local.service_bus_name` into `main.tf` (the local was defined but unused — latent bug)
- ✅ Added lifecycle precondition for naming validation (`override_name OR (workload + company_prefix)`)
- ✅ Updated all output references to use new resource name
- ✅ Restructured README — manual content (title, summary, "How to use it?") moved outside the `BEGIN_TF_DOCS`/`END_TF_DOCS` markers, protecting it from terraform-docs regeneration
- ✅ Integrated `private_endpoint` module (subresource `namespace`) via the new pattern: `network_settings` + `private_dns_zone_ids` inputs, `local.private_endpoint_subresources`, generic `private_endpoint.tf`
- ✅ Module now fully compliant (5/5) with application_gateway reference standard

**Design Decision**:
- ℹ️ No `sequence_number` by design — matches the kv/storage/app_configuration pattern for singleton-per-workload public-facing resources. Uniqueness comes from `company_prefix + workload + env`.

### 2025-12-09

#### SQL Server Module
- ✅ Renamed resource from "sql_server" to "main" for naming convention compliance
- ✅ Added missing network_settings variable definition
- ✅ Renamed instance_count to sequence_number for standardization
- ✅ Added lifecycle preconditions for naming validation
- ✅ Made auditing_settings nullable with conditional validation (prod/sand/stage)
- ✅ Implemented single source of truth for audited environments
- ✅ Removed environment validation (matches reference standard)
- ✅ Updated all output references to use new resource name
- ✅ Module now fully compliant (5/5) with application_gateway reference standard

#### SQL Database Module
- ✅ Renamed resource from "sql_database" to "main" for naming convention compliance
- ✅ Renamed instance_count to sequence_number for standardization
- ✅ Added company_prefix variable for naming consistency
- ✅ Made workload nullable with proper validation
- ✅ Added lifecycle precondition for naming validation
- ✅ Updated naming pattern to include company_prefix: `sqldb-{company}-{workload}-{env}-{location}-{seq}`
- ✅ Made elastic_pool_settings nullable (optional)
- ✅ Cleaned up empty string checks throughout module
- ✅ Updated all output references to use new resource name
- ✅ Module now fully compliant (5/5) with application_gateway reference standard

#### SQL Database Module (improvements 2026-03-18)
- ✅ Added `override_name` trimspace validation (was missing)
- ✅ Added field-level validation to `sql_server_settings` (name + resource_group_name must be non-empty)
- ✅ Fixed bug: `elastic_pool_settings` data source was silently using `sql_server_settings.resource_group_name` — now correctly uses `elastic_pool_settings.resource_group_name`
- ✅ Refactored backup settings in local.tf: replaced interpolated numeric fields with direct ISO 8601 strings (`"P1M"`, `"P1Y"`, `"P7Y"`)
- ✅ Renamed `output.tf` → `outputs.tf` for consistency
- ✅ Standardized output names: `sql_database_name/id/collation` → `name/workload/id/collation`
- ✅ Cleaned up README examples: removed inline comment groups, redundant null defaults, aligned with module reference style

#### Container Registry Module
- ✅ Created new module from scratch following all standards
- ✅ Implemented flexible naming with override support
- ✅ Added SKU-based conditional logic for network access
- ✅ Naming pattern: `cr{company}{workload}{env}` (no sequence_number by design)
- ✅ Comprehensive validations with format() error messages
- ✅ Main resource named "main"
- ✅ Lifecycle precondition for naming validation
- ✅ Module fully compliant (5/5) from inception

### 2025-12-03

#### Redis Cache Module
- ✅ Renamed main resource from "redis" to "main" for naming convention compliance
- ✅ Added lifecycle precondition for naming validation (override_name OR naming components)
- ✅ Updated all output references to use new resource name
- ✅ Module now fully compliant (5/5) with application_gateway reference standard

#### Virtual Machine Module
- ✅ Added naming validation precondition to linux_vm resource
- ✅ Added naming validation precondition to windows_vm resource
- ✅ Documented as compliant for VM pattern (no company_prefix by design)
- ✅ Resource naming (linux_vm/windows_vm) deemed appropriate for conditional resources
- ✅ Module now fully compliant (5/5) for VM-specific pattern

#### Storage Account Module
- ✅ Made company_prefix nullable (removed default "nmbrs")
- ✅ Added naming validation precondition (without sequence_number)
- ✅ Documented design decision: no sequence_number, relies on company_prefix + workload + env
- ✅ Naming pattern: `st{company}{workload}{env}` (no dashes)
- ✅ Module now fully compliant (5/5) with application_gateway reference standard

#### Key Vault Module
- ✅ Made company_prefix nullable (removed default "nmbrs")
- ✅ Added naming validation precondition (without sequence_number)
- ✅ Documented design decision: no sequence_number, relies on company_prefix + workload + env
- ✅ Naming pattern: `kv-{company}-{workload}-{env}` (with dashes)
- ✅ Module now fully compliant (5/5) with application_gateway reference standard

### 2025-11-19

### Application Gateway Module
- ✅ Fixed type error in health probe configuration (removed `title()` from port)
- ✅ Fixed invalid default application settings (rewrite_rules structure)
- ✅ Added diagnostic_settings to all README examples
- ✅ Added rewrite_rules to all backend examples in README
- ✅ Added naming validation precondition to prevent null naming errors

### Resource Group Module
- ✅ Added override naming logic
- ✅ Enhanced variable validations
- ✅ Made tags truly optional (nullable)
- ✅ Renamed main resource to follow `main` convention
- ✅ Added comprehensive README documentation with multiple examples

---

## 🎯 Module Modernization Standards

### Reference Models
- **application_gateway**: Complete reference standard (public-facing resources)
- **log_analytics_workspace**: Best-aligned module (5/5 criteria) ✓✓✓
- **nat_gateway**: Best-aligned module (5/5 criteria) ✓✓✓
- **resource_group**: Internal resources pattern (no company_prefix/sequence_number)

### Standard Criteria (5 Points)
1. ✅ **override_name variable** - Nullable with validation
2. ✅ **Comprehensive validations** - Environment, location, format() error messages
3. ✅ **Main resource named "main"** - Convention compliance
4. ✅ **local.tf with naming logic** - Override support with ternary operator
5. ✅ **Lifecycle precondition** - Naming validation (override_name OR components)

### Standard Variables Pattern
```hcl
variable "override_name"     # Optional override (nullable, non-empty validation)
variable "company_prefix"    # 1-5 chars, nullable (for public-facing)
variable "sequence_number"   # 1-999 — required/optional/absent depending on tier; see Naming Tier Convention
variable "workload"          # Workload name, nullable
variable "environment"       # dev, test, prod, sand, stag (non-nullable)
variable "location"          # Non-empty string (non-nullable)
variable "resource_group_name" # RG reference (non-nullable)
```

### Naming Tier Convention

Modules fall into three tiers based on how callers deploy them. The tier determines whether `sequence_number` is **required**, **optional**, or **absent** from the module's interface and naming logic.

| Tier | Resource examples | Name shape | `location` in name? | `sequence_number` |
|---|---|---|---|---|
| **App-scoped** | `key_vault`, `storage_account`, `app_configuration`, `app_insights`, `service_bus`, `container_registry` | `<short>-<company>-<workload>-<env>` (`container_registry` omits separators: `cr<company><workload><env>` due to ACR alphanumeric-only naming) | **No** | **Absent** |
| **Data tier** | `sql_server`, `redis_cache`, `cosmos_db` | `<short>-<company>-<workload>-<env>-<location>[-NNN]` | Yes | **Optional** (default `null`, suffix when non-null) |
| **Network** | `virtual_network`, `subnet`, `peering`, NSG | `<short>-<company>-<workload>-<env>-<location>-NNN` | Yes | **Required** |

**Rationale**:
- **App-scoped**: one-per-(workload, env) in practice; `company_prefix + workload + env` is already unique on globally-named DNS resources (KV/SB FQDN, storage endpoint, App Configuration). Adding `location` would be redundant info — the convention at Nmbrs has historically omitted it for KV, storage, service_bus, and app_configuration.
- **Data tier**: usually singletons too, but legitimate multi-instance cases exist. `location` belongs in the name because geo-replication produces a separate named resource per region (SQL failover groups, Redis geo-pairs); for Cosmos DB the account is global, but `location` reflects the home/write region and remains a useful tiebreaker for multi-account setups (data residency). `sequence_number` is a "power-user" knob for sharding / blue-green migrations.
- **Network**: multi-instance by design (hub/spoke, segmentation, multi-region). Both `location` and `sequence_number` are required for disambiguation.

**Optional-`sequence_number` shape (data tier)**:
```hcl
# variables.tf
variable "sequence_number" {
  description = "Optional numeric instance counter, zero-padded as `-NNN` suffix. Use only when provisioning multiple instances for the same workload/env/region (e.g., sharding). Omit for the common single-instance case."
  type        = number
  default     = null
  nullable    = true

  validation {
    condition     = var.sequence_number == null || try(var.sequence_number >= 1 && var.sequence_number <= 999, false)
    error_message = format("Invalid value '%s' for variable 'sequence_number', it must be null or a number between 1 and 999.", coalesce(var.sequence_number, "null"))
  }
}

# local.tf
locals {
  sequence_suffix = var.sequence_number == null ? "" : "-${format("%03d", var.sequence_number)}"
  resource_name = (
    var.override_name != null ?
    lower(var.override_name) :
    lower("<short>-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}${local.sequence_suffix}")
  )
}
```

**Precondition adjustment**: when `sequence_number` is optional (data tier) or absent (app-scoped), drop it from the naming precondition's required list:
```hcl
precondition {
  condition = var.override_name != null || (
    var.workload != null &&
    var.company_prefix != null
  )
  error_message = "Invalid naming configuration: Either 'override_name' must be provided, or both 'workload' and 'company_prefix' must be provided for automatic naming."
}
```

**Modules to align**:
- ✅ `sql_server` — optional `sequence_number` (2026-06-08)
- ✅ `redis_cache` — optional `sequence_number` (2026-06-09)
- [ ] `cosmos_db` — apply the data-tier optional-`sequence_number` shape (note: Cosmos `location` reflects home/write region)
- [ ] Audit app-scoped modules to confirm they never expose `sequence_number`
- [ ] Audit network modules to confirm they keep `sequence_number` required

### Validation Pattern (from application_gateway)
```hcl
validation {
  condition     = var.override_name == null || try(length(trimspace(var.override_name)) > 0, false)
  error_message = format("Invalid value '%s' for variable 'override_name', it must be null or a non-empty string.", coalesce(var.override_name, "null"))
}
```

### Naming Logic Pattern (from application_gateway)
```hcl
locals {
  # Format: agw-{company}-{workload}-{env}-{location}-{seq}
  resource_name = (var.override_name != null ?
    lower(var.override_name) :
    lower("agw-${var.company_prefix}-${var.workload}-${var.environment}-${var.location}-${format("%03d", var.sequence_number)}")
  )
}
```

### Lifecycle Precondition Pattern (from application_gateway)
```hcl
lifecycle {
  precondition {
    condition = var.override_name != null || (
      var.workload != null &&
      var.company_prefix != null &&
      var.sequence_number != null
    )
    error_message = "Invalid naming configuration: Either 'override_name' must be provided, or all of 'workload', 'company_prefix', and 'sequence_number' must be provided for automatic naming."
  }
}
```

### firewall_settings Pattern (consolidated firewall configuration)

Public-facing resources that expose firewall/network-access controls should consolidate them into a single `firewall_settings` object instead of scattering them as top-level variables. This grouping clarifies intent (all firewall concerns live together), enables cohesive cross-field validation, gives a stable extension point as Azure adds new firewall capabilities, and lets the module evolve via additional fields without breaking existing callers.

**Reference implementation**: `service_bus` (post-2026-06)

**Standard shape (copy-paste across modules — description is intentionally resource-agnostic)**:
```hcl
variable "firewall_settings" {
  description = "Firewall configuration: public access, trusted-service bypass, and allowed subnets for VNet rules. All fields are optional and default to a secure-by-default posture (no public access, no allowed subnets, trusted-service bypass enabled)."
  type = object({
    public_network_access_enabled            = optional(bool, false)
    trusted_services_bypass_firewall_enabled = optional(bool, true)
    allowed_subnet_ids                       = optional(list(string), [])
  })
  default = {}

  validation {
    condition     = var.firewall_settings.public_network_access_enabled || length(var.firewall_settings.allowed_subnet_ids) == 0
    error_message = "Invalid 'firewall_settings': 'allowed_subnet_ids' can only be specified when 'public_network_access_enabled' is true."
  }

  validation {
    condition     = alltrue([for id in var.firewall_settings.allowed_subnet_ids : length(trimspace(id)) > 0])
    error_message = "Invalid value in 'firewall_settings.allowed_subnet_ids': all subnet IDs must be non-empty strings."
  }

  validation {
    condition     = length(var.firewall_settings.allowed_subnet_ids) == length(distinct(var.firewall_settings.allowed_subnet_ids))
    error_message = "Invalid value in 'firewall_settings.allowed_subnet_ids': subnet IDs must be unique across all entries."
  }
}
```

**Design notes**:
- `allowed_subnet_ids` is a `list(string)` of full Azure subnet resource IDs (callers pass IDs directly; the module no longer does subnet lookups). Consistent with the "pass IDs, not lookup triples" pattern used by `private_endpoint_settings`, `admin_settings`, and the PEP module's `resource_id`.
- `optional()` per field is intentional even when the variable is always populated downstream: it enables forward compatibility — new fields can be added later without breaking existing callers.
- Module-specific constraints (e.g., service_bus's "VNet rules require Premium SKU") live as **preconditions on the resource in `main.tf`**, not in the variable description, so the variable definition remains universally copy-pasteable.

**Secure-by-default principle**:
- `public_network_access_enabled` defaults to `false` (PEP-only by default)
- `trusted_services_bypass_firewall_enabled` defaults to `true` (allows trusted Microsoft services)
- `allowed_subnet_ids` defaults to `[]` (no VNet rules)

**Modules to migrate to this pattern**:
- [ ] `key_vault` — currently has scattered top-level `public_network_access_enabled` and `trusted_services_bypass_firewall_enabled`. Migration is a cohesion refactor; may also add `allowed_subnet_ids` support (kv has `network_acls.virtual_network_subnet_ids`)
- [ ] `storage_account` — same shape as kv today (scattered top-level). Migration also a cohesion refactor; may also add `allowed_subnet_ids` (storage has `network_rules.virtual_network_subnet_ids`)
- ✅ `sql_server` — migrated `allowed_subnets` triple → `allowed_subnet_ids = list(string)`; dropped `data.azurerm_subnet` lookup (2026-06-08)
- ℹ️ `redis_cache` — **not applicable**. Module exposes only `public_network_access_enabled` (single bool, already top-level); wrapping in `firewall_settings` adds nesting without value. IP-based `azurerm_redis_firewall_rule` is not exposed today; adding it would be a new feature, not a consolidation refactor.

### private_endpoint_settings Pattern (consolidated PEP wiring)

Modules that always provision private endpoints should consolidate the PEP subnet and DNS zone wiring into a single `private_endpoint_settings` object instead of two separate top-level variables (`network_settings` + `private_dns_zone_ids`). This makes the purpose explicit (these fields specifically configure the PEP, not the resource's own networking like app_gateway's delegated subnet or app_service's VNet integration), frees up `network_settings` for module-specific network concerns, and follows the same cohesive-object pattern as `firewall_settings`, `admin_settings`, etc.

**Reference implementation**: `service_bus` (post-2026-06)

**Standard shape**:
```hcl
variable "private_endpoint_settings" {
  description = "Settings for the private endpoint provisioned by this module. `subnet_id` is the resource ID of the subnet where the PEP NIC lands. `private_dns_zone_ids` maps each required subresource to its private DNS zone resource ID."
  type = object({
    subnet_id = string
    private_dns_zone_ids = object({
      # Module-specific: declares exactly the subresources this module provisions PEPs for.
      # Examples:
      #   key_vault:       vault = string
      #   service_bus:     namespace = string
      #   sql_server:      sqlServer = string
      #   storage_account: blob = string, table = string, file = string, queue = string
    })
  })
  # No default — variable is required; PEP is mandatory in this codebase
}
```

**Design notes**:
- Variable is **required, not optional** — PEP is the default expected behavior in this codebase; there is no "no PEP" mode.
- `subnet_id` and `private_dns_zone_ids` are **plain required fields**, not `optional()` — no sensible defaults exist for environment-specific resource IDs.
- `private_dns_zone_ids` is a **typed `object({...})` with explicit per-subresource keys**, not `map(string)`. This gives type-system enforcement of completeness and key-validity, IDE autocomplete, and self-documenting required keys. Use `map(string)` would lose all three properties without compensating benefit.
- The `subnet_id` direct-input approach drops the `data.azurerm_subnet` lookup inside the consuming module **and** inside the PEP module itself (the PEP module's own `network_settings` triple is being replaced with a direct `subnet_id` input).

**Cascade into the PEP module**:
This pattern cannot be adopted in a consuming module without also refactoring `azure/private_endpoint`:
- PEP module's `network_settings = object({subnet_name, vnet_name, vnet_resource_group_name})` → `subnet_id = string`
- Drop the PEP module's `data.azurerm_subnet.subnet` block
- PEP module passes `subnet_id` directly to `azurerm_private_endpoint.subnet_id`

**Modules to migrate to this pattern**:
- ✅ `azure/private_endpoint` — refactored to accept `subnet_id` directly (commit `f41a116c…`, 2026-06)
- [ ] `key_vault` — replace `network_settings` + `private_dns_zone_ids` with `private_endpoint_settings`
- [ ] `storage_account` — same migration
- ✅ `sql_server` — `network_settings` + `private_dns_zone_ids` → `private_endpoint_settings` (2026-06-08)
- ✅ `redis_cache` — initial PEP integration via `private_endpoint_settings` (2026-06-09)
- ✅ `app_configuration` — initial PEP integration via `private_endpoint_settings` (service-bus-style SKU gating, 2026-06-09)
- ✅ `container_registry` — initial PEP integration via `private_endpoint_settings` (Premium-only SKU gating, 2026-06-09)
- ✅ `service_bus` — already on the consolidated pattern (Premium-tier-only, 2026-06)

---

## 📊 CURRENT STATE SUMMARY

**Total Modules Evaluated**: 29 (4 modules removed, 9 modules completed, 1 new module created)

### By Priority:
- 🔴 **HIGH** (Score 0-1/5): 11 modules - Require major modernization
- 🟡 **MEDIUM** (Score 2-3/5): 4 modules - Require moderate updates
- 🟢 **LOW** (Score 4-5/5): 14 modules - Minor tweaks or fully compliant

### Fully Compliant Modules (5/5):
1. ✅ **log_analytics_workspace** - Perfect compliance
2. ✅ **nat_gateway** - Perfect compliance
3. ✅ **redis_cache** - Perfect compliance (2025-12-03)
4. ✅ **virtual_machine** - Compliant for VM pattern (2025-12-03)
5. ✅ **storage_account** - Perfect compliance (2025-12-03)
6. ✅ **key_vault** - Perfect compliance (2025-12-03)
7. ✅ **sql_server** - Perfect compliance (2025-12-09)
8. ✅ **sql_database** - Perfect compliance (2025-12-09)
9. ✅ **container_registry** - Perfect compliance (2025-12-09)
10. ✅ **vpn_gateway** - Perfect compliance (2026-03-16)
11. ✅ **app_configuration** - Perfect compliance (2026-03-16)
12. ✅ **resource_group** - Compliant for internal resource pattern (no company_prefix/sequence_number by design)
13. ✅ **application_insights** - Perfect compliance (2026-03-16)
14. ✅ **service_bus** - Perfect compliance (2026-06-02)

---

## 🚨 CRITICAL ISSUES - STANDARDIZATION NEEDED

### Non-Standard Variable Names:
These modules use inconsistent naming that should be standardized to `sequence_number`:

1. **`instance_count`** (2 modules):
   - cosmos_db
   - document_intelligence

2. **`naming_count`** (2 modules):
   - private_dns_resolver
   - virtual_network

3. **`node_number`** (1 module):
   - app_service

**Action Required**: Rename all to `sequence_number` with 1-999 validation for consistency.

### Hardcoded "nmbrs" Company Prefix:
These modules have hardcoded "nmbrs" that should be made flexible:

- **Hardcoded** (2 modules): event_grid_domain, event_hub
- **Default value** (3 modules): app_configuration, key_vault, storage_account

**Action Required**: Make company_prefix nullable without defaults.

### Scattered firewall variables (should be consolidated into `firewall_settings`):
These modules expose firewall/network-access controls as scattered top-level variables. The cohesive `firewall_settings` object pattern (established in `sql_server` and `service_bus`) should be adopted for consistency:

- **key_vault**: `public_network_access_enabled`, `trusted_services_bypass_firewall_enabled` (currently top-level scalars)
- **storage_account**: `public_network_access_enabled`, `trusted_services_bypass_firewall_enabled` (currently top-level scalars)

**Modules to evaluate** (may also have firewall concerns worth consolidating):
- event_hub
- event_grid_domain
- cosmos_db

**Evaluated and adopted (custom shape)**:
- ✅ `container_registry` (2026-06-09) — adopted a **custom 2-field shape**: `firewall_settings = object({ public_network_access_enabled, trusted_services_bypass_firewall_enabled })`. The standard pattern's `allowed_subnet_ids` is omitted because Azure deprecated VNet rules for ACR and the azurerm provider no longer exposes them. Documented in the variable description.

**Evaluated and dismissed**:
- ℹ️ `redis_cache` (2026-06-09) — only firewall knob exposed is `public_network_access_enabled` (single top-level bool); wrapping in `firewall_settings` adds nesting without value. IP-based `azurerm_redis_firewall_rule` is a new feature, not a consolidation refactor.
- ℹ️ `app_configuration` (2026-06-09) — same as redis_cache; only `public_network_access_enabled` is exposed. IP-based filtering on Standard/Premium would be a new feature, not a consolidation refactor.

**Action Required**: Refactor scattered top-level firewall variables into a `firewall_settings` object matching the sql_server/service_bus shape. **Breaking change for callers** — best scheduled with other module modernization work for those modules.

---

## 🔴 HIGH PRIORITY - Major Modernization Required (Score 0-1/5)

### 1. App Service Module (0/5) ⚠️
**Path**: `azure/app_service/`
**Current State**:
- ❌ No override_name
- ❌ Uses `node_number` instead of `sequence_number`
- ❌ Main resources: "service_plan" and "web_app"
- ⚠️ Has local.tf but no override logic

**Action Items**:
- [ ] Add `override_name` variable (nullable)
- [ ] Rename `node_number` to `sequence_number`
- [ ] Add `company_prefix` variable (nullable, 1-5 chars)
- [ ] Add comprehensive validations (format() messages)
- [ ] Update local.tf with override naming logic
- [ ] Consider renaming to "main" resource
- [ ] Add lifecycle precondition for naming validation

**Estimated Effort**: 3-4 hours

---

### 2. Application Insights Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/application_insights/`
**Current State**:
- ✅ override_name variable with nullable validation
- ✅ workload made nullable with validation
- ✅ Main resource named "main"
- ✅ Comprehensive validations with format() error messages
- ✅ local.tf with override ternary naming logic
- ✅ Lifecycle precondition for naming validation
- ✅ workspace_settings object variable (consolidates workspace_name + workspace_resource_group_name)
- ✅ data.tf with data source extracted
- ✅ outputs.tf (name, workload, id, app_id, instrumentation_key, connection_string)

**Design Decision**:
- ℹ️ No company_prefix by design — internal resource scoped to resource group, no global uniqueness required
- ℹ️ No sequence_number by design — workload + env provides sufficient uniqueness

**Bug fixes**:
- ✅ Removed dead `sku_name` variable (no corresponding argument on azurerm_application_insights)
- ✅ Fixed `application_type` validation typo: `NoNode.JS` → `Node.JS`
- ✅ Fixed `retention_in_days` validation: added missing value `365`
- ✅ Fixed `id` output: was returning `app_id`, now correctly returns ARM resource ID

---

### 3. CDN Front Door Module (0/5) ⚠️
**Path**: `azure/cdn_frontdoor/`
**Current State**:
- ❌ No override_name
- ❌ No location variable at all
- ❌ Main resource: "profile"
- ⚠️ Has validations but incomplete

**Action Items**:
- [ ] Add `override_name` variable (nullable)
- [ ] Add `location` variable (if applicable for CDN)
- [ ] Add `company_prefix` and `sequence_number`
- [ ] Add comprehensive validations
- [ ] Update local.tf with override naming logic
- [ ] Rename resource to "main"

**Estimated Effort**: 2-3 hours

---

### 4. Event Grid Domain Module (0/5) ⚠️
**Path**: `azure/event_grid_domain/`
**Current State**:
- ❌ No override_name
- ❌ Hardcoded "nmbrs" in naming
- ❌ Main resource: "domain"
- ⚠️ Has local.tf but no override

**Action Items**:
- [ ] Add `override_name` variable (nullable)
- [ ] Remove hardcoded "nmbrs", add `company_prefix` variable
- [ ] Add `sequence_number` variable
- [ ] Add comprehensive validations
- [ ] Update local.tf with override naming logic
- [ ] Rename resource to "main"

**Estimated Effort**: 2-3 hours

---

### 5. Event Hub Module (0/5) ⚠️
**Path**: `azure/event_hub/`
**Current State**:
- ❌ No override_name
- ❌ Hardcoded "nmbrs" in naming
- ❌ Main resource: "event_hub_namespace"
- ⚠️ Has local.tf but no override

**Action Items**:
- [ ] Add `override_name` variable (nullable)
- [ ] Remove hardcoded "nmbrs", add `company_prefix` variable
- [ ] Add `sequence_number` variable
- [ ] Add comprehensive validations
- [ ] Update local.tf with override naming logic
- [ ] Rename resource to "main"

**Estimated Effort**: 2-3 hours

---

### 6. Managed Identity Module (0/5) ⚠️
**Path**: `azure/managed_identity/`
**Current State**:
- ❌ No override_name
- ❌ No override_name
- ❌ Main resource: "identity"
- ❌ Minimal validations

**Action Items**:
- [ ] Add `override_name` variable (nullable)
- [ ] Add comprehensive validations
- [ ] Update local.tf with override naming logic
- [ ] Rename resource to "main"
- [ ] Add lifecycle precondition

**Design Decision**:
- ℹ️ No company_prefix by design — internal resource scoped to resource group, no global uniqueness required

**Estimated Effort**: 2-3 hours

---

### 7. Private Endpoint Module (0/5) ⚠️
**Path**: `azure/private_endpoint/`
**Current State**:
- ❌ No override_name
- ❌ Main resource: "endpoint"
- ⚠️ Has local.tf with naming logic but no override

**Action Items**:
- [ ] Add `override_name` variable (nullable)
- [ ] Add comprehensive validations
- [ ] Update local.tf with override naming logic
- [ ] Rename resource to "main"
- [ ] Add lifecycle precondition

**Design Decision**:
- ℹ️ No company_prefix by design — name is derived from the resource being made private, uniqueness comes from the target resource name

**Estimated Effort**: 2-3 hours

---

### 8. Service Bus Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/service_bus/`
**Status**: **FULLY COMPLIANT** (Completed: 2026-06-02)

**Completed Actions**:
- ✅ Added `override_name` variable (nullable, trimspace validation)
- ✅ Added `company_prefix` variable (nullable, 1-5 chars)
- ✅ Made `workload` nullable with validation
- ✅ Renamed resource from `service_bus` to `main`
- ✅ Removed hardcoded `"nmbrs"` from naming pattern
- ✅ Wired `local.service_bus_name` into `main.tf` (the local existed but wasn't used — latent bug)
- ✅ Added lifecycle precondition for naming validation
- ✅ Updated outputs to reference the renamed resource
- ✅ Restructured README — manual sections moved outside `BEGIN_TF_DOCS`/`END_TF_DOCS` markers
- ✅ Integrated `private_endpoint` module (subresource `namespace`)

**Design Decision**:
- ℹ️ No `sequence_number` by design — matches the kv/storage/app_configuration pattern for singleton-per-workload public-facing resources. Uniqueness comes from `company_prefix + workload + env`.

**Changes**:
- `variables.tf`: Added `override_name`, `company_prefix`, `network_settings`, `private_dns_zone_ids`; made `workload` nullable; added validations
- `local.tf`: Added override naming logic with ternary; added `private_endpoint_subresources = ["namespace"]`
- `main.tf`: Renamed resource to `main`; wired `local.service_bus_name`; added naming-validation precondition
- `output.tf`: Updated all references from `.service_bus` to `.main`
- `private_endpoint.tf`: New file, follows the same template as kv/storage
- `README.md`: Restructured to keep manual content outside TF_DOCS markers; rewrote examples with new variable shape

---

### 9. DNS Zone Module (1/5)
**Path**: `azure/dns_zone/`
**Current State**:
- ❌ No override_name
- ✅ Has comprehensive name validations
- ❌ No main resource (data-only module)
- ❌ No local.tf

**Action Items**:
- Evaluate if standardization needed for DNS zone (may be special case)

**Estimated Effort**: 1 hour

---

### 10. Domain Module (1/5)
**Path**: `azure/domain/`
**Current State**:
- ✅ Has override_name (nullable)
- ✅ Has domain name validations
- ❌ No main resource
- ❌ No local.tf

**Action Items**:
- Evaluate module purpose and if full standardization needed

**Estimated Effort**: 1 hour

---

### 11. Private DNS Zone Module (1/5)
**Path**: `azure/private_dns_zone/`
**Current State**:
- ❌ No override_name
- ✅ Has comprehensive name validations
- ❌ No main resource
- ❌ No local.tf

**Action Items**:
- Evaluate if standardization needed (similar to dns_zone)

**Estimated Effort**: 1 hour

---

### 12. SSL Certificate Module (1/5)
**Path**: `azure/ssl_certificate/`
**Current State**:
- ✅ Has override_name (nullable)
- ✅ Has domain name validations
- ❌ No main resource
- ❌ No local.tf
- ❌ Missing workload, company_prefix, sequence_number

**Action Items**:
- Evaluate module purpose and if full standardization needed

**Estimated Effort**: 1 hour

---

### 13. Virtual Network Peering Module (0/5)
**Path**: `azure/virtual_network_peering/`
**Current State**:
- ❌ No override_name (may not be applicable)
- ❌ Has local.tf but no override logic
- ❌ Relationship module (different pattern)

**Action Items**:
- Evaluate if standardization applies to relationship modules

**Estimated Effort**: 1 hour

---

## 🟡 MEDIUM PRIORITY - Moderate Updates Needed (Score 2-3/5)

### 14. App Configuration Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/app_configuration/`
**Status**: **FULLY COMPLIANT** (Completed: 2026-03-16, improved 2026-06-09)

**Current State**:
- ✅ override_name variable with nullable validation
- ✅ company_prefix nullable (removed default "nmbrs")
- ✅ Comprehensive validations with format() error messages
- ✅ Main resource named "main"
- ✅ local.tf with simplified override ternary naming logic
- ✅ Lifecycle precondition for naming validation
- ✅ outputs.tf added (name, workload, id, endpoint)
- ✅ Integrated `private_endpoint` module via consolidated `private_endpoint_settings` (subresource `configurationStores`); SKU-gated like `service_bus` — Standard/Premium **must** supply settings, Free/Developer **must not**; PEP ref `f41a116c9f31892191b5e3f146a1e361bfc57322` (2026-06-09)

**Changes**:
- `variables.tf`: Added `private_endpoint_settings` — typed object, `default = null`, `nullable = true` (2026-06-09)
- `local.tf`: Added `private_endpoint_subresources = ["configurationStores"]` (2026-06-09)
- `main.tf`: Added SKU↔PEP preconditions (Standard/Premium require, Free/Developer forbid) (2026-06-09)
- `private_endpoint.tf`: New file wiring the PEP module to `private_endpoint_settings` with conditional `for_each` (2026-06-09)
- `README.md`: Added prose explaining the SKU gating; replaced the "standard tier with public access" example with two new ones — Standard-tier with PEP only, and Standard-tier with PEP + public access; TF_DOCS regenerated (2026-06-09)

**Design Decisions**:
- ℹ️ No `sequence_number` by design — relies on `company_prefix + workload + env` for uniqueness (app-scoped tier)
- ℹ️ No `location` in name — app-scoped tier convention (consistent with KV, storage, service_bus)
- ℹ️ No `firewall_settings` consolidation — module exposes only `public_network_access_enabled` (single top-level bool); wrapping in a one-field object adds nesting without value. IP-based filtering on Standard/Premium tiers would be a new feature, not a consolidation refactor.

---

### 15. Cosmos DB Module (2/5)
**Path**: `azure/cosmos_db/`
**Current State**:
- ❌ No override_name
- ⚠️ Uses `instance_count` instead of `sequence_number`
- ❌ Main resource: "cosmo_db"
- ✅ Has local.tf with naming logic

**Action Items**:
- [ ] Add override_name variable
- [ ] Rename `instance_count` to `sequence_number`
- [ ] Add company_prefix variable
- [ ] Add comprehensive validations
- [ ] Update local.tf with override logic
- [ ] Rename resource to "main"

**Estimated Effort**: 2-3 hours

---

### 16. Document Intelligence Module (2/5)
**Path**: `azure/document_intelligence/`
**Current State**:
- ❌ No override_name
- ⚠️ Uses `instance_count` instead of `sequence_number`
- ❌ Main resource: "document_intelligence"
- ✅ Has local.tf with naming logic

**Action Items**:
- [ ] Add override_name variable
- [ ] Rename `instance_count` to `sequence_number`
- [ ] Add company_prefix variable
- [ ] Add comprehensive validations
- [ ] Update local.tf with override logic
- [ ] Rename resource to "main"

**Estimated Effort**: 2-3 hours

---

### 17. Key Vault Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/key_vault/`
**Status**: **FULLY COMPLIANT** (Completed: 2025-12-03)

**Design Decision**:
- ℹ️ No sequence_number by design - relies on company_prefix + workload + env for uniqueness
- ℹ️ Naming pattern: `kv-{company}-{workload}-{env}` (e.g., `kv-nmbrs-contoso-prod`)
- ✅ Main resource kept as "key_vault" (clear, descriptive name)

**Completed Actions**:
- ✅ Made company_prefix nullable (removed default "nmbrs")
- ✅ Added naming validation precondition (without sequence_number)
- ✅ Validated: `override_name OR (workload + company_prefix)`

**Changes**:
- `variables.tf`: Removed default value from company_prefix, made nullable with validation
- `main.tf`: Added lifecycle precondition for naming validation (lines 24-31)

**⏳ Pending refactor**:
- Firewall variables (`public_network_access_enabled`, `trusted_services_bypass_firewall_enabled`) should be consolidated into a `firewall_settings` object matching the sql_server/service_bus pattern. See "Scattered firewall variables" in Critical Issues.

---

### 18. Private DNS Resolver Module (2/5)
**Path**: `azure/private_dns_resolver/`
**Current State**:
- ❌ No override_name
- ⚠️ Uses `naming_count` instead of `sequence_number`
- ❌ Main resource: "resolver"
- ✅ Has local.tf with naming logic

**Action Items**:
- [ ] Add override_name variable
- [ ] Rename `naming_count` to `sequence_number`
- [ ] Add company_prefix variable
- [ ] Add comprehensive validations
- [ ] Update local.tf with override logic
- [ ] Rename resource to "main"

**Estimated Effort**: 2-3 hours

---

### 19. SQL Database Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/sql_database/`
**Status**: **FULLY COMPLIANT** (Completed: 2025-12-09, improved 2026-03-18)

**Completed Actions**:
- ✅ Renamed `instance_count` to `sequence_number`
- ✅ Added company_prefix variable for naming consistency
- ✅ Updated naming pattern: `sqldb-{company}-{workload}-{env}-{location}-{seq}`
- ✅ Renamed resource from "sql_database" to "main"
- ✅ Added lifecycle precondition for naming validation
- ✅ Made elastic_pool_settings nullable (optional)
- ✅ Cleaned up empty string checks throughout module
- ✅ Added `override_name` trimspace validation (2026-03-18)
- ✅ Added field-level validation to `sql_server_settings` (2026-03-18)
- ✅ Fixed `elastic_pool_settings` data source RG bug (2026-03-18)
- ✅ Refactored backup settings to direct ISO 8601 strings (2026-03-18)
- ✅ Renamed `output.tf` → `outputs.tf` (2026-03-18)
- ✅ Standardized output names: `name`, `workload`, `id`, `collation` (2026-03-18)
- ✅ Removed `company_prefix` — database name is scoped under SQL Server, no global uniqueness needed (2026-03-18)
- ✅ Updated naming pattern: `sqldb-{workload}-{env}-{location}-{seq}` (2026-03-18)

**Design Decision**:
- ℹ️ No company_prefix by design — SQL Database name is unique within its SQL Server scope, not globally. The SQL Server already carries the company_prefix for global DNS uniqueness.

**Changes**:
- `variables.tf`: Renamed instance_count → sequence_number, made workload nullable; added override_name and sql_server_settings validations; removed company_prefix (2026-03-18)
- `local.tf`: Updated naming logic with override support; refactored backup_settings to ISO 8601 strings; removed company_prefix from naming pattern (2026-03-18)
- `main.tf`: Renamed resource to "main", removed duplicate naming logic, added lifecycle precondition; updated LTR policy to use new local keys; removed company_prefix from precondition (2026-03-18)
- `data.tf`: Fixed elastic pool resource_group_name to use elastic_pool_settings.resource_group_name (2026-03-18)
- `outputs.tf`: Renamed from output.tf, standardized output names, added workload output (2026-03-18)
- `README.md`: Cleaned up examples — removed inline comment groups, redundant null defaults, aligned source path with other modules (2026-03-18)

---

### 20. SQL Server Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/sql_server/`
**Status**: **FULLY COMPLIANT** (Completed: 2025-12-09, improved 2026-03-17, 2026-06-08)

**Completed Actions**:
- ✅ Renamed `instance_count` to `sequence_number` (already done in previous work)
- ✅ Added missing network_settings variable definition
- ✅ Renamed resource from "sql_server" to "main"
- ✅ Added lifecycle preconditions for naming validation
- ✅ Made auditing_settings nullable with conditional validation
- ✅ Implemented single source of truth for audited environments (prod/sand/stage)
- ✅ Removed environment validation (matches reference standard)
- ✅ Optimized auditing logic with local.audited_environments list
- ✅ Renamed `output.tf` → `outputs.tf` for consistency
- ✅ Standardized output names: `sql_server_name/id/fqdn` → `name/workload/id/fqdn`
- ✅ Added descriptions to all outputs
- ✅ Added field-level trimspace validation to `network_settings.allowed_subnets` entries
- ✅ Consolidated PEP wiring into `private_endpoint_settings` (replaces `network_settings` + `private_dns_zone_ids`) (2026-06-08)
- ✅ Migrated `firewall_settings.allowed_subnets` → `allowed_subnet_ids` (list of full subnet resource IDs); dropped `data.azurerm_subnet` lookup (2026-06-08)
- ✅ Bumped PEP module ref to `f41a116c9f31892191b5e3f146a1e361bfc57322` (PEP accepts `subnet_id` directly) (2026-06-08)
- ✅ Composite `<vnet>/<subnet>` for_each key for VNet rules; regex-based ID parsing in `local.tf` (2026-06-08)
- ✅ Declared `azuread` provider in `required_providers` (tflint compliance) (2026-06-08)
- ✅ Made `sequence_number` optional (default `null`), aligning to the [Naming Tier Convention](#naming-tier-convention) for data-tier modules (2026-06-08)

**Changes**:
- `variables.tf`: Added network_settings, made auditing_settings nullable; added `allowed_subnets` field-level validation (2026-03-17); refreshed `firewall_settings` to `allowed_subnet_ids`, replaced `network_settings` + `private_dns_zone_ids` with `private_endpoint_settings`, made `sequence_number` optional with `default = null` (2026-06-08)
- `local.tf`: Added audited_environments list, updated audit_enabled logic; added `parsed_allowed_subnets`, `vnet_rules`, and `sequence_suffix` locals (2026-06-08)
- `main.tf`: Renamed resource to "main", added lifecycle preconditions, updated references; VNet rule now consumes `local.vnet_rules`; naming precondition no longer requires `sequence_number` (2026-06-08)
- `outputs.tf`: Renamed from output.tf, standardized output names, added workload output and descriptions (2026-03-17)
- `data.tf`: Updated data source to handle nullable auditing_settings; dropped `data.azurerm_subnet` (2026-06-08)
- `private_endpoint.tf`: Bumped PEP ref; wired from `private_endpoint_settings` (2026-06-08)
- `terraform.tf`: Declared `azuread` provider (2026-06-08)
- `README.md`: Cleaned up examples — removed inline comment groups, removed redundant defaults, removed duplicate sections already in auto-generated docs (2026-03-17); updated examples to new variable shape, regenerated TF_DOCS, added `sequence_number` power-user note (2026-06-08)

**⚠️ Open PR finding (2026-03-17)**:
- The open sql_server PR was found to be based on **pre-modernization code** — it still uses `instance_count`, resource named `sql_server`, `public_network_settings` (flat structure), flat `local_sql_admin_settings`, no `company_prefix`, and no trimspace validation on `override_name`
- This PR predates the 2025-12-09 modernization and must be **closed or rebased** against main before merge

---

### 21. Storage Account Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/storage_account/`
**Status**: **FULLY COMPLIANT** (Completed: 2025-12-03)

**Design Decision**:
- ℹ️ No sequence_number by design - relies on company_prefix + workload + env for uniqueness
- ℹ️ Naming pattern: `st{company}{workload}{env}` (e.g., `stnmbrscontosoprod`) - No dashes due to Azure restrictions
- ✅ Main resource kept as "storage_account" (clear, descriptive name)

**Completed Actions**:
- ✅ Made company_prefix nullable (removed default "nmbrs")
- ✅ Added naming validation precondition (without sequence_number)
- ✅ Validated: `override_name OR (workload + company_prefix)`

**Changes**:
- `variables.tf`: Removed default value from company_prefix, made nullable with validation
- `main.tf`: Added lifecycle precondition for naming validation (lines 24-31)

**⏳ Pending refactor**:
- Firewall variables (`public_network_access_enabled`, `trusted_services_bypass_firewall_enabled`) should be consolidated into a `firewall_settings` object matching the sql_server/service_bus pattern. See "Scattered firewall variables" in Critical Issues.

---

### 22. Virtual Network Module (2/5)
**Path**: `azure/virtual_network/`
**Current State**:
- ❌ No override_name
- ⚠️ Uses `naming_count` instead of `sequence_number`
- ❌ Main resource: "vnet"
- ✅ Has comprehensive validations
- ✅ Has local.tf with naming logic

**Action Items**:
- [ ] Add override_name variable
- [ ] Rename `naming_count` to `sequence_number`
- [ ] Add company_prefix variable
- [ ] Update local.tf with override logic
- [ ] Rename resource to "main"
- [ ] Add lifecycle precondition

**Estimated Effort**: 2-3 hours

---

### 23. VPN Gateway Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/vpn_gateway/`
**Current State**:
- ✅ override_name variable with nullable validation
- ✅ sequence_number (renamed from naming_count), company_prefix variables
- ✅ Main resource named "main"
- ✅ Comprehensive validations with format() error messages
- ✅ local.tf with override ternary naming logic
- ✅ Lifecycle precondition for naming validation
- ✅ network_settings object variable (consolidates vnet_name, vnet_resource_group_name, address_spaces)
- ✅ Auto-derived generation from SKU (removed manual generation variable)
- ✅ Migrated to Microsoft-registered Azure VPN Client app ID (universal Linux/Windows/macOS support)
- ✅ data.tf with data sources extracted

---

## 🟢 LOW PRIORITY - Minor Tweaks or Fully Compliant (Score 4-5/5)

### 24. ~~Key Vault HSM Module~~ (REMOVED)
**Path**: ~~`azure/key_vault_hsm/`~~ (Removed: 2025-12-03)
**Reason**: Not used by the organization. HSM key vaults are not part of current infrastructure needs.

---

### 25. Log Analytics Workspace Module (5/5) ✓✓✓
**Path**: `azure/log_analytics_workspace/`
**Current State**:
- ✅ Has override_name (nullable)
- ✅ Has comprehensive validations
- ✅ **Main resource IS "main"**
- ✅ Has local.tf with override logic
- ✅ All nullable variables
- ✅ Has lifecycle precondition

**Status**: **FULLY COMPLIANT** - Perfect reference model!

---

### 26. NAT Gateway Module (5/5) ✓✓✓
**Path**: `azure/nat_gateway/`
**Current State**:
- ✅ Has override_name (nullable)
- ✅ Has comprehensive validations
- ✅ Has local.tf with override logic
- ✅ All nullable variables
- ✅ Has lifecycle precondition
- ⚠️ Main resource: "natgw" (not "main", but has precondition)

**Status**: **FULLY COMPLIANT** - Meets all criteria despite resource name!

---

### 27. Redis Cache Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/redis_cache/`
**Status**: **FULLY COMPLIANT** (Completed: 2025-12-03, improved 2026-06-09)

**Completed Actions**:
- ✅ Renamed resource from "redis" to "main"
- ✅ Added naming validation precondition
- ✅ Updated all output references
- ✅ Integrated `private_endpoint` module via consolidated `private_endpoint_settings` (subresource `redisCache`); PEP module ref `f41a116c9f31892191b5e3f146a1e361bfc57322` (2026-06-09)
- ✅ Restructured README so manual content (title, Summary, "How to use it?") sits outside the `BEGIN_TF_DOCS`/`END_TF_DOCS` markers — protects examples from terraform-docs regeneration (2026-06-09)
- ✅ Made `sequence_number` optional (default `null`), aligning to the [Naming Tier Convention](#naming-tier-convention) for data-tier modules; naming precondition relaxed to no longer require it (2026-06-09)

**Changes**:
- `main.tf`: Renamed resource, added lifecycle precondition for naming validation; naming precondition no longer requires `sequence_number` (2026-06-09)
- `outputs.tf`: Updated 9 output references from `.redis` to `.main`
- `variables.tf`: Added `private_endpoint_settings` (typed object, required, `redisCache` key); `sequence_number` now `default = null` with power-user description (2026-06-09)
- `local.tf`: Added `sequence_suffix` and `private_endpoint_subresources` locals; name template uses `sequence_suffix` conditionally (2026-06-09)
- `private_endpoint.tf`: New file wiring the PEP module to `private_endpoint_settings` (2026-06-09)
- `README.md`: Restructured (manual content outside TF_DOCS markers); examples include `private_endpoint_settings`; canonical examples drop explicit `sequence_number = N`; intro adds data-tier power-user note; TF_DOCS regenerated (2026-06-09)

**Design Decision**:
- ℹ️ No `firewall_settings` consolidation — Redis exposes only `public_network_access_enabled` (single top-level bool); wrapping it in a one-field object adds nesting without value. IP-based `azurerm_redis_firewall_rule` would be a new feature, not a consolidation refactor.

---

### 28. Resource Group Module (5/5) ✓✓✓
**Path**: `azure/resource_group/`
**Current State**:
- ✅ Has override_name (nullable)
- ✅ Has comprehensive validations
- ✅ **Main resource IS "main"**
- ✅ Has local.tf with override logic
- ✅ Has lifecycle precondition
- ✅ No company_prefix/sequence_number by design (internal resource)

**Status**: **FULLY COMPLIANT** - Appropriate pattern for resource groups!

---

### 29. Virtual Machine Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/virtual_machine/`
**Status**: **FULLY COMPLIANT FOR VM PATTERN** (Completed: 2025-12-03)

**Design Decisions**:
- ✅ Resources named "linux_vm" and "windows_vm" (not "main") - Makes sense for conditional resource types
- ✅ No company_prefix - VMs don't need global uniqueness, internal resources only
- ✅ Naming pattern: `vm{workload}{env}{seq}` (e.g., `vmapp001`)

**Completed Actions**:
- ✅ Added naming validation precondition to linux_vm resource
- ✅ Added naming validation precondition to windows_vm resource
- ✅ Documented as compliant for VM-specific pattern

**Changes**:
- `main.tf`: Added lifecycle precondition to both linux_vm (line 137-143) and windows_vm (line 204-210)
- Validates: `override_name OR (workload + sequence_number)`
- Windows VM also has NETBIOS name length validation (15 chars max)

---

### 30. Container Registry Module (5/5) ✓✓✓ COMPLETED
**Path**: `azure/container_registry/`
**Status**: **FULLY COMPLIANT** (Completed: 2025-12-09, improved 2026-06-09)

**Completed Actions**:
- ✅ Created new module from scratch following all standards (2025-12-09)
- ✅ SKU-aware preconditions: Basic/Standard force public access; trusted-bypass only on Premium-private
- ✅ Naming pattern: `cr{company}{workload}{env}` — app-scoped tier, ACR alphanumeric-only naming
- ✅ Restructured README: title + `## Summary` + "How to use it?" moved outside the `BEGIN_TF_DOCS` markers; renamed `output.tf` → `outputs.tf`; added `workload` output (2026-06-09)
- ✅ Consolidated `public_network_access_enabled` + `trusted_services_bypass_firewall_enabled` into `firewall_settings` — custom 2-field shape (no `allowed_subnet_ids` since ACR no longer supports VNet rules) (2026-06-09)
- ✅ Integrated `private_endpoint` module via consolidated `private_endpoint_settings` (subresource `registry`); Premium-only SKU gating; PEP ref `f41a116c9f31892191b5e3f146a1e361bfc57322` (2026-06-09)

**Changes**:
- `variables.tf`: Consolidated scattered firewall bools into `firewall_settings` (custom shape); added `private_endpoint_settings` typed object (optional, `default = null`) (2026-06-09)
- `local.tf`: Added `private_endpoint_subresources = ["registry"]`; `network_rule_bypass` now reads from `firewall_settings` (2026-06-09)
- `main.tf`: SKU↔PEP precondition (Basic/Standard must have null settings); preconditions reference `firewall_settings.*` (2026-06-09)
- `private_endpoint.tf`: New file wiring PEP module with conditional `for_each` (2026-06-09)
- `outputs.tf`: Renamed from `output.tf`; added `workload` output (2026-06-09)
- `README.md`: Restructured (manual content outside TF_DOCS markers); examples updated to use `firewall_settings` block and `private_endpoint_settings`; new "Premium with Private Endpoint Only" + "Premium with Public Access" examples; TF_DOCS regenerated (2026-06-09)

**Design Decisions**:
- ℹ️ No `location` in name — app-scoped tier convention (consistent with KV, storage, service_bus, app_insights, app_configuration)
- ℹ️ No `sequence_number` — app-scoped tier convention
- ℹ️ `firewall_settings` uses a **custom 2-field shape** — `allowed_subnet_ids` omitted because Azure deprecated VNet rules for ACR; documented in the variable description

---

## 🗑️ REMOVED MODULES

The following modules have been removed from the repository as they are not needed:

### 1. ~~location~~ (Removed: 2025-12-03)
**Reason**: Useless pass-through module that only validated location and returned the same value. No resources created. Location validation should be done within each module directly.

### 2. ~~role_assignment~~ (Removed: 2025-12-03)
**Reason**: Part of configuration lifecycle, handled by Ansible. Not infrastructure provisioning responsibility.

### 3. ~~dns_records~~ (Removed: 2025-12-03)
**Reason**: Not used anywhere in the codebase. Zero dependencies. DNS records can be managed directly or through other tooling.

### 4. ~~key_vault_hsm~~ (Removed: 2025-12-03)
**Reason**: Not used by the organization. HSM key vaults are not part of current infrastructure needs.

---

## 📊 UPDATED SUMMARY STATISTICS

### By Priority:

| Priority | Modules | Score Range | Estimated Total Effort |
|----------|---------|-------------|------------------------|
| 🔴 **HIGH** | 11 modules | 0-1/5 | 21-30 hours |
| 🟡 **MEDIUM** | 4 modules | 2-3/5 | 8-12 hours |
| 🟢 **LOW** | 14 modules | 4-5/5 | 2-3 hours |
| 🗑️ **REMOVED** | 4 modules | N/A | N/A |
| **TOTAL ACTIVE** | **29 modules** | | **40-57 hours** |

### Compliance Distribution:

| Score | Count | Modules |
|-------|-------|---------|
| 5/5 ✓✓✓ | 14 | log_analytics_workspace, nat_gateway, redis_cache, virtual_machine, storage_account, key_vault, sql_server, sql_database, container_registry, vpn_gateway, app_configuration, resource_group, application_insights, service_bus |
| 4/5 | 0 | |
| 3/5 | 0 | |
| 2/5 | 4 | cosmos_db, document_intelligence, private_dns_resolver, virtual_network |
| 1/5 | 4 | dns_zone, domain, private_dns_zone, ssl_certificate |
| 0/5 | 7 | app_service, cdn_frontdoor, event_grid_domain, event_hub, managed_identity, private_endpoint, virtual_network_peering |

---

## 🎯 RECOMMENDED IMPLEMENTATION PLAN

### Phase 1: Quick Wins (Week 1) - 1.5 hours ✅ COMPLETED
**Goal**: Fix nearly-compliant modules

1. ✅ **redis_cache** (15 min) - ~~Rename resource to "main"~~ **COMPLETED 2025-12-03**
2. ~~**key_vault_hsm**~~ - **REMOVED 2025-12-03** (not used)
3. ✅ **virtual_machine** (30 min) - ~~Review and document as compliant~~ **COMPLETED 2025-12-03**
4. ✅ **storage_account** (45 min) - ~~Remove company_prefix default, add naming precondition~~ **COMPLETED 2025-12-03**
5. ✅ **key_vault** (45 min) - ~~Remove company_prefix default, add naming precondition~~ **COMPLETED 2025-12-03**

### Phase 2: Medium Priority - Standard Names (Week 2-3) - 12 hours
**Goal**: Standardize variable names across modules

5. **cosmos_db** (2 hrs) - Rename instance_count → sequence_number
6. **document_intelligence** (2 hrs) - Rename instance_count → sequence_number
7. **sql_database** (1.5 hrs) - Rename instance_count → sequence_number
8. **sql_server** (1.5 hrs) - Rename instance_count → sequence_number
9. **virtual_network** (2 hrs) - Rename naming_count → sequence_number
10. **vpn_gateway** (2 hrs) - Rename naming_count → sequence_number
11. **private_dns_resolver** (2 hrs) - Rename naming_count → sequence_number

### Phase 3: Add Override Support (Week 4-5) - 10 hours
**Goal**: Add override_name to modules with good structure

12. **app_configuration** (1 hr) - Remove company_prefix default
13. **key_vault** (1 hr) - Remove company_prefix default
14. **managed_identity** (2 hrs) - Add override_name and validations
15. **private_endpoint** (2 hrs) - Add override_name and validations
16. **application_insights** (2 hrs) - Add override_name and full pattern
17. **cdn_frontdoor** (2 hrs) - Add override_name and full pattern

### Phase 4: Complex Refactoring (Week 6-8) - 15 hours
**Goal**: Modernize modules with significant gaps

18. **app_service** (4 hrs) - Full refactor: override_name, rename node_number
19. **event_grid_domain** (3 hrs) - Remove hardcoded nmbrs, add override
20. **event_hub** (3 hrs) - Remove hardcoded nmbrs, add override
21. ✅ **service_bus** (3 hrs) - ~~Remove hardcoded nmbrs, add override~~ **COMPLETED 2026-06-02** (also: PEP integration, README restructure)
22. **virtual_network_peering** (2 hrs) - Evaluate and modernize

### Phase 5: Special Cases Review (Week 9) - 4 hours
**Goal**: Review and decide on utility/special modules

23. **dns_zone** (1 hr) - Evaluate if standardization needed
24. **domain** (1 hr) - Evaluate if standardization needed
25. **private_dns_zone** (1 hr) - Evaluate if standardization needed
26. **ssl_certificate** (1 hr) - Evaluate if standardization needed

---

## 📋 MODULE UPDATE CHECKLIST TEMPLATE

Use this checklist for each module update:

### Variables:
- [ ] Add `override_name` variable (nullable, validated with format())
- [ ] Add `company_prefix` variable (1-5 chars, nullable) *if public-facing*
- [ ] Add `sequence_number` variable (1-999, nullable) *if scalable*
- [ ] Ensure `workload` is nullable
- [ ] Add environment validation (dev, test, prod, sand, stag)
- [ ] Add location validation (non-empty string)
- [ ] Remove any hardcoded "nmbrs" or default values
- [ ] All validations use format() for error messages

### Naming Logic:
- [ ] Update local.tf with flexible naming (override vs automatic)
- [ ] Use ternary operator: `var.override_name != null ? override : automatic`
- [ ] Add naming format comments
- [ ] Follow appropriate pattern for resource type

### Resource Naming:
- [ ] Rename main resource to "main" (or document reason if not)
- [ ] Update all output references
- [ ] Update all data source references

### Validation:
- [ ] Add lifecycle precondition for naming validation
- [ ] Test: either override_name OR workload + other components required
- [ ] Format: match application_gateway pattern

### Documentation:
- [ ] Add minimum 3 usage examples to README
- [ ] Document automatic naming pattern
- [ ] Document override naming pattern
- [ ] Add naming conventions section
- [ ] Add validation rules section

### Testing:
- [ ] Run `terraform fmt`
- [ ] Run `terraform validate`
- [ ] Test with automatic naming
- [ ] Test with override naming
- [ ] Test validation triggers (should fail gracefully)
- [ ] Test null values for nullable variables

---

## 📝 DESIGN DECISIONS & RATIONALE

### Module Categories

**company_prefix decision rule**: Required when the resource name is globally unique across Azure (DNS/URI namespace) or could be used in cross-tenant scenarios. Resources scoped to a subscription or resource group do not need it.

**Public-Facing Resources** (need company_prefix — globally unique DNS/URI or cross-tenant):
- application_gateway ✅
- cdn_frontdoor
- app_service
- app_configuration ✅
- key_vault ✅
- storage_account ✅
- nat_gateway ✅
- redis_cache ✅
- vpn_gateway ✅
- event_hub
- event_grid_domain
- service_bus
- cosmos_db
- document_intelligence
- container_registry ✅

**Internal Resources** (skip company_prefix — scoped to subscription/resource group):
- resource_group ✅
- virtual_machine ✅
- application_insights ✅ (by design)
- managed_identity ✅ (by design)
- private_endpoint ✅ (by design — name derived from target resource)
- log_analytics_workspace ✅
- sql_database ✅ (by design — scoped under SQL Server, which already carries company_prefix for DNS uniqueness)

**Scalable Resources** (need sequence_number):
- virtual_network
- virtual_machine ✅
- sql_server
- app_service
- cosmos_db
- vpn_gateway

**Removed Modules** (2025-12-03):
- ~~location~~ - Useless pass-through, no resources created
- ~~role_assignment~~ - Handled by Ansible configuration lifecycle
- ~~dns_records~~ - Not used anywhere, zero dependencies
- ~~key_vault_hsm~~ - Not used by organization, HSM not needed

### Naming Patterns

**Full Pattern** (public + scalable):
```hcl
{prefix}-{company}-{workload}-{env}-{location}-{seq}
Example: agw-nmbrs-contoso-prod-westeurope-001
```

**Internal Pattern** (no company):
```hcl
{prefix}-{workload}-{env}
Example: rg-contoso-prod
```

**Unique Pattern** (global uniqueness, no hyphens):
```hcl
{prefix}{company}{workload}{env}{random}
Example: stnmbrscontosoprod8f3a
```

### Variable Nullability Rules

1. **Always Nullable**:
   - override_name
   - workload (when override exists)
   - company_prefix (flexible deployment)
   - sequence_number (not always needed)

2. **Never Nullable**:
   - location (must always be specified)
   - environment (must always be specified)
   - resource_group_name (must always be specified)

3. **Conditional**:
   - workload: nullable if override_name exists
   - company_prefix: nullable if not public-facing
   - sequence_number: nullable if not scalable

---

## 🎓 LEARNING RESOURCES

### Perfect Reference Examples:
1. **azure/log_analytics_workspace/** (5/5) - Internal resource pattern
2. **azure/nat_gateway/** (5/5) - Public-facing pattern
3. **azure/application_gateway/** - Complete documentation reference
4. **azure/resource_group/** - Internal resource, main named "main"

### Key Files to Review:
- **variables.tf** - Variable definitions and validations
- **local.tf** - Naming logic and override support
- **main.tf** - Resource definitions and lifecycle preconditions
- **README.md** - Documentation with multiple examples

### Pattern Comparison:
```bash
# Compare perfect modules
diff azure/log_analytics_workspace/variables.tf azure/nat_gateway/variables.tf

# Compare local.tf patterns
diff azure/log_analytics_workspace/local.tf azure/application_gateway/local.tf

# Check lifecycle preconditions
grep -A 10 "precondition" azure/application_gateway/main.tf
```

---

## 🔍 VALIDATION COMMANDS

```bash
# Find all modules using non-standard names
grep -r "instance_count" azure/*/variables.tf
grep -r "naming_count" azure/*/variables.tf
grep -r "node_number" azure/*/variables.tf

# Find hardcoded "nmbrs"
grep -r '"nmbrs"' azure/*/local.tf
grep -r 'default.*=.*"nmbrs"' azure/*/variables.tf

# Check which modules have override_name
grep -l "override_name" azure/*/variables.tf

# Check which modules have main resource named "main"
grep -r 'resource.*"main"' azure/*/main.tf

# Check lifecycle preconditions
grep -r "precondition" azure/*/main.tf
```

---

**END OF DOCUMENT**
