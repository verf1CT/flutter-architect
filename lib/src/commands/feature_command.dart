import 'package:args/command_runner.dart';
import '../generators/folder_generator.dart';

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
  }

  @override
  void run() {
    final featureName = argResults?['name'] as String?;
    if (featureName == null || featureName.isEmpty) {
      print('❌ Feature name is required. Use --name or -n.');
      return;
    }

    print('Scaffolding feature: $featureName...');

    final featureDirs = [
      'lib/features/$featureName/data/datasources',
      'lib/features/$featureName/data/models',
      'lib/features/$featureName/data/repositories',
      'lib/features/$featureName/domain/entities',
      'lib/features/$featureName/domain/repositories',
      'lib/features/$featureName/domain/usecases',
      'lib/features/$featureName/presentation/bloc',
      'lib/features/$featureName/presentation/pages',
      'lib/features/$featureName/presentation/widgets',
    ];

    FolderGenerator.createDirs(featureDirs);

    print('🎉 Feature \'$featureName\' scaffolded!');
  }
}
