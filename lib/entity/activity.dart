class Activity {
  int? id;
  String date;
  String description;

  Activity({this.id, required this.date, required this.description});

  // Convertir objeto Activity a Map para SQLite
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'date': date,
      'description': description,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Crear un objeto Activity desde un Map
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'],
      date: map['date'],
      description: map['description'],
    );
  }
}
