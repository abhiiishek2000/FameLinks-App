
import 'package:famelink/databse/AppDatabase.dart';

class FeedPostModel{
  PostModelData postModel ;
  List<ChallengesModelData> challengesList;
  List<MediaModelData> mediaList;

  FeedPostModel(this.postModel, this.challengesList, this.mediaList);


  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is FeedPostModel &&
        other.postModel.postId == this.postModel.postId;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

}