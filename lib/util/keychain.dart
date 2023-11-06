import 'package:flutter/cupertino.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

class KeyChainAccess {
  Future<void> putKeyChain({String? email}) async {
    print("================================> put ${email}");
    await FlutterKeychain.put(
        key: "com.fame.famelink-email", value: email ?? "");
  }

  Future<Map<String?, dynamic?>?> getKeyChain() async {
    var email = await FlutterKeychain.get(key: "com.fame.famelink-email");

    if (email == null) {
      return null;
    } else {
      return {"email": email};
    }
  }
}
