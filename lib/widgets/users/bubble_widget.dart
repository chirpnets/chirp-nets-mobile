import 'dart:math';

import 'package:chirp_nets/utils/theme.dart';
import 'package:flutter/material.dart';

class BubbleWidget extends StatelessWidget {
  final hint;
  final int colourIndex;
  final bool isBackground;
  BubbleWidget(
      {Key key, this.hint = '', this.colourIndex, this.isBackground = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).accentColor,
        ),
        borderRadius: BorderRadius.circular(30),
        color: colourIndex == null
            ? bubbleColours[Random().nextInt(6)]
            : bubbleColours[colourIndex],
      ),
      child: Center(
        child: Text(
          hint,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
