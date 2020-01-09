import 'package:chirp_nets/utils/text.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/providers/users.dart';

class AddFirstUserWidget extends StatelessWidget {
  void createUserAndConversation(
      String name,
      Users users,
      String conversationName,
      Conversations conversations,
      BuildContext ctx) async {
    if (name.isNotEmpty && conversationName.isNotEmpty) {
      int id = users.currentUser.id;
      users.updateUser(id, name);
      conversations.addConversation(id, conversationName);
      Navigator.of(ctx).pop();
    }
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
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                addUserPrompt,
                style: Theme.of(context).textTheme.body1,
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
                        style: Theme.of(context).textTheme.body1,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.body1,
                          hasFloatingPlaceholder: true,
                          hintText: namePrompt,
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
                        style: Theme.of(context).textTheme.body1,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.body1,
                          hasFloatingPlaceholder: true,
                          hintText: groupPrompt,
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
                        color: Theme.of(context).buttonColor,
                        child: Icon(
                          Icons.add_comment,
                          color: Theme.of(context).iconTheme.color,
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
    );
  }
}
