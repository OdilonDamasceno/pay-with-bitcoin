import 'package:flutter/material.dart';
import 'package:pay_with_bitcoin/databases/db_database.dart';
import 'package:pay_with_bitcoin/models/user_model.dart';
import 'package:pay_with_bitcoin/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var db = new DB();
    var _backgroundColor = Theme.of(context).backgroundColor;
    var _formController = TextEditingController();

    void _insertUserAndPushPage() async {
      await db.insertUser(new User(_formController.text));
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return HomePage();
      }));
    }

    void _validateInputs() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
      }
    }

    void _showDialog() {
      showDialog(
        context: context,
        child: AlertDialog(
          content: Text('This is a bitcoin testnet address, continue?'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'cancel',
                style: TextStyle(color: Colors.red[600]),
              ),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('continue'),
              onPressed: _insertUserAndPushPage,
            ),
          ],
        ),
      );
    }

    String _validator(value) {
      var main = RegExp(r'^[13][a-km-zA-HJ-NP-Z0-9]{26,33}$');
      var test = RegExp(r'^[mn2][a-km-zA-HJ-NP-Z0-9]{26,34}$');
      if (!main.hasMatch(value) && !test.hasMatch(value)) {
        return 'Invalid bitcoin address';
      } else if (test.hasMatch(value)) {
        _showDialog();
        return "";
      } else {
        _insertUserAndPushPage();
        return "";
      }
    }

    return Material(
      child: ListView(
        padding: EdgeInsets.only(top: 200, left: 30, right: 30),
        primary: false,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 90,
              backgroundColor: Colors.yellow[800],
              backgroundImage: AssetImage('assets/bitcoin.png'),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Welcome to new\nPayment\nMethod',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _formController,
              validator: _validator,
              decoration: InputDecoration(
                hintText: 'Ex.: 1Dfaaklj45oiAxoEwoc93s9ytv92kcsO',
                labelText: 'Address',
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          FloatingActionButton(
            elevation: 2,
            isExtended: true,
            onPressed: _validateInputs,
            child: Text(
              'Login',
              style: TextStyle(color: _backgroundColor, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
