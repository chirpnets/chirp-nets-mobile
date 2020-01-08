import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:intl/intl.dart';

class SentMessageWidget extends StatelessWidget {
  final Message message;
  final User user;
  SentMessageWidget({Key key, this.message, this.user});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat(dateFormat);
    String date = formatter.format(message.createdAt);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(3),
        ),
        color: Theme.of(context).highlightColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.50,
                ),
                margin: EdgeInsets.only(right: 40),
                child: Text(
                  message.message,
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              Container(
                child: Text(
                  '$date',
                  style: Theme.of(context).textTheme.caption,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
