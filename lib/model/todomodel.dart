class Todo {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Todo( this._title, 
        this._priority, 
        this._date, 
        [this._description] ///square brackets denotes optional
        );

  Todo.withID(this._id,
              this._title, 
              this._priority, 
              this._date, 
              [this._description] ///square brackets denotes optional
              );

  //getters
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  //setters
  set title(String newTitle) {
    if(newTitle.length <= 255) {
      _title = newTitle;
    }
  }
  set description(String newDescription) {
    if(description.length <= 255) {
      _description = newDescription;
    }
  }
  set priority(int newPriority) {
    if(newPriority > 0 && newPriority <=3 ) {
      _priority = newPriority;
    }
  }
  set date(String newDate) {
    _date = newDate;
  }
  
  //Map is a type of dictionary in ios
  Map <String, dynamic> toMap() {
    var map = Map <String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date; 

    if(_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Todo.fromObject(dynamic obj) {
    this._id = obj["id"];
    this._title = obj["title"];
    this._description = obj["description"];
    this._priority = obj["priority"];
    this.date = obj["date"];
  }
}