import 'package:flutter/material.dart';

import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/providers/users.dart';

class AddFirstUserWidget extends StatelessWidget {
  void createUserAndConversation(name, Users users, conversationName,
      Conversations conversations, BuildContext ctx) async {
    int id = await users.addUser(name);
    conversations.addConversation(id, conversationName);
    Navigator.of(ctx).pop();
  }

  AddFirstUserWidget({this.userData, this.conversationData});
  final Conversations conversationData;
  final Users userData;
  final TextEditingController userTextController = TextEditingController();
  final TextEditingController conversationTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Card(
          color: Theme.of(context).accentColor,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Enter your name, this will be displayed by your messages.',
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          autofocus: true,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            hasFloatingPlaceholder: true,
                            hintText: 'Enter Your Name...',
                          ),
                          controller: userTextController,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TextField(
                          autofocus: true,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            hasFloatingPlaceholder: true,
                            hintText: 'Enter Group Name...',
                          ),
                          onSubmitted: (String message) =>
                              createUserAndConversation(
                            userTextController.text,
                            userData,
                            message,
                            conversationData,
                            context,
                          ),
                          controller: conversationTextController,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: RaisedButton(
                          onPressed: () => createUserAndConversation(
                            userTextController.text,
                            userData,
                            conversationTextController.text,
                            conversationData,
                            context,
                          ),
                          color: Theme.of(context).canvasColor,
                          child: Icon(
                            Icons.add_comment,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createConversaton(String message, Users userData, BuildContext context) {}
}
