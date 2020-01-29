import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/utils/utils.dart';
import 'package:chirp_nets/widgets/messages/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/models/message.dart';

class SentMessageWidget extends StatelessWidget {
  final Message message;
  final User user;
  final bool newMessageGroup;
  SentMessageWidget({Key key, this.message, this.user, this.newMessageGroup});

  @override
  Widget build(BuildContext context) {
    String date = getTimeSinceMessage(message.createdAt);
    var messageMargin = EdgeInsets.only(
      left: 10,
      right: 10,
      top: 5,
    );
    if (newMessageGroup) {
      messageMargin = EdgeInsets.only(
        left: 10,
        right: 10,
        top: 20,
      );
    }
    return Container(
      margin: messageMargin,
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 1.0),
            blurRadius: 2.0,
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: newMessageGroup ? Radius.circular(10) : Radius.circular(3),
          bottomRight:
              newMessageGroup ? Radius.circular(3) : Radius.circular(10),
        ),
        color: Theme.of(context).splashColor,
      ),
      child: MessageWidget(
        isSent: true,
        newMessageGroup: newMessageGroup,
        name: user.name,
        date: date,
        message: message,
      ),
    );
  }
}
