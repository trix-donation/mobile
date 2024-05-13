import 'dart:convert';

class MyOrganizationModel {
  String name;
  String twitter;
  String instagram;
  String facebook;
  String customUrl;
  dynamic avatar;

  MyOrganizationModel({
    required this.name,
    required this.twitter,
    required this.instagram,
    required this.facebook,
    required this.customUrl,
    required this.avatar,
  });

  factory MyOrganizationModel.fromRawJson(String str) =>
      MyOrganizationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyOrganizationModel.fromJson(Map<String, dynamic> json) => MyOrganizationModel(
        name: json["name"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        facebook: json["facebook"],
        customUrl: json["customURL"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "twitter": twitter,
        "instagram": instagram,
        "facebook": facebook,
        "customURL": customUrl,
        "avatar": avatar,
      };
}
