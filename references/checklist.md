# Java CR General Checklist

## Usage
- Used in pass-1 only.
- Evaluate findings against `git diff <base> -- '*.java'`.
- Keep comments actionable and concise.

## G1 Correctness
- `[G1-1][MUST]` Core logic is correct for happy path and edge cases.
- `[G1-2][MUST]` Null handling is safe (inputs, returns, chain calls).
- `[G1-3][SHOULD]` Boundary values and empty collections are handled.

## G2 Error Handling
- `[G2-1][MUST]` Exceptions are not silently swallowed.
- `[G2-2][SHOULD]` Error context is preserved in logs or wrapped exceptions.
- `[G2-3][SHOULD]` Retry/fallback paths avoid infinite loops or hidden failures.

## G3 Concurrency and State
- `[G3-1][MUST]` Shared mutable state is protected in concurrent paths.
- `[G3-2][SHOULD]` Thread-safety assumptions are explicit and consistent.
- `[G3-3][NICE]` Lock scope is minimal and deadlock risk is reduced.

## G4 API and Contracts
- `[G4-1][MUST]` Method contracts are not broken by changed behavior.
- `[G4-2][SHOULD]` Backward compatibility is considered for public APIs.
- `[G4-3][NICE]` Input validation messages are clear and consistent.

## G5 Performance and Readability
- `[G5-1][SHOULD]` Avoid obvious N+1 loops or repeated heavy operations.
- `[G5-2][SHOULD]` Keep methods focused and readable.
- `[G5-3][NICE]` Reduce low-value duplication within diff scope.

## G6 Tests
- `[G6-1][MUST]` Critical path changes are covered by tests or test plan.
- `[G6-2][SHOULD]` Edge/failure cases have meaningful coverage.
