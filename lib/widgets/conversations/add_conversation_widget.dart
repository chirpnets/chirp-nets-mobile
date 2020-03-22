import 'package:chirp_nets/utils/text.dart';
import 'package:chirp_nets/widgets/common/delete_alert_dialog.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/conversations.dart';

class AddConversationWidget extends StatefulWidget {
  final Conversations conversationData;
  final User user;
  final Conversation conversation;

  AddConversationWidget({this.conversationData, this.user, this.conversation});

  @override
  AddConversationWidgetState createState() {
    return AddConversationWidgetState();
  }
}

class AddConversationWidgetState extends State<AddConversationWidget> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {'name': null, 'networkId': null};

  void addConversation(
      Conversations conversationData, User user, String name, int networkId, ctx) {
    if (name.isEmpty || networkId == null) {
      return;
    }
    if (widget.conversation != null) {
      conversationData.updateConversation(
        widget.conversation.id,
        name,
        networkId,
      );
    } else {
      Conversation conv = Conversation(
        userId: user.id,
        name: name,
        networkId: networkId,
      );
      conversationData.addConversation(
        conv.userId,
        conv.name,
        conv.networkId,
      );
    }
    Navigator.pop(ctx);
  }

  void deleteConversation(conversation, provider, ctx) {
    showDialog(
      context: ctx,
      child: DeleteAlertDialog(
        title:
            'Are you sure?\nThis will delete all messages associated with this conversation',
        id: conversation.id,
        onDelete: widget.conversationData.deleteConversation,
      ),
    ).then((_) {
      Navigator.of(ctx).pop();
    });
  }

  void submitForm(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(formData);
      addConversation(
        widget.conversationData,
        widget.user,
        formData['name'],
        int.parse(formData['networkId']),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /* What does this do? */
    // if (conversation != null) {
    //   textController.text = conversation.name;
    //   textController.selection = TextSelection(
    //     baseOffset: 0,
    //     extentOffset: conversation.name.length,
    //   );
    //   networkIdController.text = conversation.networkId.toString();
    // }
    return Form(
      key:_formKey,
      child:Container(
      height: MediaQuery.of(context).size.height/3.5,
      child: Card(
        color: Theme.of(context).accentColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                style: Theme.of(context).textTheme.body1,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.body1,
                  hasFloatingPlaceholder: true,
                  hintText: groupPrompt,
                ),
                onSaved: (String value) {
                  formData['name'] = value;
                },

              ),
              TextFormField(
                autofocus: false,
                style: Theme.of(context).textTheme.body1,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.body1,
                  hasFloatingPlaceholder: true,
                  hintText: networkPrompt,
                ),
                onSaved: (String value) {
                  formData['networkId'] = value;
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: RaisedButton(
                  onPressed: () => {
                    submitForm(context)
                  },
                  color: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.add_comment,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
              ),
              if (widget.conversation != null)
                Container(
                  child: RaisedButton(
                    child: Icon(
                      Icons.delete_forever,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => this.deleteConversation(
                       widget. conversation, widget.conversationData, context),
                  ),
                )
            ],
          ),
        ),
      ),
    )
    );
  }
}
