import 'dart:io';

import 'package:flutter/foundation.dart';
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
    return Directory.fromUri(Uri.parse(path))
        .list(recursive: true)
        .where((entity) => entity is File)
        .asyncMap((file) => extractMetadata(file as File))
        .where((track) => track != null)
        .map((track) => track as Track);
  }

  Future<Track?> extractMetadata(File file) async {
    final type = lookupMimeType(file.path);
    final track = await supportedTypes[type]?.extract(file);
    if (track != null) track.image = await findImage(file);
    return track;
  }

  Future<String?> findImage(File file) async {
    try {
      final dir = file.parent;
      return await dir.list().map((e) => e.path).firstWhere(
          (path) => path.endsWith('.jpg') || path.endsWith('.jpeg'));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return null;
    }
  }
}
