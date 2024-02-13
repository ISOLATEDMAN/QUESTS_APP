import 'package:flutter/material.dart';

class ListItem {
  int id;
  String title;
  String content;

  ListItem({required this.id, required this.title, required this.content});

  static fromJson(String taskString) {}
}

class Adds extends StatefulWidget {
  const Adds({Key? key}) : super(key: key);

  @override
  State<Adds> createState() => _AddsState();
}

class _AddsState extends State<Adds> {
  TextEditingController title = TextEditingController();
  TextEditingController contents = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("add list")),
      backgroundColor: Color.fromARGB(255, 255, 254, 254),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: title,
            decoration: InputDecoration(
              hintText: "title",
              hintStyle: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: contents,
            decoration: InputDecoration(
              hintText: "content",
              hintStyle: TextStyle(fontSize: 20),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Create a ListItem object with the entered data
              ListItem newItem = ListItem(
                id: DateTime.now().millisecondsSinceEpoch, // Use a unique identifier
                title: title.text,
                content: contents.text,
              );

              // Pass the data back to the home page
              Navigator.pop(context, newItem);
            },
            child: Text("submit"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.amber),
            ),
          ),
        ],
      ),
    );
  }
}
