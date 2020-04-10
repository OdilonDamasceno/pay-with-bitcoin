import 'package:flutter/material.dart';

import 'pages/login_page.dart';

void main() {
  runApp(PWB());
}

class PWB extends StatefulWidget {
  @override
  _PWBState createState() => _PWBState();
}

class _PWBState extends State<PWB> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.yellow[900],
          secondary: Colors.yellow[900],
          
        ),
      ),
      home: LoginPage(),
    );
  }
}
