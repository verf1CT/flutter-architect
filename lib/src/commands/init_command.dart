import 'package:args/command_runner.dart';
import 'package:path/path.dart' as p;
import '../generators/folder_generator.dart';
import '../generators/template_generator.dart';

class InitCommand extends Command {
  @override
  final name = 'init';

  @override
  final description = 'Initialize Clean Architecture in a Flutter project.';

  @override
  void run() {
    print('Initializing Clean Architecture...');

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
