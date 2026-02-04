# E&LT Pipeline Architecture -- Phase 0 Notes

## Purpose

Understand the **WHY** behind E&LT architecture before writing code.
This phase is pure learning --- no coding yet.

------------------------------------------------------------------------

# 1. E&LT vs ETL --- Why load raw data first?

## ETL (Extract → Transform → Load)

Transform happens **before** data enters the database.

Problems: - Slower (Python scripts do heavy work) - Hard to reprocess
later - Must re-extract if logic changes - Less reproducible

## E&LT (Extract → Load → Transform)

Load raw data first, transform inside the database.

Benefits: - Raw data preserved forever (auditability) - Faster (SQL
engines optimized for bulk work) - Easy re-runs - Flexible when
requirements change - Easier debugging

**Rule:** If storage is cheap and compute is strong, E&LT wins.

------------------------------------------------------------------------

# 2. Data Layering

## Landing (Raw)

Purpose: Store exactly what arrived - No changes - Often JSON/XML
blobs - Used for replay/debugging

## Staging

Purpose: Clean + standardize - Parse XML/JSON - Fix types - Normalize -
Validate - Deduplicate

## OLTP

Purpose: Application data - Current truth - Fast reads/writes -
Normalized tables

## OLAP

Purpose: Analytics + reporting - Aggregated - Historical -
Denormalized - Optimized for queries

------------------------------------------------------------------------

# 3. Separation of Concerns

Separating layers: - Improves performance - Reduces risk - Makes
debugging easier - Allows independent scaling

Analogy: - Staging = workshop - OLTP = showroom - OLAP = statistics lab

------------------------------------------------------------------------

# Architecture Decisions

## Why use staging tables instead of loading directly to OLTP?

-   Validate data before production
-   Handle schema mismatches
-   Support safe retries
-   Isolate bad data
-   Easier debugging

## When to transform in Python vs SQL vs Views?

### Python

-   Parsing XML/JSON
-   API calls
-   Complex logic
-   String manipulation

### SQL

-   Joins
-   Aggregations
-   Deduplication
-   Bulk transforms

### Views

-   Reusable business definitions
-   Reporting logic

Rule: - Parsing → Python\
- Joins/math → SQL\
- Presentation → Views

## Handling duplicates / retries (Idempotency)

Running twice should not change results.

Techniques: - Unique constraints - Primary keys - UPSERT - Hash dedup -
Merge logic

Example:

``` sql
INSERT INTO shipments ...
ON DUPLICATE KEY UPDATE ...
```

## OLTP vs OLAP

### OLTP

-   Users
-   Orders
-   Current shipments
-   Live state

### OLAP

-   Trends
-   Reports
-   Aggregations
-   Historical analysis

Rule: - Now → OLTP - Over time → OLAP

## Observability

Must-haves: - Logging - Row counts - Error capture - Execution time -
Alerts

Example table:

    pipeline_runs
    ------------
    run_id
    status
    start_time
    end_time
    rows_loaded
    errors

------------------------------------------------------------------------

# Current State Analysis Template

## Data Flow

XML → Python → MySQL

## Layer Mapping

  Step              Layer
  ----------------- ---------
  XML download      Landing
  Python parsing    Staging
  Insert to MySQL   OLTP

## Missing Pieces

-   Raw storage
-   Staging tables
-   Dedup logic
-   Orchestration
-   Monitoring
-   Retry handling
-   Historical warehouse

------------------------------------------------------------------------

# Validation Checkpoint

You should be able to explain: - Why raw data is preserved - Why staging
protects production - Why SQL handles bulk transforms - Why idempotency
matters - Why OLTP ≠ OLAP - Why orchestration is needed

If you can draw the pipeline in 4--5 boxes and justify each one, you're
ready for Phase 1.
