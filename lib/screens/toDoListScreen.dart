import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist/models/to_do_model.dart';
import 'package:flutter_todolist/screens/post_to_do_item.dart';
import 'package:flutter_todolist/utilities/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ToDoModel> todoListArray = null;

  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todoListArray == null) {
      todoListArray = new List();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: populateListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigationDetailsView(ToDoModel("", "", "", ""), "Add New Item");
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //Getting data from database into our array
  updateListView() async {
    todoListArray = await databaseHelper.getModelsFromMapList();
    setState(() {
      todoListArray = todoListArray;
      count = todoListArray.length;
    });
  }

  ListView populateListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          ToDoModel toDoModel = this.todoListArray[index];
          return Card(
            color: toDoModel.status == "Pending" ? Colors.red : Colors.green,
            child: ListTile(
              title: Text(toDoModel.title),
              subtitle: Text(toDoModel.description),
            ),
          );
        });
  }

  navigationDetailsView(ToDoModel toDoModel, String appBarTitle) async {
    bool results =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PostToDoListItem(toDoModel, appBarTitle);
    }));
    if (results) {
      updateListView();
      //Update Data
    }
  }
}
