import 'dart:convert';

class OrganizationModel {
  int organizationId;
  String avatar;
  String name;
  String? twitter;
  String? instagram;
  String? facebook;
  String? customUrl;
  bool foundation;
  DateTime createdAt;
  bool verified;
  int createdBy;
  List<int> moneyCollections;

  OrganizationModel({
    required this.organizationId,
    required this.avatar,
    required this.name,
    required this.twitter,
    required this.instagram,
    required this.facebook,
    required this.customUrl,
    required this.foundation,
    required this.createdAt,
    required this.verified,
    required this.createdBy,
    required this.moneyCollections,
  });

  factory OrganizationModel.fromRawJson(String str) => OrganizationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrganizationModel.fromJson(Map<String, dynamic> json) => OrganizationModel(
        organizationId: json["organization_id"],
        avatar: json["avatar"],
        name: json["name"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        facebook: json["facebook"],
        customUrl: json["customURL"],
        foundation: json["foundation"],
        createdAt: DateTime.parse(json["created_at"]),
        verified: json["verified"],
        createdBy: json["created_by"],
        moneyCollections: List<int>.from(json["money_collections"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "organization_id": organizationId,
        "avatar": avatar,
        "name": name,
        "twitter": twitter,
        "instagram": instagram,
        "facebook": facebook,
        "customURL": customUrl,
        "foundation": foundation,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "verified": verified,
        "created_by": createdBy,
        "money_collections": List<dynamic>.from(moneyCollections.map((x) => x)),
      };
}
