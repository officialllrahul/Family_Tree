import 'dart:convert';

ParentModel parentModelFromJson(String str) => ParentModel.fromJson(json.decode(str));

String parentModelToJson(ParentModel data) => json.encode(data.toJson());

class ParentModel {
  String? gfId;
  String? pAge;
  String? pGender;
  String? pId;
  String? pName;

  ParentModel({
    this.gfId,
    this.pAge,
    this.pGender,
    this.pId,
    this.pName,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) => ParentModel(
    gfId: json["gf_id"],
    pAge: json["p_age"],
    pGender: json["p_gender"],
    pId: json["p_id"],
    pName: json["p_name"],
  );

  Map<String, dynamic> toJson() => {
    "gf_id": gfId,
    "p_age": pAge,
    "p_gender": pGender,
    "p_id": pId,
    "p_name": pName,
  };
}
