import 'dart:convert';

class UsersOrganizationsModel {
  int? organizationId;
  String? avatar;
  String? name;
  String? twitter;
  String? instagram;
  String? facebook;
  String? customUrl;
  bool? foundation;
  DateTime? createdAt;
  bool? verified;
  int? createdBy;
  List<int>? moneyCollections;

  UsersOrganizationsModel({
    this.organizationId,
    this.avatar,
    this.name,
    this.twitter,
    this.instagram,
    this.facebook,
    this.customUrl,
    this.foundation,
    this.createdAt,
    this.verified,
    this.createdBy,
    this.moneyCollections,
  });

  factory UsersOrganizationsModel.fromRawJson(String str) =>
      UsersOrganizationsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsersOrganizationsModel.fromJson(Map<String, dynamic> json) => UsersOrganizationsModel(
        organizationId: json["organization_id"],
        avatar: json["avatar"],
        name: json["name"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        facebook: json["facebook"],
        customUrl: json["customURL"],
        foundation: json["foundation"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        verified: json["verified"],
        createdBy: json["created_by"],
        moneyCollections: json["money_collections"] == null
            ? []
            : List<int>.from(json["money_collections"]!.map((x) => x)),
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
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "verified": verified,
        "created_by": createdBy,
        "money_collections":
            moneyCollections == null ? [] : List<dynamic>.from(moneyCollections!.map((x) => x)),
      };
}
