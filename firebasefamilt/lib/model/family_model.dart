class FamilyModel {
  final String familyId;
  final String name;
  final String relationShip;
  final String age;
  final String familyTitle;

  FamilyModel(
      {required this.familyId,
      required this.name,
      required this.age,
      required this.familyTitle,
      required this.relationShip}
      );

  factory FamilyModel.fromJson(Map<String, dynamic> json) => FamilyModel(
      familyId: json['familyId'],
      name: json['name'],
      age: json['age'],
      familyTitle: json['familyTitle'],
      relationShip: json['relationShip']);

  Map<String, dynamic> toMap() => {
        'familyId': familyId,
        'name': name,
        'relationShip': relationShip,
        'age': age,
        'familyTitle': familyTitle
      };
}
