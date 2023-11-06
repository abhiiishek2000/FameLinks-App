import 'dart:io';
import 'package:drift/drift.dart';
import 'package:famelink/databse/models/ChallengesModel.dart';
import 'package:famelink/databse/models/FeedPostModel.dart';
import 'package:famelink/databse/models/FunlinksFeedPostModel.dart';
import 'package:famelink/databse/models/PostModel.dart';
import 'package:famelink/databse/models/MediaModel.dart';
import 'package:famelink/databse/models/FunlinkPostModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'models/FollowFeedPostModel.dart';
import 'models/FollowPostModel.dart';
import 'package:drift/native.dart';


part 'AppDatabase.g.dart';
LazyDatabase openConnectionDatabase() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
//@UseMoor(tables: [PostModel?, ChallengesModel?, MediaModel?,FunlinkPostModel?,FollowPostModel?])
class AppDatabase extends _$AppDatabase {
  static AppDatabase? _instance;

  static AppDatabase get database {
    return _instance ??= AppDatabase();
  }

  AppDatabase() : super(openConnectionDatabase());



  @override
  int get schemaVersion => 3;

  Future<List<PostModelData>> getAllPost() => select(postModel).get();
  Future<List<FunlinkPostModelData>> getAllFunPost() => select(funlinkPostModel).get();
  Future<List<FollowPostModelData>> getAllFollowPost() => select(followPostModel).get();

  Future<PostModelData> find(String id) =>
      (select(postModel)..where((t) => t.postId.equals(id))).getSingle();

  Stream<List<FeedPostModel>> getAllFeed(int page, int fameSubTab) {
    final hotelStream = ((select(postModel))..orderBy(
      ([
        // Primary sorting by due date
            (t) =>
            OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        // Secondary alphabetical sorting
      ]),
    )).watch();
    // final hotelStream = select(postModel).watch();
    final imageStream = select(challengesModel).watch();
    final roomStream = select(mediaModel).watch();

    return Rx.combineLatest3(hotelStream, imageStream, roomStream,
            (List<PostModelData> a, List<ChallengesModelData> b,
            List<MediaModelData> c) {
          return a.map((journey) {
            final routePoints =
            b.where((routePoint) => routePoint.postId == journey.postId).toList();
            final calls = c.where((call) => call.postId == journey.postId).toList();

            return FeedPostModel(journey, routePoints, calls);
          }).toList();
        });
  }

  /*Stream<List<FeedPostModel>> getAllFeed(int page, int fameSubTab) {
    final hotelStream = ((select(postModel))..orderBy(
      ([
        // Primary sorting by due date
            (t) =>
            OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        // Secondary alphabetical sorting
      ]),
    )).watch();
    // final hotelStream = select(postModel).watch();
    final imageStream = select(challengesModel).watch();
    final roomStream = select(mediaModel).watch();

    return Rx.combineLatest3(hotelStream, imageStream, roomStream,
            (List<PostModelData> a, List<ChallengesModelData> b,
            List<MediaModelData> c) {
          return a.map((journey) {
            final routePoints =
            b?.where((routePoint) => routePoint.postId == journey.postId)?.toList();
            final calls = c?.where((call) => call.postId == journey.postId)?.toList();

            return FeedPostModel(journey, routePoints, calls);
          }).toList();
        });
  }*/

  /*Stream<List<FeedPostModel>> getAllVideoFeed(int page) {
    // final String id;
    // final String challengeId;
    // final String postId;
    // final String challengeName;
    var challangeExp =  CustomExpression<List<ChallengesModelData>>(challengesModel.toString());
    var mediaExp =  CustomExpression<List<MediaModelData>>(mediaModel.toString());
    final query =
    (select(postModel)).join([
      innerJoin(
          mediaModel, mediaModel.postId.equalsExp(postModel.postId)),
      innerJoin(
          challengesModel, challengesModel.postId.equalsExp(postModel.postId)),
    ]);
    query..addColumns([challangeExp,mediaExp])..groupBy([postModel.postId]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return FeedPostModel(row.readTable(postModel), row.read(challangeExp) ,row.read(mediaExp));
      }).toList();
    });
  }*/

