import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/screens/compass_screen.dart';
import 'package:chirp_nets/widgets/messages/messages_list_widget.dart';
import 'package:chirp_nets/widgets/messages/message_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/providers/messages.dart';

class MessagesScreen extends StatelessWidget {
  static const routeName = '/messages';
  final scrollController = ScrollController();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Conversation conversation = routeArgs['conversation'];
    final Messages messageData = Provider.of<Messages>(context);
    final Users userProvider = Provider.of<Users>(context);
    List<int> userIds = messageData.getUserIds(conversation.id);
    var users = userProvider.users;
    users.removeWhere((id, user) => !userIds.contains(id));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          conversation.name,
          style: Theme.of(context).textTheme.title,
        ),
        backgroundColor: Theme.of(context).canvasColor,
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pushNamed(
              CompassScreen.routeName,
              arguments: {
                'users': users,
              },
            ),
            child: Icon(
              Icons.location_on,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          MessagesListWidget(
            scrollController: scrollController,
            user: userProvider.currentUser,
            conversation: conversation,
            messageData: messageData,
          ),
          MessageInputWidget(
            conversation: conversation,
            messageData: messageData,
            user: userProvider.currentUser,
            textController: textController,
          ),
        ],
      ),
    );
  }
}
