import 'package:args/command_runner.dart';
import '../generators/folder_generator.dart';
import '../generators/template_generator.dart';

class FeatureCommand extends Command {
  @override
  final name = 'feature';

  @override
  final description = 'Scaffold a new feature with Clean Architecture layers.';

  FeatureCommand() {
    argParser.addOption(
      'name',
      abbr: 'n',
      help: 'The name of the feature.',
      mandatory: true,
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
    final featureName = argResults?['name'] as String?;
    final state = argResults?['state'] as String;

    if (featureName == null || featureName.isEmpty) {
      print('❌ Feature name is required. Use --name or -n.');
      return;
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
