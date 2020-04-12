import 'package:flutter/material.dart';
import 'package:pay_with_bitcoin/databases/db_database.dart';
import 'package:pay_with_bitcoin/widgets/rich.text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db = new DB();
  int _currentIndex = 0;

  List<BottomNavigationBarItem> _item() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('Itens')),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('User')),
    ];
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: db.getUser(1),
        builder: (_, snapshot) {
          return snapshot.data.productsList == ''
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 2.3,
                    ),
                    child: CustomRichText(
                      simpleText: "Without itens",
                      presText: "Add Item",
                      onTap: () {},
                      pressStyle: TextStyle(
                        color: Colors.yellow[900],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      simpleStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        elevation: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: _item(),
      ),
    );
  }
}
