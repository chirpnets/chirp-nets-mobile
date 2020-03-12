import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/widgets/users/bubble_widget.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key key,
    this.sameMessageGroup,
    this.name,
    this.date,
    this.isSent,
    this.message,
  }) : super(key: key);

  final bool sameMessageGroup;
  final String name;
  final String date;
  final bool isSent;
  final Message message;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.65;
    Offset offset;
    if (isSent) {
      offset = Offset(width * 0.95, -25);
    } else {
      offset = Offset(-17, -27);
    }
    return Stack(
      children: [
        if (!sameMessageGroup && !isSent)
          Transform.translate(
            offset: offset,
            child: BubbleWidget(
              colourIndex: message.sentBy % 6,
              hint: name.length > 0 ? name[0] : '',
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!sameMessageGroup)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.50,
                    ),
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Text(
                      '$date',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                ],
              ),
            Container(
              padding: sameMessageGroup
                  ? EdgeInsets.only(top: 10)
                  : EdgeInsets.all(2),
              child: Text(
                message.message,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
