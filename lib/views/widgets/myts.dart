import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/editable.dart';

class MTS extends TextSelectionControls {
  @override
  Widget buildHandle(BuildContext context, TextSelectionHandleType type,
      double textLineHeight) {
    return Icon(
      Icons.arrow_drop_up_rounded,
      color: Colors.purple,
      size: 50,
    );
  }

  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset position,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ClipboardStatusNotifier clipboardStatus,
      Offset lastSecondaryTapDownPosition) {
    print(textLineHeight);
    print(globalEditableRegion);
    return TextSelectionToolbar(
        anchorAbove: Offset(position.dx, position.dy + 400),
        anchorBelow: Offset(0, -140),
        toolbarBuilder: (context, _) {
          print("dy : ${position.dy} ");
          return position.dy>0 ? Container(
            color: Colors.yellow,
            child: TextSelectionToolbarTextButton(
              child: Text("child"),
              padding: EdgeInsets.all(0),
            ),
          ):
          Container();

          // return (position.dy > 30 && position.dy < 250)
          //     ?
          // : Container();
        },
        children: [Container()]);
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    return Offset(25, 20);
  }

  @override
  Size getHandleSize(double textLineHeight) {
    // TODO: implement getHandleSize
    return Size(0, 0);
  }
}
