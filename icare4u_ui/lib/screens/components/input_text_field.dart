import 'package:flutter/material.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<String> onChanged;
  final IconData iconData;
  final bool obscureText;
  final TextInputType textInputType;

  InputTextField(
      {Key key,
      this.labelText,
      this.hintText,
      this.iconData,
      this.obscureText,
      this.textInputType,
      @required this.onChanged})
      : super(key: key);

  void _handleChange(val) {
    onChanged(val);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.labelText,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (val) {
              _handleChange(val);
            },
            obscureText: this.obscureText,
            keyboardType: this.textInputType,
            style: TextStyle(
              color: Colors.white,
              // fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                this.iconData,
                color: Colors.white,
              ),
              hintText: this.hintText,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
