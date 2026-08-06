import 'package:args/command_runner.dart';
import '../generators/folder_generator.dart';
import '../generators/template_generator.dart';

import 'dart:io';

class FeatureCommand extends Command {
  @override
  final name = 'feature';

  @override
  final description = 'Scaffold a new feature with Clean Architecture layers.';

  FeatureCommand() {
    argParser.addOption(
      'name',
      abbr: 'n',
      help: 'The name of the feature (if omitted, interactive mode starts).',
    );
    argParser.addOption(
      'state',
      abbr: 's',
      help: 'The state management solution to use.',
      allowed: ['bloc', 'riverpod', 'getx'],
      defaultsTo: 'bloc',
    );
  }

  @override
  void run() {
    String? featureName = argResults?['name'] as String?;
    String state = argResults?['state'] as String? ?? 'bloc';

    if (featureName == null || featureName.isEmpty) {
      print('🚀 Entering Interactive Wizard...');
      stdout.write('👉 Enter feature name: ');
      featureName = stdin.readLineSync();

      if (featureName == null || featureName.isEmpty) {
        print('❌ Feature name cannot be empty.');
        return;
      }

      stdout.write(
          '👉 Choose state manager (1: bloc, 2: riverpod, 3: getx) [1]: ');
      final stateChoice = stdin.readLineSync();
      if (stateChoice == '2')
        state = 'riverpod';
      else if (stateChoice == '3')
        state = 'getx';
      else
        state = 'bloc';
    }

    print('Scaffolding feature: $featureName with $state...');

    final stateFolder = state == 'bloc'
        ? 'bloc'
        : (state == 'riverpod' ? 'providers' : 'controllers');

    final featureDirs = [
      'lib/features/$featureName/data/datasources',
      'lib/features/$featureName/data/models',
      'lib/features/$featureName/data/repositories',
      'lib/features/$featureName/domain/entities',
      'lib/features/$featureName/domain/repositories',
      'lib/features/$featureName/domain/usecases',
      'lib/features/$featureName/presentation/$stateFolder',
      'lib/features/$featureName/presentation/pages',
      'lib/features/$featureName/presentation/widgets',
      'test/features/$featureName',
    ];

    FolderGenerator.createDirs(featureDirs);

    final presentationPath =
        'lib/features/$featureName/presentation/$stateFolder';

    if (state == 'bloc') {
      TemplateGenerator.createFile(
        '$presentationPath/${featureName}_event.dart',
        TemplateGenerator.getBlocEventTemplate(featureName),
      );
      TemplateGenerator.createFile(
        '$presentationPath/${featureName}_state.dart',
        TemplateGenerator.getBlocStateTemplate(featureName),
      );
      TemplateGenerator.createFile(
        '$presentationPath/${featureName}_bloc.dart',
        TemplateGenerator.getBlocTemplate(featureName),
      );
    } else if (state == 'riverpod') {
      TemplateGenerator.createFile(
        '$presentationPath/${featureName}_provider.dart',
        TemplateGenerator.getRiverpodTemplate(featureName),
      );
    } else if (state == 'getx') {
      TemplateGenerator.createFile(
        '$presentationPath/${featureName}_controller.dart',
        TemplateGenerator.getGetXTemplate(featureName),
      );
    }

    // Generate unit test template
    TemplateGenerator.createFile(
      'test/features/$featureName/${featureName}_test.dart',
      TemplateGenerator.getUnitTestTemplate(featureName),
    );

    print('🎉 Feature \'$featureName\' scaffolded successfully!');
  }
}
