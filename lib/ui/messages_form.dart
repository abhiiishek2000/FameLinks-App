import 'dart:async';

import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageForm extends StatefulWidget {
  final Function(String)? onSendMessage;

  final Function? onTyping;

  final Function? onStopTyping;
  final String? hint;

  const MessageForm({
    @required this.onSendMessage,
    @required this.onTyping,
    @required this.onStopTyping,
    @required this.hint,
  });

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  TextEditingController? _textEditingController;

  Timer? _typingTimer;

  bool _isTyping = false;

  void _sendMessage() {
    if (_textEditingController!.text.isEmpty) return;

    widget.onSendMessage!(_textEditingController!.text);
    setState(() {
      _textEditingController!.text = "";
    });
  }

  void _runTimer() {
    if (_typingTimer != null && _typingTimer!.isActive) _typingTimer!.cancel();
    _typingTimer = Timer(Duration(milliseconds: 600), () {
      if (!_isTyping) return;
      _isTyping = false;
      widget.onStopTyping!();
    });
    _isTyping = true;
    widget.onTyping!();
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(45),
          bottom: ScreenUtil().setHeight(19),
          right: ScreenUtil().setWidth(8)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4.0,
                    ),
                  ]),
              child: TextField(
                onChanged: (_) {
                  _runTimer();
                },
                onSubmitted: (_) {
                  _sendMessage();
                },
                controller: _textEditingController,
                minLines: 1,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                style: GoogleFonts.nunitoSans(
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.w400,
                    color: darkGray),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(5),
                        right: ScreenUtil().setWidth(5)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.25), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: lightRed, width: 1),
                    ),
                    hintText: widget.hint,
                    hintStyle: GoogleFonts.nunitoSans(
                        fontSize: ScreenUtil().setSp(12),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: lightGray)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(26)),
            child: IconButton(
              onPressed: _sendMessage,
              icon: SvgPicture.asset("assets/icons/svg/send.svg"),
              color: lightGray,
            ),
          ),
        ],
      ),
    );
  }
}
