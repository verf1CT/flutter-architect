import 'dart:io';

class TemplateGenerator {
  static void createFile(String path, String content) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync(content);
      print('✅ Created file: $path');
    }
  }

  static String getUseCaseTemplate() {
    return '''
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<dynamic, Type>> call(Params params);
}

class NoParams {}
''';
  }

  static String getInjectionContainerTemplate() {
    return '''
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // TODO: Add dependencies
}
''';
  }

  static String getThemeTemplate() {
    return '''
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
''';
  }

  static String getBlocEventTemplate(String featureName) {
    final pascalCase = featureName[0].toUpperCase() + featureName.substring(1);
    return '''
abstract class ${pascalCase}Event {}

class Get${pascalCase}Event extends ${pascalCase}Event {}
''';
  }

  static String getBlocStateTemplate(String featureName) {
    final pascalCase = featureName[0].toUpperCase() + featureName.substring(1);
    return '''
abstract class ${pascalCase}State {}

class ${pascalCase}Initial extends ${pascalCase}State {}
class ${pascalCase}Loading extends ${pascalCase}State {}
class ${pascalCase}Loaded extends ${pascalCase}State {}
class ${pascalCase}Error extends ${pascalCase}State {
  final String message;
  ${pascalCase}Error(this.message);
}
''';
  }

  static String getBlocTemplate(String featureName) {
    final pascalCase = featureName[0].toUpperCase() + featureName.substring(1);
    return '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '${featureName}_event.dart';
import '${featureName}_state.dart';

class ${pascalCase}Bloc extends Bloc<${pascalCase}Event, ${pascalCase}State> {
  ${pascalCase}Bloc() : super(${pascalCase}Initial()) {
    on<Get${pascalCase}Event>((event, emit) async {
      emit(${pascalCase}Loading());
      // TODO: implement logic
      emit(${pascalCase}Loaded());
    });
  }
}
''';
  }

  static String getRiverpodTemplate(String featureName) {
    final pascalCase = featureName[0].toUpperCase() + featureName.substring(1);
    return '''
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ${featureName}Provider = StateNotifierProvider<${pascalCase}Notifier, ${pascalCase}State>((ref) {
  return ${pascalCase}Notifier();
});

class ${pascalCase}State {
  final bool isLoading;
  ${pascalCase}State({this.isLoading = false});
}

class ${pascalCase}Notifier extends StateNotifier<${pascalCase}State> {
  ${pascalCase}Notifier() : super(${pascalCase}State());
  
  // TODO: implement logic
}
''';
  }

  static String getGetXTemplate(String featureName) {
    final pascalCase = featureName[0].toUpperCase() + featureName.substring(1);
    return '''
import 'package:get/get.dart';

class ${pascalCase}Controller extends GetxController {
  final isLoading = false.obs;

  // TODO: implement logic
}
''';
  }

  static String getUnitTestTemplate(String featureName) {
    final pascalCase = featureName[0].toUpperCase() + featureName.substring(1);
    return '''
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('${pascalCase}Feature Tests', () {
    test('should initialize properly', () {
      // TODO: implement test
      expect(true, isTrue);
    });
  });
}
''';
  }
}
