import 'dart:math';

import 'package:chirp_nets/widgets/users/bubble_widget.dart';
import 'package:flutter/material.dart';

class BubbleGroupWidget extends StatelessWidget {
  final hint;
  final int userCount;
  const BubbleGroupWidget({Key key, this.hint, this.userCount = 4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = Random().nextInt(6);
    return Transform.translate(
      offset: Offset(-25, 0),
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(3, -3),
            child: BubbleWidget(
              colourIndex: index,
              isBackground: true,
            ),
          ),
          Transform.translate(
            offset: Offset(0, 0),
            child: BubbleWidget(
              hint: hint,
              colourIndex: (index+1)%6,
            ),
          ),
        ],
      ),
    );
  }
}
