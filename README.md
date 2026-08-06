# 🏛️ Clean Architect CLI

A blazingly fast CLI tool for scaffolding Clean Architecture in Flutter projects.

[![Pub Version](https://img.shields.io/pub/v/clean_architect_cli?style=for-the-badge&color=02569B)](https://pub.dev/packages/clean_architect_cli)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

Stop creating `data`, `domain`, and `presentation` folders manually. `clean_architect_cli` generates the complete boilerplate for you in seconds.

## 🚀 Installation

Activate the package globally:

```bash
dart pub global activate clean_architect_cli
```

*(Make sure your `~/.pub-cache/bin` is added to your system PATH)*

## 🛠️ Usage

Once activated, you can use the `clean_architect_cli` command from anywhere:

### 1. Initialize Clean Architecture
Run this at the root of your new Flutter project to create the base structure (`lib/core/`, `lib/features/`, and `injection_container.dart`):

```bash
clean_architect_cli init
```

### 2. Scaffold a New Feature
To generate a new feature with all the necessary layers (Data, Domain, Presentation):

```bash
clean_architect_cli feature --name auth
# or
clean_architect_cli feature -n auth
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
