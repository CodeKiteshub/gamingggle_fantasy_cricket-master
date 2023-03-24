import 'dart:convert';

/// aadhar_status : "0"
/// pan_status : "1"
/// total_amount : "100000.00"
/// credit_amount : "100000.00"
/// bonous_amount : "0.00"
/// winning_amount : "0.00"
/// credit_note : "Amount credit"
/// bonous_note : "Bonus credit"
/// winning_note : "Winning credit"

AccountDetails accountDetailsFromJson(String str) =>
    AccountDetails.fromJson(json.decode(str));

String accountDetailsToJson(AccountDetails data) => json.encode(data.toJson());

class AccountDetails {
  AccountDetails({
    String? aadharStatus,
    String? panStatus,
    String? totalAmount,
    String? creditAmount,
    String? bonousAmount,
    String? winningAmount,
    String? creditNote,
    String? bonousNote,
    String? winningNote,
  }) {
    _aadharStatus = aadharStatus;
    _panStatus = panStatus;
    _totalAmount = totalAmount;
    _creditAmount = creditAmount;
    _bonousAmount = bonousAmount;
    _winningAmount = winningAmount;
    _creditNote = creditNote;
    _bonousNote = bonousNote;
    _winningNote = winningNote;
  }

  AccountDetails.fromJson(dynamic json) {
    _aadharStatus = json['aadhar_status'];
    _panStatus = json['pan_status'];
    _totalAmount = json['total_amount'];
    _creditAmount = json['credit_amount'];
    _bonousAmount = json['bonous_amount'];
    _winningAmount = json['winning_amount'];
    _creditNote = json['credit_note'];
    _bonousNote = json['bonous_note'];
    _winningNote = json['winning_note'];
  }

  String? _aadharStatus;
  String? _panStatus;
  String? _totalAmount;
  String? _creditAmount;
  String? _bonousAmount;
  String? _winningAmount;
  String? _creditNote;
  String? _bonousNote;
  String? _winningNote;

  String? get aadharStatus => _aadharStatus;

  String? get panStatus => _panStatus;

  String? get totalAmount => _totalAmount;

  String? get creditAmount => _creditAmount;

  String? get bonousAmount => _bonousAmount;

  String? get winningAmount => _winningAmount;

  String? get creditNote => _creditNote;

  String? get bonousNote => _bonousNote;

  String? get winningNote => _winningNote;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aadhar_status'] = _aadharStatus;
    map['pan_status'] = _panStatus;
    map['total_amount'] = _totalAmount;
    map['credit_amount'] = _creditAmount;
    map['bonous_amount'] = _bonousAmount;
    map['winning_amount'] = _winningAmount;
    map['credit_note'] = _creditNote;
    map['bonous_note'] = _bonousNote;
    map['winning_note'] = _winningNote;
    return map;
  }
}
