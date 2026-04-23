# Java CR Custom RAG Knowledge List

## Usage
- Used in pass-2 only.
- This list represents team/domain preferences beyond generic checklist.
- Re-run review from scratch with these rules.

## RAG-1 Domain Safety and Data Integrity
- `[RAG-1-1][MUST]` Monetary/score/counter updates are atomic and not lost under concurrency.
- `[RAG-1-2][MUST]` ID mapping and key-field transformations are deterministic and reversible when required.
- `[RAG-1-3][SHOULD]` Timezone and date boundary handling is explicit (start/end, inclusive/exclusive).

## RAG-2 Idempotency and Retry Semantics
- `[RAG-2-1][MUST]` Retryable operations are idempotent or protected by dedup keys.
- `[RAG-2-2][SHOULD]` External side effects (message send, DB write, callback) have clear anti-dup protection.
- `[RAG-2-3][NICE]` Retry policy parameters are centralized and easy to tune.

## RAG-3 Observability and Diagnostics
- `[RAG-3-1][MUST]` Key failure paths emit diagnostic logs with business identifiers.
- `[RAG-3-2][SHOULD]` Logs avoid sensitive data and include enough context for tracing.
- `[RAG-3-3][NICE]` Metrics are added for high-risk or high-frequency paths.

## RAG-4 Defensive Coding Standards
- `[RAG-4-1][MUST]` External inputs are validated before use (null, range, format).
- `[RAG-4-2][SHOULD]` Optional/Stream usage avoids hidden `NoSuchElementException` or unreadable chains.
- `[RAG-4-3][NICE]` Complex branches include one-line intent comments when needed.

## RAG-5 Service Integration Constraints
- `[RAG-5-1][MUST]` Remote call failures/timeouts are handled explicitly.
- `[RAG-5-2][SHOULD]` Batch calls or caching are considered when repeated lookups are visible in diff.
- `[RAG-5-3][NICE]` Integration boundaries expose stable interfaces for easier testing.

## RAG-6 Transaction and Persistence Semantics
- `[RAG-6-1][MUST]` Transaction boundary matches business atomicity; no partial-write leakage.
- `[RAG-6-2][MUST]` Rollback behavior is explicit for checked/unchecked exceptions where needed.
- `[RAG-6-3][SHOULD]` Read/write separation and isolation level assumptions are documented in critical paths.
- `[RAG-6-4][NICE]` Expensive queries are paginated or bounded to avoid unbounded scans.

## RAG-7 Cache Consistency Strategy
- `[RAG-7-1][MUST]` Cache update/eviction order cannot produce stale critical data for core flows.
- `[RAG-7-2][SHOULD]` TTL policy aligns with data freshness requirements.
- `[RAG-7-3][SHOULD]` Cache penetration/breakdown risks are mitigated (empty-value cache, jitter, lock, etc.).
- `[RAG-7-4][NICE]` Cache key construction is centralized to reduce drift across callers.

## RAG-8 MQ and Event-Driven Reliability
- `[RAG-8-1][MUST]` Producer/consumer semantics guarantee at-least-once correctness with idempotent handling.
- `[RAG-8-2][MUST]` Dead-letter and poison-message handling paths are defined for repeated failures.
- `[RAG-8-3][SHOULD]` Message schema evolution is backward compatible (new/optional fields, defaults).
- `[RAG-8-4][NICE]` Reconsume/backoff policy is configurable and observable.

## RAG-9 Security and Compliance Baseline
- `[RAG-9-1][MUST]` No secret/token/password appears in code, logs, or exception messages.
- `[RAG-9-2][MUST]` Permission checks are placed on server-side trust boundaries, not only client assumptions.
- `[RAG-9-3][SHOULD]` Sensitive fields are masked in logs and telemetry.
- `[RAG-9-4][NICE]` Inputs from external systems include schema/format validation with clear reject reason.

## RAG-10 Performance and Capacity Guardrails
- `[RAG-10-1][MUST]` Hot-path changes avoid obvious O(n^2)+ degradation or repeated remote calls in loops.
- `[RAG-10-2][SHOULD]` Object allocations on high-frequency paths are minimized when practical.
- `[RAG-10-3][SHOULD]` Timeouts, thread-pool sizes, and queue bounds are explicit for new async logic.
- `[RAG-10-4][NICE]` Degradation/fallback behavior exists for non-core dependency failures.

## RAG-11 Java and Spring Specific Practices
- `[RAG-11-1][MUST]` `@Transactional`, `@Async`, and proxy-based AOP interactions do not rely on self-invocation pitfalls.
- `[RAG-11-2][MUST]` Nullability assumptions in DTO/entity conversion are explicit and safe.
- `[RAG-11-3][SHOULD]` `Optional` is not used as field/parameter where it harms clarity or framework compatibility.
- `[RAG-11-4][SHOULD]` Stream chains remain readable; complex logic is extracted instead of deeply nested lambdas.
- `[RAG-11-5][NICE]` ThreadLocal usage has clear cleanup in pooled-thread environments.

## RAG-12 Testing and Release Safety
- `[RAG-12-1][MUST]` High-risk diff has regression tests or explicit test plan for failure paths.
- `[RAG-12-2][SHOULD]` Contract tests cover cross-service payload compatibility where interfaces changed.
- `[RAG-12-3][SHOULD]` Data migration/backfill scripts are reversible or have rollback notes.
- `[RAG-12-4][NICE]` Feature flags or staged rollout controls exist for risky behavior changes.
