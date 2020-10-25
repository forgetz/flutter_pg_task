import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/services/api_connect.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username;
  String password;
  String appcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Login'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, Colors.blue],
              center: Alignment(0, -0.3),
              radius: 2.0,
            ),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.0),
                    userForm(),
                    SizedBox(height: 20.0),
                    passwordForm(),
                    SizedBox(height: 20.0),
                    appCodeForm(),
                    SizedBox(height: 20.0),
                    loginButton(),
                    SizedBox(height: 20.0),
                    Text('please connect vpn before login'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 300.0,
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () {
          print('username=$username appcode=$appcode');
          if ((username?.isEmpty ?? true) ||
              (password?.isEmpty ?? true) ||
              (appcode?.isEmpty ?? true)) {
            Get.snackbar(
              'Error',
              'Please fill username and password',
              backgroundColor: Colors.redAccent,
            );
          } else if (appcode != 'pg2020') {
            Get.snackbar(
              'Error',
              'Wrong appcode',
              backgroundColor: Colors.redAccent,
            );
          } else {
            authenLoginApi(context, username, password);
          }
        },
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget userForm() => Container(
        width: 300.0,
        child: TextField(
          onChanged: (value) => username = value.trim(),
          decoration: InputDecoration(
            labelText: 'Username : ',
            labelStyle: TextStyle(color: Colors.blue),
            prefixIcon: Icon(
              Icons.account_box_outlined,
              color: Colors.blue,
            ),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 300.0,
        child: TextField(
          obscureText: true,
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            labelText: 'Password : ',
            labelStyle: TextStyle(color: Colors.blue),
            prefixIcon: Icon(
              Icons.vpn_key_sharp,
              color: Colors.blue,
            ),
          ),
        ),
      );

  Widget appCodeForm() => Container(
        width: 300.0,
        child: TextField(
          obscureText: false,
          onChanged: (value) => appcode = value.trim(),
          decoration: InputDecoration(
            labelText: 'AppCode : ',
            labelStyle: TextStyle(color: Colors.blue),
            prefixIcon: Icon(
              Icons.vpn_key_sharp,
              color: Colors.blue,
            ),
          ),
        ),
      );
}