  Stream<List<FollowFeedPostModel>> getAllFollowFeed(int page,int followSubTab) {
    final hotelStream = ((select(followPostModel))..orderBy(
      ([
        // Primary sorting by due date
            (t) =>
            OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        // Secondary alphabetical sorting
      ]),
    )).watch();
    final imageStream = select(challengesModel).watch();
    final roomStream = select(mediaModel).watch();

    return Rx.combineLatest3(hotelStream, imageStream, roomStream,
            (List<FollowPostModelData> a, List<ChallengesModelData> b,
            List<MediaModelData> c) {
          print("POST::${a.length}");
          return a.map((journey) {
            final routePoints =
            b.where((routePoint) => routePoint.postId == journey.postId).toList();
            final calls = c.where((call) => call.postId == journey.postId).toList();

            return FollowFeedPostModel(journey, routePoints, calls);
          }).toList();
        });
  }

  Stream<List<FunlinksFeedPostModel>> getAllFunLinksFeed(int page) {
    final hotelStream = ((select(funlinkPostModel))..orderBy(
      ([
        // Primary sorting by due date
            (t) =>
            OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        // Secondary alphabetical sorting
      ]),
    )).watch();
    final imageStream = select(challengesModel).watch();
    final roomStream = select(mediaModel).watch();

    return Rx.combineLatest3(hotelStream, imageStream,roomStream,
            (List<FunlinkPostModelData> a, List<ChallengesModelData> b,
            List<MediaModelData> c) {
          print("POST::${a.length}");
          return a.map((journey) {
            final routePoints =
            b.where((routePoint) => routePoint.postId == journey.postId).toList();
            final calls = c.where((call) => call.postId == journey.postId).toList();

            return FunlinksFeedPostModel(journey, routePoints, calls);
          }).toList();
        });
  }
  // Stream<List<HotelWithRoomModel>> watchAllHotelByPriceOrder() {
  //   final hotelStream = (select(accomanadationModel)..orderBy([(t) => OrderingTerm(expression: t.price)])).watch();
  //   final imageStream = select(hotelImagesModel).watch();
  //   final roomStream = select(hotelRoomModel).watch();
  //
  //   return Rx.combineLatest3(hotelStream, imageStream, roomStream,
  //       (List<AccomanadationModelData> a, List<HotelImagesModelData> b,
  //           List<HotelRoomModelData> c) {
  //     return a.map((journey) {
  //       final routePoints =
  //           b?.where((routePoint) => routePoint.id == journey.id)?.toList();
  //       final calls = c?.where((call) => call.id == journey.id)?.toList();
  //
  //       return HotelWithRoomModel(journey, calls, routePoints);
  //     }).toList();
  //   });
  // }
  Future updatePost(PostModelData product) =>
      update(postModel).replace(product);

  Future updateFunLinkPost(FunlinkPostModelData product) =>
      update(funlinkPostModel).replace(product);

  Future updateFollowLinkPost(FollowPostModelData product) =>
      update(followPostModel).replace(product);

  Future insertNewPost(PostModelData city) =>
      into(postModel).insert(city, mode: InsertMode.insertOrReplace);

  Future insertFunLinkNewPost(FunlinkPostModelData city) =>
      into(funlinkPostModel).insert(city, mode: InsertMode.insertOrReplace);

  Future insertFollowLinkNewPost(FollowPostModelData city) =>
      into(followPostModel).insert(city, mode: InsertMode.insertOrReplace);

  Future insertPostChallenges(ChallengesModelData city) =>
      into(challengesModel).insert(city, mode: InsertMode.insertOrReplace);

  Future insertPostMedia(MediaModelData city) =>
      into(mediaModel).insert(city, mode: InsertMode.insertOrReplace);

  Future deleteFollowLink() =>
      delete(followPostModel).go();

  Future deleteFameLink() =>
      delete(postModel).go();

  Future deleteFunLink() =>
      delete(funlinkPostModel).go();

  Future deleteFunLinkPost(String postId) {
    return (delete(funlinkPostModel)
      ..where((t) => t.postId.isSmallerOrEqualValue(postId)))
        .go();
  }
  Future deleteFameLinkPost(String postId) {
    return (delete(postModel)
      ..where((t) => t.postId.isSmallerOrEqualValue(postId)))
        .go();
  }
}
