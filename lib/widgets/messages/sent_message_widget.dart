import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/utils/utils.dart';
import 'package:chirp_nets/widgets/messages/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/models/message.dart';

class SentMessageWidget extends StatelessWidget {
  final Message message;
  final User user;
  final bool sameMessageGroup;
  SentMessageWidget({Key key, this.message, this.user, this.sameMessageGroup});

  @override
  Widget build(BuildContext context) {
    String date = getTimeSinceMessage(message.createdAt);
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0.0, 1),
            blurRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(3),
          bottomRight: Radius.circular(10),
        ),
        color: Theme.of(context).splashColor,
      ),
      child: MessageWidget(
        isSent: true,
        sameMessageGroup: !sameMessageGroup,
        name: user.name,
        date: date,
        message: message,
      ),
    );
  }
}
