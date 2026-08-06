# 🏛️ Flutter Architect

A blazingly fast CLI tool for scaffolding Clean Architecture in Flutter projects.

[![Pub Version](https://img.shields.io/pub/v/flutter_architect?style=for-the-badge&color=02569B)](https://pub.dev/packages/flutter_architect)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

Stop creating `data`, `domain`, and `presentation` folders manually. `flutter-architect` generates the complete boilerplate for you in seconds.

## 🚀 Installation

Activate the CLI globally via Dart:

```bash
dart pub global activate flutter_architect
```

*(Make sure your `~/.pub-cache/bin` is added to your system PATH)*

## 🛠️ Usage

### 1. Initialize Clean Architecture
Run this at the root of your new Flutter project to create the base structure (`lib/core/`, `lib/features/`, and `injection_container.dart`):

```bash
flutter-architect init
```

### 2. Scaffold a New Feature
To generate a new feature with all the necessary layers (Data, Domain, Presentation):

```bash
flutter-architect feature --name auth
# or
flutter-architect feature -n auth
```

This will instantly create:
```
lib/features/auth/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## 📄 License

This project is MIT licensed.
