import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  final Function onDelete;
  final int id;
  final String confirmText;
  final String cancelText;
  final String title;

  DeleteAlertDialog({
    Key key,
    this.onDelete,
    this.id,
    this.confirmText = 'Delete',
    this.cancelText = 'Cancel',
    this.title = 'Are you sure?',
  });

  void confirm(context, id) {
    onDelete(id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.subhead,
      ),
      backgroundColor: Theme.of(context).accentColor,
      actions: [
        RaisedButton(
          child: Text(
            confirmText,
            style: Theme.of(context).textTheme.body1,
          ),
          color: Theme.of(context).errorColor,
          onPressed: () => confirm(context, id),
        ),
        RaisedButton(
          child: Text(
            cancelText,
            style: Theme.of(context).textTheme.body1,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
