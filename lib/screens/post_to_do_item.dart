import 'package:flutter/material.dart';
import 'package:flutter_todolist/models/to_do_model.dart';
import 'package:flutter_todolist/utilities/db_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class PostToDoListItem extends StatefulWidget {
  ToDoModel toDoModel;
  String appBarTitle;
  PostToDoListItem(this.toDoModel, this.appBarTitle);

  @override
  _PostToDoListItemState createState() =>
      _PostToDoListItemState(this.toDoModel, this.appBarTitle);
}

class _PostToDoListItemState extends State<PostToDoListItem> {
  ToDoModel toDoModel;
  String appBarTitle;
  var statusList = ["Pending", "Completed"];
  var selectedStatus = "Pending";

  TextEditingController _taskEditingController = TextEditingController();
  TextEditingController _taskDescription = TextEditingController();

  _PostToDoListItemState(this.toDoModel, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.appBarTitle),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Center(
              child: DropdownButton(
                value: selectedStatus,
                items: statusList.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            TextField(
              controller: _taskEditingController,
              decoration: InputDecoration(
                hintText: "Enter task name",
                labelText: "Task Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextField(
              controller: _taskDescription,
              decoration: InputDecoration(
                hintText: "Description",
                labelText: "Task Description",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.brown,
                onPressed: () {
                  validate();
                },
                child: Text('Add Task'),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  validate() {
    toDoModel.title = _taskEditingController.text;
    toDoModel.description = _taskDescription.text;
    toDoModel.status = selectedStatus;
    toDoModel.date = DateFormat.yMMMd().format(DateTime.now());

    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.insert(toDoModel);

    Navigator.pop(context, true);
  }
}
