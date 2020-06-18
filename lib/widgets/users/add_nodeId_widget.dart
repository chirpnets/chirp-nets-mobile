import 'package:chirp_nets/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:chirp_nets/models/user.dart';
import 'package:chirp_nets/providers/users.dart';

class SetUserInfoWidget extends StatefulWidget {
  final User user;
  final Users userData;
  SetUserInfoWidget({this.user, this.userData});

  @override
  SetUserInfoWidgetState createState() {
    return SetUserInfoWidgetState();
  }
}

class SetUserInfoWidgetState extends State<SetUserInfoWidget> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {'name': null, 'nodeId': null};

  void saveUser(String name, int nodeId, ctx) {
    if (name.isEmpty || nodeId == null) {
      return;
    }
    widget.userData.updateUser(widget.user.id, name:name, nodeId:nodeId);
    Navigator.pop(ctx);
  }

  void submitForm(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      saveUser(
        formData['name'],
        int.parse(formData['nodeId']),
        context,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
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
              Align(
                alignment: Alignment.center,
                child: new Text(
                  nameAndNodeIDPrompt,
                  style: TextStyle(
                    fontSize: 20
                  )
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                autofocus: true,
                style: Theme.of(context).textTheme.body1,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.body1,
                  hasFloatingPlaceholder: true,
                  hintText: namePrompt,
                ),
                onSaved: (String value) {
                  formData['name'] = value;
                },
                validator: (value) {
                if (value.isEmpty) {
                  return nameError;
                }
                return null;
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
                  hintText: nodePrompt,
                ),
                onSaved: (String value) {
                  formData['nodeId'] = value;
                },
                validator: (value) {
                  if (value == null) {
                    return nodeIDErrorMessage;
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                child: new Text('OK'),
                  onPressed: () {
                    submitForm(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}
