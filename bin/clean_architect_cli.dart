import 'package:args/command_runner.dart';
import 'package:clean_architect_cli/src/commands/init_command.dart';
import 'package:clean_architect_cli/src/commands/feature_command.dart';
import 'package:clean_architect_cli/src/commands/backend_command.dart';
import 'dart:io';

void main(List<String> arguments) {
  final runner = CommandRunner(
    'clean_architect_cli',
    'A blazingly fast CLI tool for scaffolding Clean Architecture.',
  )
    ..addCommand(InitCommand())
    ..addCommand(FeatureCommand())
    ..addCommand(BackendCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64); // Exit code 64 indicates a usage error.
  });
}
