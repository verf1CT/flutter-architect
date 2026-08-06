import 'package:args/command_runner.dart';
import '../generators/folder_generator.dart';
import '../generators/template_generator.dart';
import 'dart:io';

class InitCommand extends Command {
  @override
  final name = 'init';

  @override
  final description = 'Initialize Clean Architecture in a Flutter project.';

  @override
  void run() {
    print('🚀 Entering Interactive Wizard...');
    stdout.write('👉 Which HTTP client do you prefer? (1: http, 2: dio) [1]: ');
    final httpChoice = stdin.readLineSync();

    print(
        'Initializing Clean Architecture using ${httpChoice == '2' ? 'dio' : 'http'}...');

    final coreDirs = [
      'lib/core/error',
      'lib/core/network',
      'lib/core/usecases',
      'lib/core/utils',
      'lib/core/theme',
      'lib/features',
    ];

    FolderGenerator.createDirs(coreDirs);

    TemplateGenerator.createFile(
      'lib/core/usecases/usecase.dart',
      TemplateGenerator.getUseCaseTemplate(),
    );

    TemplateGenerator.createFile(
      'lib/injection_container.dart',
      TemplateGenerator.getInjectionContainerTemplate(),
    );

    TemplateGenerator.createFile(
      'lib/core/theme/app_theme.dart',
      TemplateGenerator.getThemeTemplate(),
    );

    print('🎉 Done! Clean Architecture scaffold ready.');
  }
}
