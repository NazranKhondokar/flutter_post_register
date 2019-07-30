import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const ReusableButton({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child:
              Text(title, style: TextStyle(fontSize: 15, color: Colors.white)),
        ),
      ),
    );
  }
}
