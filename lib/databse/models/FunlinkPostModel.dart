import 'package:drift/drift.dart';
class FunlinkPostModel extends Table{

  TextColumn get postId => text().customConstraint('UNIQUE')();
  TextColumn get description => text()();
  TextColumn get district => text()();
  TextColumn get state => text()();
  TextColumn get country => text()();
  IntColumn get seen => integer()();
  IntColumn get likesCount => integer()();
  IntColumn get commentsCount => integer()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  TextColumn get userId => text()();
  TextColumn get userName => text()();
  TextColumn get name => text()();
  TextColumn get userBio => text()();
  TextColumn get typeOf => text()();
  TextColumn get userProfileImage => text()();
  TextColumn get musicName => text()();
  TextColumn get musicId => text()();
  TextColumn get userType => text()();
  TextColumn get audio => text()();
  BoolColumn get followStatus => boolean()();
  IntColumn get likeStatus => integer()();
  BoolColumn get isUpdate => boolean()();

  @override
  // TODO: implement primaryKey
  Set<Column> get primaryKey => {postId};
}