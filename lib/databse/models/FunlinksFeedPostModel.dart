
import 'package:famelink/databse/AppDatabase.dart';

class FunlinksFeedPostModel{
  FunlinkPostModelData postModel;
  List<ChallengesModelData> challengesList;
  List<MediaModelData> mediaList;

  FunlinksFeedPostModel(this.postModel, this.challengesList, this.mediaList);


  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is FunlinksFeedPostModel &&
        other.postModel.postId == this.postModel.postId;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}