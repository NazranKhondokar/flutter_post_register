import 'package:flutter/material.dart';
import 'package:flutter_post_register/models/RegisterData.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';

const String BASE_URL = 'YOUR BASE URL';
const String TOKEN_VALUE = 'YOUR TOKEN VALUE';

class NetworkUtils {
  registerPOSTRequest(BuildContext context, RegisterData registerData) async {
    ProgressDialog pr;
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Registering...');
    pr.show();

    var url = '${BASE_URL}YOUR END POINT';
    print(url);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json', 'token': TOKEN_VALUE},
        body: json.encode({
          'first_name': registerData.firstName,
          'last_name': registerData.lastName,
          'mobile': registerData.phone,
          'email': registerData.email,
          'password': registerData.password
        }));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> registerResponse = jsonDecode(response.body);
      //print('status, ${loginResponse['status']}');
      pr.hide();
      _showDialog(context, registerResponse['status']);

      if (registerResponse['status'] == 'registered') {
        print('first_name, ${registerResponse['first_name']}');
        print('email, ${registerResponse['email']}');
      }
    }
    pr.hide();
  }

  void _showDialog(BuildContext context, String loginResponse) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset('assets/lit.gif'),
              title: Text(
                'Status',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                loginResponse,
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              onOkButtonPressed: () {
                Navigator.pop(context);
              },
              onlyOkButton: true,
            ));
  }
}
