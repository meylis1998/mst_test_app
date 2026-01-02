# MST Test App

Flutter-приложение с подпиской, онбордингом и домашним экраном.

## Архитектура

**Clean Architecture** с разделением на слои:

- **Domain** — бизнес-логика: entities, abstract repositories, use cases
- **Data** — работа с данными: data sources, repository implementations
- **Presentation** — UI: BLoC (events/states), pages, widgets

**State Management:** BLoC + Equatable

**DI:** GetIt (lazy singletons)

**Навигация:** GoRouter с redirect-логикой (Onboarding → Paywall → Home)

## Структура проекта

```
lib/
├── app/                          # Корень приложения
│   ├── router/                   # GoRouter конфигурация
│   └── theme/                    # Темы, цвета, типографика
│
├── core/                         # Общая инфраструктура
│   ├── constants/                # Константы (API, app)
│   ├── di/                       # Dependency Injection
│   ├── error/                    # Exceptions, Failures
│   ├── network/                  # ApiClient, NetworkInfo
│   └── utils/                    # Утилиты, логгер
│
├── features/                     # Фичи приложения
│   ├── home/                     # Главный экран
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── onboarding/               # Онбординг
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── paywall/                  # Подписка
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── shared/                       # Общие компоненты
│   ├── data/                     # LocalStorage
│   └── presentation/             # ThemeBloc
│
├── bootstrap.dart                # Инициализация приложения
└── main.dart                     # Точка входа
```

## Что бы улучшил

**Тестирование:**
- Unit-тесты для use cases и repositories
- Widget-тесты для UI компонентов
- Integration-тесты для критичных флоу

**Архитектура:**
- Добавить Either (fpdart) для обработки ошибок в use cases
- Freezed для immutable entities и union types
- Injectable для автогенерации DI

**Функциональность:**
- Интеграция с реальным API (RevenueCat/Adapty для подписок)
- Deep linking
- Analytics (Firebase/Amplitude)
- Crash reporting (Sentry/Crashlytics)

**UX/UI:**
- Skeleton loading вместо индикаторов
- Анимации переходов между экранами
- Haptic feedback
- Адаптив под планшеты

**DevOps:**
- CI/CD pipeline (GitHub Actions/Codemagic)
- Flavors для dev/staging/prod
- Автоматическая генерация changelog
