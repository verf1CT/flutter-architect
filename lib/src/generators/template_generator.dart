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
}
