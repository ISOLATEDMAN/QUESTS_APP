import 'package:flutter/material.dart';
import 'package:jdds/add_pag.dart';


class todo extends StatefulWidget {
  const todo({Key? key});

  @override
  State<todo> createState() => _todoState();
}

class _todoState extends State<todo> {
  List<ListItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: Text("Quests"),centerTitle: true,
          titleTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 30),backgroundColor: Color.fromARGB(255, 254, 254, 254)),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Dismissible(
                key: Key(items[index].id.toString()),
                onDismissed: (direction) {
                  _removeItem(index);
                },
                child: Container(

                  width: 200,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        items[index].title,
                        style: TextStyle(fontSize: 30),
                      ),
                      
                      Text(
                        items[index].content,
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeItem(index);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ListItem? newItem = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Adds()),
          );
          if (newItem != null) {
            _addNewItem(newItem);
 // Save tasks after adding a new item
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNewItem(ListItem newItem) {
    setState(() {
      items.add(newItem);
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index); // Save tasks after removing an item
    });
  }
}