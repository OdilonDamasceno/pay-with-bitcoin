import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_bitcoin/databases/db_database.dart';
import 'package:pay_with_bitcoin/models/item_model.dart';

class AddItem extends StatelessWidget {
  final db = new DB();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _insertItem() async {
      await db.insertNewItem(
        new Item(
          _descriptionController.text,
          '',
          _nameController.text,
          _valueController.text,
        ),
      );
      _descriptionController.text = '';
      _nameController.text = '';
      _valueController.text = '';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(20),
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product name',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            child: TextFormField(
              controller: _descriptionController,
              expands: true,
              maxLines: null,
              maxLength: 255,
              minLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _valueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Value',
              prefixText: "BTC ",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              text: 'Select the image ',
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: 'here',
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: TextStyle(
                    color: Colors.yellow[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.yellow[900],
            ),
            child: FlatButton(
              onPressed: _insertItem,
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
