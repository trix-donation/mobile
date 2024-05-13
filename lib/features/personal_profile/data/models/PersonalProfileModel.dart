import 'dart:convert';

class PersonalProfileModel {
  int? id;
  dynamic lastLogin;
  String email;
  dynamic name;
  dynamic surname;
  DateTime? registrationDate;
  bool? admin;
  dynamic avatar;
  bool? blocked;
  int? declinedRequestCounter;

  PersonalProfileModel({
    this.id,
    this.lastLogin,
    required this.email,
    this.name,
    this.surname,
    this.registrationDate,
    this.admin,
    this.avatar,
    this.blocked,
    this.declinedRequestCounter,
  });

  factory PersonalProfileModel.fromRawJson(String str) =>
      PersonalProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PersonalProfileModel.fromJson(Map<String, dynamic> json) => PersonalProfileModel(
        id: json["id"],
        lastLogin: json["last_login"],
        email: json["email"],
        name: json["name"],
        surname: json["surname"],
        registrationDate:
            json["registration_date"] == null ? null : DateTime.parse(json["registration_date"]),
        admin: json["admin"],
        avatar: json["avatar"],
        blocked: json["blocked"],
        declinedRequestCounter: json["declined_request_counter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_login": lastLogin,
        "email": email,
        "name": name,
        "surname": surname,
        "registration_date": registrationDate?.toIso8601String(),
        "admin": admin,
        "avatar": avatar,
        "blocked": blocked,
        "declined_request_counter": declinedRequestCounter,
      };
}
