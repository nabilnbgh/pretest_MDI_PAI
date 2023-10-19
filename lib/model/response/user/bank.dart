import 'package:json_annotation/json_annotation.dart';
part 'bank.g.dart';

@JsonSerializable()
class Bank {
  String? cardExpire;
  String? cardNumber;
  String? cardType;
  String? currency;
  String? iban;

  Bank({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });


  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);
}
