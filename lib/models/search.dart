import 'package:isar/isar.dart';

part 'search.g.dart';

@collection
class Search {
  Id id = Isar.autoIncrement;
  String term;
  DateTime timestamp;

  Search({required this.term, required this.timestamp});

  Search.create(this.term) : timestamp = DateTime.now();
}
