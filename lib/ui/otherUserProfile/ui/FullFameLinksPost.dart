import 'package:famelink/models/CommentListResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/latest_profile/ProfileFameLinksModel.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';





class FullFameLinksPost extends StatefulWidget {
  List<ProfileFameLinksModelResult> myFameResult;
  int index;


  FullFameLinksPost(this.myFameResult,this.index);

  @override
  _FullPostScreenState createState() => _FullPostScreenState();
}

class _FullPostScreenState extends State<FullFameLinksPost>
    with TickerProviderStateMixin
     {
 // int index = 0;
  int ind = 0;
  final ApiProvider _api = ApiProvider();
  List<Comment> commentList = [];
  List<Comment> commentRepliesList = [];
  TextEditingController replayController = new TextEditingController();
  TextEditingController commentController = new TextEditingController();
  TextEditingController reportCommentController = new TextEditingController();
  TextEditingController reportPostController = new TextEditingController();
  var focusNode = FocusNode();
  bool _commentValidate = false;
  String _singleValue = "";
  String _postSingleValue = "";

  String? mediaId;
  int current = 0;
  int currentHorizontal = 1;
  bool isOnPageTurning = false;
  bool isOnPageHorizontalTurning = false;
  PageController? pageController;

  int page = 1;

  bool isEdit = false;

  final GlobalKey<FormState> _reportKey = GlobalKey<FormState>();

  CommentResult? commentResult;
  ScrollController commentScrollController = ScrollController();
  ScrollController commentRepliesScrollController = ScrollController();
  int commentPage = 1;
  int commentRepliesPage = 1;
  String? commentId;
  String commentType = "";

  PageController? smoothPageController;



  void scrollListener() {
    if (isOnPageTurning &&
        pageController!.page == pageController!.page!.roundToDouble()) {
      setState(() {
        current = pageController!.page!.toInt();
        isOnPageTurning = false;
      });
    } else if (!isOnPageTurning && current.toDouble() != pageController!.page!) {
      if ((current.toDouble() - pageController!.page!).abs() > 0.1) {
        setState(() {
          isOnPageTurning = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body:Stack(
        children: [
          PinchZoom(
            resetDuration: const Duration(milliseconds: 100),
            maxScale: 2.5,
            onZoomStart: () {
              print('Start zooming');
            },
            onZoomEnd: () {
              print('Stop zooming');
            },
            child: PageView.builder(
              itemCount: widget.myFameResult.length,
                controller: pageController,
                itemBuilder: (context,index){
              return Image.network(
                "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${widget.myFameResult[index].posts![widget.index].closeUp}",
                fit: BoxFit.fill,
              );
            })
          ),
        ],
      ),
    );
  }

}
// class SampleTest {
//   pref.FameLinkUserProfileModel fameLinkUserProfileModel;
//   List<pref.Challenge> challengesList;
//   pref.User user;
//   List<pref.Media> mediaList;
//
//   SampleTest(this.fameLinkUserProfileModel, this.challengesList, this.user,
//       this.mediaList);
//
//   @override
//   // TODO: implement hashCode
//   int get hashCode => super.hashCode;
// }