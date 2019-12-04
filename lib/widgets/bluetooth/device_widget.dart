import 'package:flutter/material.dart';

class DeviceWidget extends StatelessWidget {
  const DeviceWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Howdy'),
          FlatButton(
            color: Theme.of(context).errorColor,
            onPressed: () => {},
            child: Icon(
              Icons.delete,
              color: Theme.of(context).iconTheme.color,
            ),
          )
        ],
      ),
    );
  }
}
