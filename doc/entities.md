# Design guideline for Datastore entities

We classify the data in the following categories:

- **Canonical data**: facts about an upload, or about a publisher
  - `Package`
  - `PackageVersion`
  - `User`
  - `Publisher`

- **Calculated data**: package analysis with a given runtime
  - `ScoreCard`
  - `ScoreCardReport`
  - `Job`

- **Derived data**: extracted from uploaded package content, rollup statistics
  - `PackageVersionInfo`
  - `PackageVersionPubspec`
  - `PackageVersionAsset`

## Migration

**Canonical data** should rarely (ideally never) change, we should
keep only a single entity of it.

**Calculated data** should be versioned with the current runtime.
When accessing runtime-versioned data which is not yet available,
a known list of fallback versions could be used to serve user
requests when needed.

**Derived data** could be versioned, but for practical reasons
we try to keep them simple and un-versioned. To handle ambiguity
from inconsistent or evolving processing between versions, the
following methods could be used as part of the schema migration:

- New field(s) can be used to hold the new data structure.

- For at least one release both the old, and the new field(s)
  must be populated.

- Subsequent releases may populate the old field with new data
  or remove one of the fields.
