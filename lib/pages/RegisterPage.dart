import 'package:flutter/material.dart';
import 'package:flutter_post_register/custom_widgets/ReusableButton.dart';
import 'package:flutter_post_register/models/RegisterData.dart';
import 'package:flutter_post_register/network/NetworkUtils.dart';
import 'package:validate/validate.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterData _data = RegisterData();
  bool _obscureText = true;

  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 characters.';
    }

    return null;
  }

  void _submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the register data.');
      print('First Name: ${_data.firstName}');
      print('Last Name: ${_data.lastName}');
      print('Phone Number: ${_data.phone}');
      print('E-mail: ${_data.email}');
      print('Password: ${_data.password}');

      NetworkUtils().registerPOSTRequest(context, _data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: this._formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Ian',
                          labelText: 'First Name',
                          border: OutlineInputBorder()),
                      onSaved: (String value) {
                        this._data.firstName = value;
                      }),
                  SizedBox(height: 12.0),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Hickson',
                          labelText: 'Last Name',
                          border: OutlineInputBorder()),
                      onSaved: (String value) {
                        this._data.lastName = value;
                      }),
                  SizedBox(height: 12.0),
                  TextFormField(
                      keyboardType: TextInputType
                          .phone, // Use phone input type for phone.
                      decoration: InputDecoration(
                          hintText: '01....',
                          labelText: 'Phone Number',
                          border: OutlineInputBorder()),
                      onSaved: (String value) {
                        this._data.phone = value;
                      }),
                  SizedBox(height: 12.0),
                  TextFormField(
                      keyboardType: TextInputType
                          .emailAddress, // Use email input type for emails.
                      decoration: InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'E-mail Address',
                          border: OutlineInputBorder()),
                      validator: this._validateEmail,
                      onSaved: (String value) {
                        this._data.email = value;
                      }),
                  SizedBox(height: 12.0),
                  TextFormField(
                      obscureText:
                          _obscureText, // Use secure text for passwords.
                      decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Enter your password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          border: OutlineInputBorder()),
                      validator: this._validatePassword,
                      onSaved: (String value) {
                        this._data.password = value;
                      }),
                  SizedBox(height: 12.0),
                  ReusableButton(
                    title: 'REGISTER',
                    onPressed: () {
                      setState(() {
                        _submit();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
