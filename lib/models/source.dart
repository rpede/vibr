import 'dart:ffi';

import 'package:isar/isar.dart';

part 'source.g.dart';

@collection
class Source {
  Id id = Isar.autoIncrement;
  bool local;
  String uri;

  Source({required this.local, required this.uri});
}
