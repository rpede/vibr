import 'dart:io';

import '../../models/models.dart';

abstract class TrackInfoExtractor {
  abstract final List<String> mimeTypes;
  Future<Track> extract(File file);
}
