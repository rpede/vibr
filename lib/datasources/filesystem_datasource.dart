import 'dart:io';

import 'package:mime/mime.dart';

import '../models/models.dart';
import 'files_types/track_info_extractor.dart';

class FilesystemDataSource {
  final Map<String, TrackInfoExtractor> supportedTypes;

  FilesystemDataSource(List<TrackInfoExtractor> extractors)
      : supportedTypes = mimeTypeMap(extractors);

  static Map<String, TrackInfoExtractor> mimeTypeMap(
      List<TrackInfoExtractor> extractors) {
    return Map.fromEntries(
        extractors.expand((e) => e.mimeTypes.map((t) => MapEntry(t, e))));
  }

  Stream<Track> findTracks(String path) {
    return getFiles(path)
        .asyncMap((file) => extractMetadata(file))
        .where((track) => track != null)
        .map((track) => track as Track);
  }

  Stream<File> getFiles(String path) {
    return scanDirectory(Directory.fromUri(Uri.parse(path)));
  }

  Stream<File> scanDirectory(Directory dir) async* {
    await for (final entity in dir.list(recursive: true)) {
      if (entity is Directory) {
        yield* scanDirectory(entity);
      } else if (entity is File) {
        yield entity;
      }
    }
  }

  Future<Track?> extractMetadata(File file) async {
    final type = lookupMimeType(file.path);
    return supportedTypes[type]?.extract(file);
  }
}
