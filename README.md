# Tic Tac Toe Game

Tic tac Toe technical test.

## Quick Start

```bash
# Install dependencies
flutter pub get

# Generate code (Freezed & Riverpod)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Run tests
flutter test
```

---

## Architecture

### Clean Architecture with Feature-Based Organization

The project follows **Clean Architecture principles** with a **feature-based folder structure**, ensuring scalability, testability, and maintainability.

```
core                                    # Shared infrastructure
    - enums                             # game enums (GameStatus, GameMode)
    - router                            # GoRouter navigation configuration
    - services :                        # Global services
    
features                                # feature modules
    - game                              # feature name      
            - domain                    # Business Logic Layer (pure Dart)
                - entities              # Immutable domain models (GameState, Board, Player)
                - usecases              # Business use cases
                - services              # Domain services
                - abstracts             # Business interfaces
                
            - data # Data Layer
                - models                # JSON-serializable DTOs
                - repositories          # Repository implementations
                - datasources           # Data sources implementations
                
            - presentation              # UI Layer
                - screens               # Full-screen widgets
                - widgets               # Reusable UI components
            - providers                 # Riverpod providers
        
shared                                  # Shared widgets across features
```

**Layers Definition:**
- **Domain**: Pure business logic, framework-agnostic
- **Data**: External data handling
- **Presentation**: UI and user interaction

## Architecture Decisions

### **Clean Architecture**
- Separation of concerns and components are highly testable
- The use of Riverpod is to make state management predictable with DI included.
- Entities are immutable by using Freezed
- Using strategy pattern to handle vs human and vs AI.
- Using Repository pattern to abstract data layers

## Testing Strategy

- AAA pattern (Arrange-Act-Assert)
- Mock dependencies with Mocktail

**Run Tests:**
```bash
flutter test                              # All tests
flutter test test/features/game/domain/  # Domain layer only
```

## Development Workflow

### Code Generation
```bash
flutter pub run build_runner build --delete-conflicting-outputs

# Or watch
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Linting
```bash
flutter analyze
```

### Build
```bash
flutter build apk      # Android
flutter build ios      # iOS
flutter build web      # Web
```
