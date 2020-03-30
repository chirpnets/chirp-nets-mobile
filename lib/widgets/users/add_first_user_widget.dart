import 'package:chirp_nets/providers/bluetooth.dart';
import 'package:chirp_nets/utils/text.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:provider/provider.dart';

class AddFirstUserWidget extends StatelessWidget {
  void createUserAndConversation(
      String name,
      int nodeId,
      Users users,
      String conversationName,
      Conversations conversations,
      BuildContext ctx) async {
    if (name.isNotEmpty && conversationName.isNotEmpty && nodeId != null) {
      Bluetooth bluetooth = Provider.of<Bluetooth>(ctx);
      int id = users.currentUser.id;
      users.updateUser(id, name: name, nodeId: nodeId);
      conversations.addConversation(id, conversationName, 1).then((id) {
        bluetooth.currentUser = users.currentUser;
        bluetooth.conversation = conversations.conversations[id];
        bluetooth.sendInitPacket();
      });

      Navigator.of(ctx).pop();
    }
  }

  AddFirstUserWidget({this.userData, this.conversationData});
  final Conversations conversationData;
  final Users userData;
  final TextEditingController userTextController = TextEditingController();
  final TextEditingController nodeTextController = TextEditingController();
  final TextEditingController conversationTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Theme.of(context).accentColor,
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
                        autofocus: true,
                        style: Theme.of(context).textTheme.body1,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.body1,
                          hasFloatingPlaceholder: true,
                          hintText: nodePrompt,
                        ),
                        controller: nodeTextController,
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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.body1,
                          hasFloatingPlaceholder: true,
                          hintText: groupPrompt,
                        ),
                        onSubmitted: (String message) =>
                            createUserAndConversation(
                          userTextController.text,
                          int.parse(nodeTextController.text),
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
                          int.parse(nodeTextController.text),
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
