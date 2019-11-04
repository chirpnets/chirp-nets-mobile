import 'package:flutter/material.dart';

class TextSettingWidget extends StatelessWidget {
  final String title;
  final Function callback;
  final String value;
  final TextEditingController controller = TextEditingController();
  final provider;
  final object;

  TextSettingWidget(
      {this.title, this.callback, this.value, this.provider, this.object});

  @override
  Widget build(BuildContext context) {
    controller.text = value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(this.title),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: TextField(
            textCapitalization: TextCapitalization.words,
            controller: controller,
          ),
        ),
        RaisedButton(
            color: Theme.of(context).canvasColor,
            child: Icon(
              Icons.save,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => callback(controller.text, provider, object))
      ],
    );
  }
}
