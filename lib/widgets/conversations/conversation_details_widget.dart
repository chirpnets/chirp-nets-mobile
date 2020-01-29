import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/utils/utils.dart';
import 'package:chirp_nets/widgets/users/bubble_group_widget.dart';
import 'package:chirp_nets/widgets/users/bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    String displayMessage = '';
    String dateText = '';
    String displayName = '';
    Users userProvider = Provider.of<Users>(context);
    Messages messageProvider = Provider.of<Messages>(context);
    int userCount = messageProvider.getUserIds().length;
    String bubbleChars = '';
    if (message != null && message.message != null) {
      displayMessage = message.message.length < 40
          ? message.message
          : '${message.message.substring(0, 40)}...';
      dateText = getTimeSinceMessage(message.createdAt);
      displayName = userProvider.getUser(id: message.sentBy).name + ':';
      bubbleChars = displayName[0];
    }

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width*0.40,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            conversation.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            '$dateText',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: userCount <= 2
                              ? BubbleWidget(
                                  hint: bubbleChars,
                                )
                              : BubbleGroupWidget(
                                  hint: bubbleChars,
                                  userCount: userCount - 2,
                                ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '$displayName $displayMessage',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
