import 'package:flutter/material.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/widgets/message_widget.dart';

class Messages extends StatelessWidget {
  final List<Message> messages;
  Messages({this.messages});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ...this
              .messages
              .map((message) => MessageWidget(message: message))
              .toList()
        ],
      ),
    );
  }
}
