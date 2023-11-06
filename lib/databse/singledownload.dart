import '../ui/otherUserProfile/model/FunLinkUserProfileModel.dart';

class Singledownload {
  FunLinkUserProfileModel? sing;
  singledownloads() async {
    // sing = await Localdata().gethivedata("getFameLinksProfile");
    sing!.result!.forEach((element) {
      print(element.media![0].path);
    });
  }
}
