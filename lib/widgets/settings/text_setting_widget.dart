import 'package:flutter/material.dart';

class TextSettingWidget extends StatefulWidget {
  final String title;
  final Function callback;
  final String value;
  // final TextEditingController controller = TextEditingController();
  final provider;
  final object;

  TextSettingWidget(
      {this.title, this.callback, this.value, this.provider, this.object});

  @override
  TextSettingWidgetState createState() {
    return TextSettingWidgetState();
  }
}

class TextSettingWidgetState extends State<TextSettingWidget> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {'value': null};

  @override
  Widget build(BuildContext context) {
    // controller.text = value;
    return Form(
      key: _formKey,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: TextFormField(
            initialValue: widget.value,
            validator: (value) {
              if (value.isEmpty) {
                return 'Cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              formData['value'] = value;
            },
            style: Theme.of(context).textTheme.body1,
            textCapitalization: TextCapitalization.words,
            // controller: controller,
          ),
        ),
        RaisedButton(
            color: Theme.of(context).buttonColor,
            child: Icon(
              Icons.save,
              color: Theme.of(context).highlightColor,
            ),
            onPressed: () => {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save(),
                widget.callback(formData['value'], widget.provider, widget.object, context)
              }
            }
            )
      ],
    )
    );
  }
}
