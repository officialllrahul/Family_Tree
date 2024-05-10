class Person {
  int? id;
  String name;
  String? relationship;
  int age;
  String familyTitles;
  bool isExpanded;


  Person({
    this.id,
    required this.name,
    this.relationship,
    required this.age,
    required this.familyTitles,
    bool? isExpanded,
  }) : isExpanded = isExpanded ?? false;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'relationship': relationship,
      'age': age,
      'family_title': familyTitles,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Person.fromMapObject(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'] ?? '',
        relationship = map['relationship'],
        age = map['age'] ?? 0,
        familyTitles = map['family_title'],
        isExpanded = false;
}
