import 'dart:convert';

class FoundedCollectionsModel {
  final int count;
  final String? next;
  final dynamic previous;
  final List<Result> results;

  FoundedCollectionsModel({
    required this.count,
    this.next,
    required this.previous,
    required this.results,
  });

  factory FoundedCollectionsModel.fromRawJson(String str) =>
      FoundedCollectionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FoundedCollectionsModel.fromJson(Map<String, dynamic> json) => FoundedCollectionsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  final int id;
  final String goalTitle;
  final String description;
  final String preview;
  final bool active;
  final String collectedAmountOnJar;
  final String collectedAmountOnPlatform;
  final String collectedAmountFromOtherRequisites;
  final String goalAmount;
  final DateTime createdAt;

  Result({
    required this.id,
    required this.goalTitle,
    required this.description,
    required this.preview,
    required this.active,
    required this.collectedAmountOnJar,
    required this.collectedAmountOnPlatform,
    required this.collectedAmountFromOtherRequisites,
    required this.goalAmount,
    required this.createdAt,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        goalTitle: json["goal_title"],
        description: json["description"],
        preview: json["preview"],
        active: json["active"],
        collectedAmountOnJar: json["collected_amount_on_jar"],
        collectedAmountOnPlatform: json["collected_amount_on_platform"],
        collectedAmountFromOtherRequisites: json["collected_amount_from_other_requisites"],
        goalAmount: json["goal_amount"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "goal_title": goalTitle,
        "description": description,
        "preview": preview,
        "active": active,
        "collected_amount_on_jar": collectedAmountOnJar,
        "collected_amount_on_platform": collectedAmountOnPlatform,
        "collected_amount_from_other_requisites": collectedAmountFromOtherRequisites,
        "goal_amount": goalAmount,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
      };
}
