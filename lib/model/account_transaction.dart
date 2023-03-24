import 'dart:convert';
/// status : "success"
/// message : "Transaction details"
/// responsecode : "200"
/// data : [{"amount":"100000","type":"credit","created_date":"2023-03-19 20:01:04","transaction_status":"TXN_SUCCESS","transection_mode":"deposit by self"}]

AccountTransaction accountTransactionFromJson(String str) => AccountTransaction.fromJson(json.decode(str));
String accountTransactionToJson(AccountTransaction data) => json.encode(data.toJson());
class AccountTransaction {
  AccountTransaction({
      String? status, 
      String? message, 
      String? responsecode, 
      List<AccountTransactionData>? data,}){
    _status = status;
    _message = message;
    _responsecode = responsecode;
    _data = data;
}

  AccountTransaction.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _responsecode = json['responsecode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AccountTransactionData.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  String? _responsecode;
  List<AccountTransactionData>? _data;

  String? get status => _status;
  String? get message => _message;
  String? get responsecode => _responsecode;
  List<AccountTransactionData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['responsecode'] = _responsecode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// amount : "100000"
/// type : "credit"
/// created_date : "2023-03-19 20:01:04"
/// transaction_status : "TXN_SUCCESS"
/// transection_mode : "deposit by self"

AccountTransactionData dataFromJson(String str) => AccountTransactionData.fromJson(json.decode(str));
String dataToJson(AccountTransactionData data) => json.encode(data.toJson());
class AccountTransactionData {
  AccountTransactionData({
      String? amount, 
      String? type, 
      String? createdDate, 
      String? transactionStatus, 
      String? transectionMode,}){
    _amount = amount;
    _type = type;
    _createdDate = createdDate;
    _transactionStatus = transactionStatus;
    _transectionMode = transectionMode;
}

  AccountTransactionData.fromJson(dynamic json) {
    _amount = json['amount'];
    _type = json['type'];
    _createdDate = json['created_date'];
    _transactionStatus = json['transaction_status'];
    _transectionMode = json['transection_mode'];
  }
  String? _amount;
  String? _type;
  String? _createdDate;
  String? _transactionStatus;
  String? _transectionMode;

  String? get amount => _amount;
  String? get type => _type;
  String? get createdDate => _createdDate;
  String? get transactionStatus => _transactionStatus;
  String? get transectionMode => _transectionMode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    map['type'] = _type;
    map['created_date'] = _createdDate;
    map['transaction_status'] = _transactionStatus;
    map['transection_mode'] = _transectionMode;
    return map;
  }

}