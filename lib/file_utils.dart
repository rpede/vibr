import 'dart:io';

Future<List<File>> getFiles(String path) async {
  final List<File> files = [];
  await for (final file in scanDirectory(Directory.fromUri(Uri.parse(path)))) {
    files.add(file);
  }
  return files;
}

Stream<File> scanDirectory(Directory dir) async* {
  await for (final entity in dir.list(recursive: true)) {
    print('${entity.runtimeType}: ${entity.path}');
    if (entity is Directory) {
      yield* scanDirectory(entity);
    } else if (entity is File) {
      yield entity;
    }
  }
}
