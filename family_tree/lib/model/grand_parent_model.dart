

import 'dart:convert';

GrandParentModel grandParentModelFromJson(String str) => GrandParentModel.fromJson(json.decode(str));

String grandParentModelToJson(GrandParentModel data) => json.encode(data.toJson());

class GrandParentModel {
  String? gfAge;
  String? gfFamilyTree;
  String? gfGender;
  String? gfId;
  String? gfName;

  GrandParentModel({
    this.gfAge,
    this.gfFamilyTree,
    this.gfGender,
    this.gfId,
    this.gfName,
  });

  factory GrandParentModel.fromJson(Map<String, dynamic> json) => GrandParentModel(
    gfAge: json["gf_age"],
    gfFamilyTree: json["gf_familyTree"],
    gfGender: json["gf_gender"],
    gfId: json["gf_id"],
    gfName: json["gf_name"],
  );

  Map<String, dynamic> toJson() => {
    "gf_age": gfAge,
    "gf_familyTree": gfFamilyTree,
    "gf_gender": gfGender,
    "gf_id": gfId,
    "gf_name": gfName,
  };
}
