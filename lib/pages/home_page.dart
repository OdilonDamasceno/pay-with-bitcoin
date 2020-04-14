import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pay_with_bitcoin/databases/db_database.dart';
import 'package:pay_with_bitcoin/pages/add_item_page.dart';
import 'package:pay_with_bitcoin/pages/details_page.dart';
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

  _detailsPage(int index) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Details(
        index: index,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _pixel= MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;
    final _body = <Widget>[
      FutureBuilder(
        future: db.getProduct(),
        builder: (_, snapshot) {
          return snapshot.hasData
              ? snapshot.data.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: _pixel*173,
                        ),
                        child: Center(
                          child: CustomRichText(
                            simpleText: "Without itens",
                            presText: "Add Item",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => AddItem()),
                              );
                            },
                            pressStyle: TextStyle(
                              color: Colors.yellow[900],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            simpleStyle: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        var _image =
                            FileImage(File(snapshot.data[index]['image']));
                        return Container(
                          height: 260,
                          child: Card(
                            elevation: 2,
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      _detailsPage(index);
                                    },
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: _image,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${snapshot.data[index]['name']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '${snapshot.data[index]['price']} BTC',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.yellow[900],
                                            ),
                                            child: FlatButton(
                                              onPressed: () {},
                                              child: Text(
                                                'BUY',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
              : Center(child: CircularProgressIndicator());
        },
      ),
      Material(
        child: Center(
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AddItem()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return Future<void>(() {
            setState(() {});
          });
        },
        child: _body[_currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (int i = 1; i <= 10; i++) {
            db.deleteItem(i);
          }
          setState(() {});
        },
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
