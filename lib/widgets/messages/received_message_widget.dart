import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/utils/utils.dart';
import 'package:chirp_nets/widgets/messages/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final Message message;
  final User currentUser;
  final bool sameMessageGroup;
  ReceivedMessageWidget(
      {Key key, this.message, this.currentUser, this.sameMessageGroup});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat(dateFormat);
    String date = formatter.format(message.createdAt);
    Users userProvider = Provider.of<Users>(context);
    String name = userProvider.users[message.sentBy].name;
    var width = MediaQuery.of(context).size.width * 0.5;
    return Container(
      width: width,
      margin: EdgeInsets.only(top: 22, bottom: 5, left: 10, right: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0.0, 1),
            blurRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft:
              sameMessageGroup ? Radius.circular(10) : Radius.circular(3),
          topLeft: sameMessageGroup ? Radius.circular(3) : Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: MessageWidget(
        isSent: false,
        sameMessageGroup: !sameMessageGroup,
        name: name,
        date: date,
        message: message,
      ),
    );
  }
}
