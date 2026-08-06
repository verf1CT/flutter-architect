import 'dart:io';
import 'package:path/path.dart' as p;

class FolderGenerator {
  static void createDirs(List<String> paths) {
    for (var path in paths) {
      final dir = Directory(path);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
        print('✅ Created: $path');
        // Add a .gitkeep to keep empty folders in git
        File(p.join(path, '.gitkeep')).createSync();
      }
    }
  }
}
