import 'package:famelink/models/message.dart';
import 'package:flutter/foundation.dart';


class MessagesProvider with ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get allMessages => [..._messages];

  void addMessage(Message message) {
    if (!_messages.contains(message)) {
      _messages.insert(0, message);
      notifyListeners();
    }
  }

  void clearMessage() {
    _messages.clear();
    notifyListeners();
  }
}
