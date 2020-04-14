import 'package:flutter/material.dart';
import 'package:pay_with_bitcoin/pages/home_page.dart';
import 'databases/db_database.dart';
import 'pages/login_page.dart';

void main() {
  runApp(PWB());
}

class PWB extends StatefulWidget {
  @override
  _PWBState createState() => _PWBState();
}

class _PWBState extends State<PWB> {
  var db = new DB();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.yellow[900],
          secondary: Colors.yellow[900],
        ),
      ),
      initialRoute: '/',
      home: FutureBuilder(
        future: db.getCount(),
        builder: (_, snapshot) {
          return snapshot.data != 0
              ? snapshot.hasData ? HomePage() : Material()
              : LoginPage();
        },
      ),
    );
  }
}
