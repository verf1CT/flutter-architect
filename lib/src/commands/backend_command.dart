import 'dart:io';
import 'package:args/command_runner.dart';
import '../generators/folder_generator.dart';
import '../generators/template_generator.dart';

class BackendCommand extends Command {
  @override
  final name = 'backend';

  @override
  final description = 'Generate a dart_frog backend template.';

  BackendCommand() {
    argParser.addOption(
      'name',
      abbr: 'n',
      help: 'The name of the backend project.',
    );
  }

  @override
  void run() {
    String? projectName = argResults?['name'] as String?;

    if (projectName == null || projectName.isEmpty) {
      print('🚀 Entering Interactive Wizard (Backend)...');
      stdout.write('👉 Enter backend project name: ');
      projectName = stdin.readLineSync();

      if (projectName == null || projectName.isEmpty) {
        print('❌ Project name cannot be empty.');
        return;
      }
    }

    print('Scaffolding backend: $projectName with dart_frog...');

    final dirs = [
      '$projectName/routes',
      '$projectName/routes/api/v1',
      '$projectName/lib',
      '$projectName/lib/models',
      '$projectName/lib/repositories',
    ];

    FolderGenerator.createDirs(dirs);

    TemplateGenerator.createFile('$projectName/pubspec.yaml', '''
name: $projectName
description: A new dart_frog project.
version: 1.0.0
environment:
  sdk: ">=3.0.0 <4.0.0"
dependencies:
  dart_frog: ^1.0.0
dev_dependencies:
  test: ^1.19.2
  mocktail: ^1.0.0
''');

    TemplateGenerator.createFile('$projectName/routes/index.dart', '''
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(body: 'Welcome to $projectName API!');
}
''');

    TemplateGenerator.createFile('$projectName/routes/api/v1/health.dart', '''
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response.json(body: {'status': 'ok', 'version': '1.0.0'});
}
''');

    print(
        "🎉 Backend '\$projectName' scaffolded successfully! Run `dart_frog dev` inside it.");
  }
}
