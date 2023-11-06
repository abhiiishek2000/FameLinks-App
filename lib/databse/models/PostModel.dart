import 'package:drift/drift.dart';
class PostModel extends Table{

  TextColumn get postId => text().customConstraint('UNIQUE')();
  TextColumn get description => text()();
  TextColumn get district => text()();
  TextColumn get state => text()();
  TextColumn get country => text()();
  IntColumn get maleSeen => integer()();
  IntColumn get femaleSeen => integer()();
  IntColumn get likes0Count => integer()();
  IntColumn get likes1Count => integer()();
  IntColumn get likes2Count => integer()();
  IntColumn get commentsCount => integer()();
  TextColumn get price => text()();
  TextColumn get purchaseUrl => text()();
  TextColumn get productName => text()();
  TextColumn get buttonName => text()();
  TextColumn get typeOf => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get userId => text()();
  TextColumn get userName => text()();
  TextColumn get name => text()();
  TextColumn get userBio => text()();
  TextColumn get userType => text()();
  TextColumn get userProfileImage => text()();
  BoolColumn get followStatus => boolean()();
  BoolColumn get isUpdate => boolean()();
  IntColumn get likeStatus => integer()();

  @override
  // TODO: implement primaryKey
  Set<Column> get primaryKey => {postId};
}