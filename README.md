# Employee Directory — Flutter Task

A Flutter app that displays employees grouped by category under tab-based navigation, built with Clean Architecture, `flutter_bloc`, and a mock async data layer.

---

## Features

- Employee cards showing first name, last name, and employee ID
- IT / HR category tabs with filtered lists
- Mock async data source simulating real network latency
- Two-layer caching: in-memory + SharedPreferences (survives app restarts)
- Force refresh via AppBar button
- Error state with retry action
- Responsive sizing via `flutter_screenutil`

---

## Architecture

The project follows **Clean Architecture** with a **feature-first** folder structure.

```
lib/
├── core/
│   ├── constants/          # SharedPreferences keys
│   ├── di/                 # GetIt injection container
│   ├── error/              # Failures + Exceptions
│   ├── services/           # SharedPreferencesService
│   └── sizes/              # UISizes (spacing, font sizes)
│
└── features/
    └── employees/
        ├── data/
        │   ├── data_sources/   # Mock + Cached data sources
        │   ├── models/         # EmployeeModel (JSON ↔ Entity)
        │   └── repositories/   # EmployeeRepositoryImp
        │
        ├── domain/
        │   ├── entities/       # Employee
        │   ├── enums/          # EmployeeCategory
        │   ├── repositories/   # Abstract EmployeeRepository
        │   └── use_cases/      # GetAllEmployees
        │
        └── presentation/
            ├── bloc/           # EmployeesBloc, Event, State
            ├── pages/          # EmployeesScreen
            └── widgets/        # EmployeeCard, ErrorView, UserAvatar, CategoryBadge
```

---

## Tech Stack

| Concern | Package |
|---|---|
| State management | `flutter_bloc` |
| Functional error handling | `fpdart` (`Either<Failure, T>`) |
| Dependency injection | `get_it` |
| Value equality | `equatable` |
| Local persistence | `shared_preferences` |
| Responsive sizing | `flutter_screenutil_plus` |

---

## Getting Started

**Prerequisites:** Flutter 3.10+ (Dart 3.0+)

```bash
# Clone the repo
git clone <REPO_URL>
cd focal_agent_task

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## Design Decisions

**Clean Architecture with feature-first structure**
Layers (data / domain / presentation) live inside the feature folder so all employee-related code is co-located. `core/` holds genuinely cross-cutting concerns. Adding a new feature means adding a new folder — nothing else changes.

**`Either<Failure, T>` for error handling**
The repository returns `Either<Failure, List<Employee>>` instead of throwing. Error paths are explicit and compile-time enforced. The BLoC is forced to handle both success and failure — no silent swallowing of exceptions.

**Sealed classes for State and Event**
`EmployeesState` and `EmployeesEvent` are `sealed`, enabling exhaustive pattern matching via Dart 3 `switch` expressions. The compiler warns if a new state is added but not handled in the UI.

**Single event with `forceRefresh` flag**
`LoadEmployeesEvent(forceRefresh: bool)` handles both initial load and refresh. The caching decision stays in the repository where it belongs — the BLoC remains unaware of caching strategy.

**GetIt registration strategy**
`EmployeesBloc` → `Factory` (fresh instance per `BlocProvider`).
Use cases and repositories → `LazySingleton` (stateless, safe to share).

**`UISizes` + `flutter_screenutil_plus`**
All spacing, padding, and font sizes are defined in one place with `screenutil` units. Design changes are a single-file edit.

---

## Trade-offs & Assumptions

**SharedPreferences in addition to in-memory cache**
The task specified in-memory caching. I extended this to also persist to SharedPreferences so data survives app restarts — a realistic production expectation. The trade-off is a small added dependency and async I/O on cache reads.

**`EmployeeCategory.none` as a sentinel**
The enum includes a `none` fallback used when a JSON payload contains an unrecognized category string. This favours graceful degradation over crashing the list on a single bad record. The UI filters `none` out.

**`NetworkFailure` defined but unused**
`NetworkFailure` is declared in the failure hierarchy for future-proofing (connectivity checks, real API errors) but is not emitted in the current mock implementation.

**Static `SharedPreferencesService`**
Kept as a static utility for simplicity.

**No real HTTP layer**
The `MockEmployeesDataSource` simulates a 1-second network delay. The abstractions (`EmployeeRepository`, `MockEmployeesDataSource`) are in place so swapping the mock for a real Dio/Retrofit source requires only a one-line DI change.
