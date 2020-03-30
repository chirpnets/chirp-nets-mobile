import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/utils/text.dart';
import 'package:flutter/material.dart';

class AddNameToNewUserWidget extends StatefulWidget {
  final Users userData;
  final int userId;
  AddNameToNewUserWidget({this.userId, this.userData});
  @override
  AddNameToNewUserWidgetState createState() {
    return AddNameToNewUserWidgetState();
  }
}

class AddNameToNewUserWidgetState extends State<AddNameToNewUserWidget> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> formData = {'name': null};

  submitForm(BuildContext ctx) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.userData.updateUser(widget.userId, name: formData['name']);
      Navigator.of(ctx).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(5),
        color: Theme.of(context).accentColor,
        height: MediaQuery.of(context).size.height / 4.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(addNewUserNamePrompt),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
              ),
              child: TextFormField(
                initialValue: widget.userData.users[widget.userId] != null
                    ? widget.userData.users[widget.userId].name
                    : '',
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                style: Theme.of(context).textTheme.body1,
                onSaved: (String value) {
                  formData['name'] = value;
                },
                decoration: InputDecoration(
                  hintText: newUserNameHint,
                  hintStyle: Theme.of(context).textTheme.button,
                  hasFloatingPlaceholder: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return nameError;
                  }
                  return null;
                },
              ),
            ),
            RaisedButton(
              color: Theme.of(context).buttonColor,
              child: Text(ok),
              onPressed: () {
                submitForm(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
