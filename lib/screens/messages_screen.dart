import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/widgets/messages/messages_list_widget.dart';
import 'package:chirp_nets/widgets/messages/message_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/providers/messages.dart';

class MessagesScreen extends StatelessWidget {
  static const routeName = '/messages';
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Conversation conversation = routeArgs['conversation'];
    final Messages messageData = Provider.of<Messages>(context);
    final User user = Provider.of<Users>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          conversation.name,
          style: Theme.of(context).textTheme.title,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MessagesListWidget(
            scrollController: scrollController,
            user: user,
            conversation: conversation,
            messageData: messageData,
          ),
          MessageInputWidget(
            conversation: conversation,
            messageData: messageData,
            user: user,
          ),
        ],
      ),
    );
  }
}
