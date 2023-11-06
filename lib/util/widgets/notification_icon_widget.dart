import 'package:famelink/providers/NotificationProvider/famelink_notification_provider.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../networking/config.dart';
import '../../ui/notification/notification_screen.dart';

class NotificationIconWidget extends StatefulWidget {
  const NotificationIconWidget({Key? key}) : super(key: key);

  @override
  State<NotificationIconWidget> createState() => _NotificationIconWidgetState();
}

class _NotificationIconWidgetState extends State<NotificationIconWidget> {

  IO.Socket? socket;



  @override
  void initState() {
    setSocket();
    super.initState();
  }



  void setSocket() async {
    var token = Constants.token;
    socket = IO.io(
        '${ApiProvider.shareUrl}',
        IO.OptionBuilder()
            .enableReconnection()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setExtraHeaders({
          'Authorization': token,
        })
            .build());
// Connect to websocket
    socket!.connect();
    socket!.onConnect((_) {
      print('connect');
    });
    print('connect:::${socket!.connected}');

    socket!.on('unreadMessage', (data) {
      Provider.of<GetNotificationProvider>(context,listen: false).changeUnreadMessage(true);
    });
    socket!.on('unreadNotifications', (data) {
      Provider.of<GetNotificationProvider>(context,listen: false).changeUnreadNotifications(true);
    });

    socket!.onConnectError((data) {
      print("ConnectError:::${data}");
      socket!.connect();
    });
    socket!.onError((data) {
      print("Error:::${data}");
    });
    socket!.onConnectTimeout((data) {
      print("ConnectTimeout:::${data}");
      socket!.connect();
    });
    socket!.emit('checkUnread', "");
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<GetNotificationProvider>(builder: (context,provider,child){
      return Padding(
        padding: EdgeInsets.only(
            bottom: 10.h,
            right: 28.5.w),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NotificationScreen()),
            );
          },
          child: Container(
              child:
              provider.isUnreadNotifications ==
                  true
                  ? SvgPicture
                  .asset(
                'assets/icons/Notifications.svg',
                height: 24,
                width: 24,
                fit: BoxFit
                    .fill,
              )
                  : SvgPicture
                  .asset(
                'assets/icons/Vector.svg',
                height: 20,
                width: 18,
                fit: BoxFit
                    .fill,
              )),
        ),
      );
    });
  }
}
