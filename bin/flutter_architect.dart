import 'package:args/command_runner.dart';
import 'package:flutter_architect/src/commands/init_command.dart';
import 'package:flutter_architect/src/commands/feature_command.dart';
import 'dart:io';

void main(List<String> arguments) {
  final runner = CommandRunner(
    'flutter-architect',
    'A CLI tool for scaffolding Clean Architecture in Flutter projects.',
  )
    ..addCommand(InitCommand())
    ..addCommand(FeatureCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64); // Exit code 64 indicates a usage error.
  });
}