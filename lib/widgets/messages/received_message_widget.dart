import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final Message message;
  final User currentUser;
  ReceivedMessageWidget({Key key, this.message, this.currentUser});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('MMM d H:mm');
    String date = formatter.format(message.createdAt);
    Users userProvider = Provider.of<Users>(context);
    String name = userProvider.users[message.sentBy].name;

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
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
          bottomLeft: Radius.circular(3),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              message.message,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  '$name',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              Container(
                child: Text(
                  '$date',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
