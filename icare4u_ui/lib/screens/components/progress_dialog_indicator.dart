import 'package:flutter/material.dart';
import 'package:icare4u_ui/constants.dart';

class ProgressDialogIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: globalBackgroundColor,
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.blue[200],
          borderRadius: new BorderRadius.circular(10.0),
        ),
        width: 300.0,
        height: 200.0,
        alignment: AlignmentDirectional.center,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20.0),
            new Text("Loading"),
          ],
        ),
      ),
    );
  }
}
