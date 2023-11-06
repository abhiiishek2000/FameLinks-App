
import 'package:famelink/databse/AppDatabase.dart';

class FollowFeedPostModel{
  FollowPostModelData postModel;
  List<ChallengesModelData> challengesList;
  List<MediaModelData> mediaList;

  FollowFeedPostModel(this.postModel, this.challengesList, this.mediaList);

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is FollowFeedPostModel &&
        other.postModel.postId == this.postModel.postId;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}