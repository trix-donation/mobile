import 'dart:convert';

class GetSelectedCollectionModel {
  final int id;
  final Requisites? requisites;
  final List<Organization> organizations;
  final String goalTitle;
  final String description;
  final String? preview;
  final bool active;
  final String collectedAmountOnJar;
  final String collectedAmountOnPlatform;
  final String collectedAmountFromOtherRequisites;
  final String goalAmount;
  final DateTime createdAt;

  GetSelectedCollectionModel({
    required this.id,
    this.requisites,
    required this.organizations,
    required this.goalTitle,
    required this.description,
    this.preview,
    required this.active,
    required this.collectedAmountOnJar,
    required this.collectedAmountOnPlatform,
    required this.collectedAmountFromOtherRequisites,
    required this.goalAmount,
    required this.createdAt,
  });

  factory GetSelectedCollectionModel.fromRawJson(String str) =>
      GetSelectedCollectionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSelectedCollectionModel.fromJson(Map<String, dynamic> json) =>
      GetSelectedCollectionModel(
        id: json["id"],
        requisites: json["requisites"] != null ? Requisites.fromJson(json["requisites"]) : null,
        organizations: json["organizations"] == null
            ? []
            : List<Organization>.from(json["organizations"]!.map((x) => Organization.fromJson(x))),
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
        "requisites": requisites?.toJson(),
        "organizations":
            organizations == null ? [] : List<dynamic>.from(organizations!.map((x) => x.toJson())),
        "goal_title": goalTitle,
        "description": description,
        "preview": preview,
        "active": active,
        "collected_amount_on_jar": collectedAmountOnJar,
        "collected_amount_on_platform": collectedAmountOnPlatform,
        "collected_amount_from_other_requisites": collectedAmountFromOtherRequisites,
        "goal_amount": goalAmount,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
      };
}

class Organization {
  final int organizationId;
  final String name;

  Organization({
    required this.organizationId,
    required this.name,
  });

  factory Organization.fromRawJson(String str) => Organization.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
        organizationId: json["organization_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "organization_id": organizationId,
        "name": name,
      };
}

class Requisites {
  final int id;
  final String monobankJarLink;
  final String monobankJarNumber;
  final String? paypalEmail;
  final String? bitcoinWalletAddress;
  final String? ethereumWalletAddress;
  final String? usdtWalletAddress;
  final dynamic extJarId;
  final int? moneyCollection;
  final List<BankCard>? bankCards;
  final List<OtherRequisite>? otherRequisites;

  Requisites({
    required this.id,
    required this.monobankJarLink,
    required this.monobankJarNumber,
    this.paypalEmail,
    this.bitcoinWalletAddress,
    this.ethereumWalletAddress,
    this.usdtWalletAddress,
    this.extJarId,
    this.moneyCollection,
    this.bankCards,
    this.otherRequisites,
  });

  factory Requisites.fromRawJson(String str) => Requisites.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Requisites.fromJson(Map<String, dynamic> json) => Requisites(
        id: json["id"],
        monobankJarLink: json["monobank_jar_link"],
        monobankJarNumber: json["monobank_jar_number"],
        paypalEmail: json["paypal_email"],
        bitcoinWalletAddress: json["bitcoin_wallet_address"],
        ethereumWalletAddress: json["ethereum_wallet_address"],
        usdtWalletAddress: json["usdt_wallet_address"],
        extJarId: json["extJarId"],
        moneyCollection: json["money_collection"],
        bankCards: json["bank_cards"] == null
            ? []
            : List<BankCard>.from(json["bank_cards"]!.map((x) => BankCard.fromJson(x))),
        otherRequisites: json["other_requisites"] == null
            ? []
            : List<OtherRequisite>.from(
                json["other_requisites"]!.map((x) => OtherRequisite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "monobank_jar_link": monobankJarLink,
        "monobank_jar_number": monobankJarNumber,
        "paypal_email": paypalEmail,
        "bitcoin_wallet_address": bitcoinWalletAddress,
        "ethereum_wallet_address": ethereumWalletAddress,
        "usdt_wallet_address": usdtWalletAddress,
        "extJarId": extJarId,
        "money_collection": moneyCollection,
        "bank_cards":
            bankCards == null ? [] : List<dynamic>.from(bankCards!.map((x) => x.toJson())),
        "other_requisites": otherRequisites == null
            ? []
            : List<dynamic>.from(otherRequisites!.map((x) => x.toJson())),
      };
}

class BankCard {
  final int id;
  final String bankName;
  final String cardNumber;

  BankCard({
    required this.id,
    required this.bankName,
    required this.cardNumber,
  });

  factory BankCard.fromRawJson(String str) => BankCard.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankCard.fromJson(Map<String, dynamic> json) => BankCard(
        id: json["id"],
        bankName: json["bank_name"],
        cardNumber: json["card_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "card_number": cardNumber,
      };
}

class OtherRequisite {
  final int id;
  final String name;
  final String value;

  OtherRequisite({
    required this.id,
    required this.name,
    required this.value,
  });

  factory OtherRequisite.fromRawJson(String str) => OtherRequisite.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtherRequisite.fromJson(Map<String, dynamic> json) => OtherRequisite(
        id: json["id"],
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
      };
}
