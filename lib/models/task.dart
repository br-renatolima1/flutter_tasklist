class Task {
  String? id;
  String title;
  DateTime date;
  String? location;

  Task({
   this.id,
    required this.title,
    required this.date,
    this.location
  });

  Task.fromJson(Map<String, dynamic> json): 
    id = json['id'],
    title = json['title'],
    date = DateTime.parse(json['date']),
    location = json['location'];

  // TransacionABC.toJSON()
  Map<String, dynamic> toJson() => {
    'title' : title,
    'date' : date.toString(),
    'location' : location
  };

  static List<Task> listFromJson(Map<String, dynamic> json) {
    List<Task> tasks = [];
    json.forEach((key, value) {
      Map<String, dynamic> item = {"id" : key, ...value};
      tasks.add(Task.fromJson(item));
    });
    return tasks;
  }



}