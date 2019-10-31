import 'package:chirp_nets/models/user.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/models/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final User user;
  MessageWidget({Key key, this.message, this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: user.id == message.createdBy ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            width: 250,
            height: 60,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(
              right: 30,
              top: 10,
              bottom: 10,
              left: 5,
            ),
            decoration: BoxDecoration(
              color: user.id == message.createdBy
                  ? Theme.of(context).accentColor
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(message.message),
          ),
        ],
      ),
    );
  }
}
