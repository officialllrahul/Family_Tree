import 'dart:convert';

ChildModel childModelFromJson(String str) => ChildModel.fromJson(json.decode(str));

String childModelToJson(ChildModel data) => json.encode(data.toJson());

class ChildModel {
  String? cId;
  String? cAge;
  String? cGender;
  String? pId;
  String? cName;
  String? gfId;

  ChildModel({
    this.cId,
    this.cAge,
    this.cGender,
    this.pId,
    this.cName,
    this.gfId,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) => ChildModel(
    cId: json["c_id"],
    cAge: json["c_age"],
    cGender: json["c_gender"],
    pId: json["p_id"],
    cName: json["c_name"],
    gfId: json["gf_id"],
  );

  Map<String, dynamic> toJson() => {
    "c_id": cId,
    "c_age": cAge,
    "c_gender": cGender,
    "p_id": pId,
    "c_name": cName,
    "gf_id": gfId,
  };
}
