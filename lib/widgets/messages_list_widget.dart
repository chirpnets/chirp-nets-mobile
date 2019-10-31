import 'package:flutter/material.dart';

import 'package:chirp_nets/widgets/message_widget.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/models/user.dart';

class MessagesListWidget extends StatelessWidget {
  const MessagesListWidget({
    Key key,
    @required this.scrollController,
    @required this.messages,
    @required this.user,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<Message> messages;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        controller: scrollController,
        itemCount: messages.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext ctx, int index) {
          return MessageWidget(message: messages[index], user: user);
        },
      ),
    );
  }
}
