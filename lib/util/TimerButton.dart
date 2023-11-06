import 'dart:async';

import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';


enum ButtonType { RaisedButton, FlatButton, OutlineButton }

class TimerButton extends StatefulWidget {
  final String? label;

  final int? timeOutInSeconds;

  final VoidCallback? onPressed;

  final Color color;

  final Color? disabledColor;

  final TextStyle activeTextStyle;

  final TextStyle disabledTextStyle;

  final ButtonType buttonType;

  const TimerButton({
    this.label,
    this.onPressed,
    this.timeOutInSeconds,
    this.color = Colors.blue,
    this.disabledColor,
    this.buttonType = ButtonType.RaisedButton,
    this.activeTextStyle = const TextStyle(color: Colors.white),
    this.disabledTextStyle = const TextStyle(color: Colors.black45),
  })  : assert(label != null),
        assert(activeTextStyle != null),
        assert(disabledTextStyle != null);

  @override
  _TimerButtonState createState() => new _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  bool timeUpFlag = false;
  String timeText = "0s";
  int timeCounter = 0;

  @override
  void initState() {
    super.initState();
    timeCounter = widget.timeOutInSeconds!;
    timeText = "${timeCounter}s";
    timerUpdate();
  }

  timerUpdate() {
    new Timer(const Duration(seconds: 1), () async {
      setState(() {
        timeCounter--;
        timeText = "${timeCounter}s";
      });
      if (timeCounter != 0)
        timerUpdate();
      else {
        if(Constants.re_tries < 3)
          timeUpFlag = true;
        else {
          timeUpFlag = false;
          Constants.re_tries = 0;
        }
      }
    });
  }

  Widget getChild() {
    return new Container(
      child: timeUpFlag
          ? new Text(
        "    " + widget.label! + "    ",
        style: (widget.buttonType == ButtonType.OutlineButton)
            ? widget.activeTextStyle.copyWith(color: widget.color)
            : widget.activeTextStyle,
      )
          : new Text(widget.label! + " |  " + timeText, style: widget.disabledTextStyle),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timerUpdate();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.buttonType) {
      case ButtonType.RaisedButton:
        return new MaterialButton(
          disabledColor: widget.disabledColor,
          color: widget.color,
          onPressed: timeUpFlag
              ? () {
            widget.onPressed!();
              Constants.re_tries++;
              timeUpFlag = false;
              timeCounter = widget.timeOutInSeconds!;
              timeText = "${timeCounter}s";
              timerUpdate();

          }
              : null,
          child: getChild(),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3)
          ),
          elevation: 8,
        );
        break;
      case ButtonType.FlatButton:
        return new MaterialButton(
            color: widget.color,
            disabledColor: widget.disabledColor,
            onPressed: timeUpFlag
                ? () {
              widget.onPressed!();
            }
                : null,
            child: getChild());
        break;
      case ButtonType.OutlineButton:
        return new OutlinedButton(
            // borderSide: new BorderSide(
            //   color: widget.color,
            // ),
            // disabledBorderColor: widget.disabledColor,
            onPressed: timeUpFlag
                ? () {
              widget.onPressed!();
            }
                : null,
            child: getChild());
        break;
    }

    return new Container();
  }
}