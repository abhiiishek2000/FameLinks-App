import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class FeedVideoProvider extends ChangeNotifier {
  bool isMute = false;
  bool isClicked = false;
  bool isPaused = false;
  bool isLoading = false;

  void changeMuteStatus(VideoPlayerController controller) {
    if (isMute) {
      controller.setVolume(0);
      isMute = false;
      notifyListeners();
    } else {
      controller.setVolume(1);
      isMute = true;
      notifyListeners();
    }
  }

  void changeIsPausedStatus(VideoPlayerController controller) {
    if (isPaused) {
      controller.play();
      isPaused = false;
      notifyListeners();
    } else {
      controller.pause();
      isPaused = true;
      notifyListeners();
    }
  }

  void Loading() {
    isLoading = true;
    notifyListeners();
  }

  void notLoading() {
    isLoading = false;
    notifyListeners();
  }

  bool get getIsMute => isMute;

  bool get getIsLoading => isLoading;

  bool get getIsPaused => isPaused;
}
