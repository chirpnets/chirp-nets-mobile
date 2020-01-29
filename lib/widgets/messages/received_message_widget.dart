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
  final bool newMessageGroup;
  ReceivedMessageWidget(
      {Key key, this.message, this.currentUser, this.newMessageGroup});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat(dateFormat);
    String date = formatter.format(message.createdAt);
    Users userProvider = Provider.of<Users>(context);
    String name = userProvider.users[message.sentBy].name;
    var width = MediaQuery.of(context).size.width * 0.5;
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 1.0),
            blurRadius: 2.0,
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft:
              newMessageGroup ? Radius.circular(3) : Radius.circular(10),
          topLeft: newMessageGroup ? Radius.circular(10) : Radius.circular(3),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: MessageWidget(
        isSent: false,
        newMessageGroup: newMessageGroup,
        name: name,
        date: date,
        message: message,
      ),
    );
  }
}
