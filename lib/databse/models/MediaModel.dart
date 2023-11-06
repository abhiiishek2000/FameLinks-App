import 'package:drift/drift.dart';
class MediaModel extends Table{

  TextColumn get mediaPath => text().customConstraint('UNIQUE')();
  TextColumn get postId => text()();
  TextColumn get mediaType => text()();

  @override
  // TODO: implement primaryKey
  Set<Column> get primaryKey => {mediaPath};
}