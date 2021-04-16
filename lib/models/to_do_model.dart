class ToDoModel {
  int id;
  String description;
  String title;
  String status;
  String date;

  ToDoModel(this.date, this.description, this.title, this.status);

  ToDoModel.withID(
      this.id, this.title, this.description, this.date, this.status);

  //Model to Map
  Map<String, dynamic> convertModelToMap() {
    Map<String, dynamic> map = new Map();

    if (id != null) map["id"] = id;

    map["title"] = title;
    map["date"] = date;
    map["status"] = status;
    map["description"] = description;

    return map;
  }

  //Map to Model
  ToDoModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    date = map["date"];
    status = map["status"];
  }
}
