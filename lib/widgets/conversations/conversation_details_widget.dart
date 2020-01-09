import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversationDetailsWidget extends StatelessWidget {
  const ConversationDetailsWidget({
    Key key,
    @required this.conversation,
    @required this.message,
  });

  final Conversation conversation;
  final Message message;

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('MMM d H:mm');
    String displayMessage = '';
    String dateText = '';
    if (message != null && message.message != null) {
      displayMessage = message.message.length < 30
          ? message.message
          : '${message.message.substring(0, 30)}...';
       dateText = formatter.format(message.createdAt);
    }

    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.bottomLeft,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).iconTheme.color,
                  size: 40,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      conversation.name,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$displayMessage',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 25, right: 10),
              alignment: Alignment.bottomRight,
              child: Text(
                '$dateText',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
