import 'package:drift/drift.dart';


class FollowPostModel extends Table{

  TextColumn get postId => text().customConstraint('UNIQUE')();
  TextColumn get description => text()();
  TextColumn get district => text()();
  TextColumn get state => text()();
  TextColumn get country => text()();
  TextColumn get type => text()();
  TextColumn get musicName => text()();
  TextColumn get musicId => text()();
  IntColumn get maleSeen => integer()();
  IntColumn get femaleSeen => integer()();
  IntColumn get likesCount => integer()();
  IntColumn get likes0Count => integer()();
  IntColumn get likes1Count => integer()();
  IntColumn get likes2Count => integer()();
  IntColumn get commentsCount => integer()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get userId => text()();
  TextColumn get userName => text()();
  TextColumn get userType => text()();
  TextColumn get name => text()();
  TextColumn get typeOf => text()();
  TextColumn get userBio => text()();
  TextColumn get userProfileImage => text()();
  BoolColumn get followStatus => boolean()();
  IntColumn get likeStatus => integer()();
  BoolColumn get isUpdate => boolean()();

  @override
  // TODO: implement primaryKey
  Set<Column> get primaryKey => {postId};
}