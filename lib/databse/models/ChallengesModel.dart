//import 'package:moor_flutter/moor_flutter.dart';
import 'package:drift/drift.dart';

class ChallengesModel extends Table {
  TextColumn get id => text().customConstraint('UNIQUE')();
  TextColumn get challengeId => text()();
  TextColumn get postId => text()();
  TextColumn get challengeName => text()();

  @override
  // TODO: implement primaryKey
  Set<Column> get primaryKey => {id};
}
