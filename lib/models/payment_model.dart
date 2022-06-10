class PaymentModel {
  int? id;
  String? name;
  String? number;
  String? bank;
  String? image;
  String? createdAt;
  String? updatedAt;

  PaymentModel({
    this.id,
    this.name,
    this.number,
    this.bank,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    bank = json['bank'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['bank'] = bank;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
