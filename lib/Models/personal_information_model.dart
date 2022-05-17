// To parse this JSON data, do
//
//     final personalInformationModel = personalInformationModelFromJson(jsonString);

import 'dart:convert';

PersonalInformationModel personalInformationModelFromJson(String str) =>
    PersonalInformationModel.fromJson(json.decode(str));

String personalInformationModelToJson(PersonalInformationModel data) =>
    json.encode(data.toJson());

class PersonalInformationModel {
  PersonalInformationModel({
    this.email,
    this.firstName,
    this.billing,
  });

  String? email;
  String? firstName;
  Billing? billing;

  factory PersonalInformationModel.fromJson(Map<String, dynamic> json) =>
      PersonalInformationModel(
        email: json["email"],
        firstName: json["first_name"],
        billing: Billing.fromJson(json["billing"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "billing": billing!.toJson(),
      };
}

class Billing {
  Billing({
    this.phone,
  });

  String? phone;

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}
