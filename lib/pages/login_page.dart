import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
    var _backgroundColor = Theme.of(context).backgroundColor;
    void _validateInputs() {
      if (_formKey.currentState.validate()) {
        print('object');
        _formKey.currentState.save();
      } else {
        setState(() {
          _autovalidate = true;
        });
      }
    }

    String _validator(value) {
      var regex = RegExp(r'^[13][a-km-zA-HJ-NP-Z0-9]{26,33}$');
      if (!regex.hasMatch(value))
        return 'Invalid Address';
      else
        return 'Valid';
    }

    return Material(
      child: ListView(
        padding: EdgeInsets.only(top: 200, left: 30, right: 30),
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 90,
              backgroundColor: Colors.yellow[800],
              backgroundImage: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png',
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              validator: _validator,
              decoration: InputDecoration(
                hintText: 'Ex.: 1Dfaaklj45oiAxoEwoc93s9ytv92kcsO',
                labelText: 'Address',
              ),
              autovalidate: _autovalidate,
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
