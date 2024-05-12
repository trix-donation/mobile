class GetSelectedCollectionModel {
  int? id;
  Requisites? requisites;
  List<Organizations>? organizations;
  String? goalTitle;
  String? description;
  String? preview;
  bool? active;
  String? collectedAmountOnJar;
  String? collectedAmountOnPlatform;
  String? collectedAmountFromOtherRequisites;
  String? goalAmount;
  String? createdAt;

  GetSelectedCollectionModel(
      {this.id,
      this.requisites,
      this.organizations,
      this.goalTitle,
      this.description,
      this.preview,
      this.active,
      this.collectedAmountOnJar,
      this.collectedAmountOnPlatform,
      this.collectedAmountFromOtherRequisites,
      this.goalAmount,
      this.createdAt});

  GetSelectedCollectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requisites = json['requisites'] != null ? new Requisites.fromJson(json['requisites']) : null;
    if (json['organizations'] != null) {
      organizations = <Organizations>[];
      json['organizations'].forEach((v) {
        organizations!.add(new Organizations.fromJson(v));
      });
    }
    goalTitle = json['goal_title'];
    description = json['description'];
    preview = json['preview'];
    active = json['active'];
    collectedAmountOnJar = json['collected_amount_on_jar'];
    collectedAmountOnPlatform = json['collected_amount_on_platform'];
    collectedAmountFromOtherRequisites = json['collected_amount_from_other_requisites'];
    goalAmount = json['goal_amount'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.requisites != null) {
      data['requisites'] = this.requisites!.toJson();
    }
    if (this.organizations != null) {
      data['organizations'] = this.organizations!.map((v) => v.toJson()).toList();
    }
    data['goal_title'] = this.goalTitle;
    data['description'] = this.description;
    data['preview'] = this.preview;
    data['active'] = this.active;
    data['collected_amount_on_jar'] = this.collectedAmountOnJar;
    data['collected_amount_on_platform'] = this.collectedAmountOnPlatform;
    data['collected_amount_from_other_requisites'] = this.collectedAmountFromOtherRequisites;
    data['goal_amount'] = this.goalAmount;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Requisites {
  int? id;
  String? monobankJarLink;
  String? monobankJarNumber;
  String? paypalEmail;
  String? bitcoinWalletAddress;
  String? ethereumWalletAddress;
  String? usdtWalletAddress;
  Null? extJarId;
  int? moneyCollection;
  List<BankCards>? bankCards;
  List<OtherRequisites>? otherRequisites;

  Requisites(
      {this.id,
      this.monobankJarLink,
      this.monobankJarNumber,
      this.paypalEmail,
      this.bitcoinWalletAddress,
      this.ethereumWalletAddress,
      this.usdtWalletAddress,
      this.extJarId,
      this.moneyCollection,
      this.bankCards,
      this.otherRequisites});

  Requisites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    monobankJarLink = json['monobank_jar_link'];
    monobankJarNumber = json['monobank_jar_number'];
    paypalEmail = json['paypal_email'];
    bitcoinWalletAddress = json['bitcoin_wallet_address'];
    ethereumWalletAddress = json['ethereum_wallet_address'];
    usdtWalletAddress = json['usdt_wallet_address'];
    extJarId = json['extJarId'];
    moneyCollection = json['money_collection'];
    if (json['bank_cards'] != null) {
      bankCards = <BankCards>[];
      json['bank_cards'].forEach((v) {
        bankCards!.add(new BankCards.fromJson(v));
      });
    }
    if (json['other_requisites'] != null) {
      otherRequisites = <OtherRequisites>[];
      json['other_requisites'].forEach((v) {
        otherRequisites!.add(new OtherRequisites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['monobank_jar_link'] = this.monobankJarLink;
    data['monobank_jar_number'] = this.monobankJarNumber;
    data['paypal_email'] = this.paypalEmail;
    data['bitcoin_wallet_address'] = this.bitcoinWalletAddress;
    data['ethereum_wallet_address'] = this.ethereumWalletAddress;
    data['usdt_wallet_address'] = this.usdtWalletAddress;
    data['extJarId'] = this.extJarId;
    data['money_collection'] = this.moneyCollection;
    if (this.bankCards != null) {
      data['bank_cards'] = this.bankCards!.map((v) => v.toJson()).toList();
    }
    if (this.otherRequisites != null) {
      data['other_requisites'] = this.otherRequisites!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankCards {
  int? id;
  String? bankName;
  String? cardNumber;

  BankCards({this.id, this.bankName, this.cardNumber});

  BankCards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bank_name'];
    cardNumber = json['card_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_name'] = this.bankName;
    data['card_number'] = this.cardNumber;
    return data;
  }
}

class OtherRequisites {
  int? id;
  String? name;
  String? value;

  OtherRequisites({this.id, this.name, this.value});

  OtherRequisites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Organizations {
  int? organizationId;
  String? name;

  Organizations({this.organizationId, this.name});

  Organizations.fromJson(Map<String, dynamic> json) {
    organizationId = json['organization_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organization_id'] = this.organizationId;
    data['name'] = this.name;
    return data;
  }
}
