import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_with_bitcoin/databases/db_database.dart';
import 'package:pay_with_bitcoin/models/item_model.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final db = new DB();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File _image;

  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  String _validator(String value) {
    if (value.isEmpty) {
      return "It cannot be empty";
    }
  }

  @override
  Widget build(BuildContext context) {
    void _insertItem() async {
      await db.insertNewItem(
        new Item(
          _descriptionController.text,
          _image.path.toString(),
          _nameController.text,
          double.parse(_valueController.text.replaceAll(',', '.')),
        ),
      );

      _descriptionController.text = '';
      _nameController.text = '';
      _valueController.text = '';
      _image = null;
      setState(() {});
    }

    void _validateInputs() {
      if (_formKey.currentState.validate() && _image != null) {
        _insertItem();
      } else if (_image == null) {
        showDialog(
            context: context,
            child: AlertDialog(
              content: Text(
                'Image is required',
                style: TextStyle(fontSize: 17),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('close'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: FlatButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/');
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          primary: false,
          padding: EdgeInsets.all(20),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              validator: _validator,
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
                validator: _validator,
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
              validator: (value) {
                if (!(double.tryParse(value.replaceAll(',', '.')) is double)) {
                  return 'Invalid value';
                }
              },
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
                text: _image == null ? 'Select the image ' : 'Selected image: ',
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: _image == null
                        ? 'here'
                        : _image.uri
                            .pathSegments[_image.uri.pathSegments.length - 1],
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        getImage();
                      },
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
                onPressed: () {
                  _validateInputs();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
