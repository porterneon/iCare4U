import 'package:flutter/material.dart';
import 'package:icare4u_ui/services/validators.dart';
import 'package:icare4u_ui/constants.dart';

class InputEmailField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<String> onChanged;
  final IconData iconData;
  final bool obscureText;
  final TextInputType textInputType;

  InputEmailField(
      {Key key,
      this.labelText,
      this.hintText,
      this.iconData,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
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
          // height: 60.0,
          child: TextFormField(
            validator: (String value) {
              var errorMessage = "";
              bool isValid = true;
              if (!Validators.isValidEmail(value)) {
                errorMessage = "Email has incorrect format.";
                isValid = false;
              }

              // add more validation conditions

              return !isValid ? errorMessage : null;
            },
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
              errorStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
