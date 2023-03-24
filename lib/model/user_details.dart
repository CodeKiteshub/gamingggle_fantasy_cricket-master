import 'dart:convert';
/// user_id : "138"
/// name : "rishabh sachan"
/// mobile : "8604172378"
/// email : "rishabhsachan8604@gmail.com"
/// image : ""
/// teamName : ""
/// favriteTeam : null
/// dob : "21-03-2023"
/// gender : "male"
/// address : ""
/// city : ""
/// pincode : ""
/// state : "21-03-2023"
/// country : "India"
/// referral_code : "RISH2875"
/// code : ""

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));
String userDetailsToJson(UserDetails data) => json.encode(data.toJson());
class UserDetails {
  UserDetails({
      String? userId, 
      String? name, 
      String? mobile, 
      String? email, 
      String? image, 
      String? teamName, 
      dynamic favriteTeam, 
      String? dob, 
      String? gender, 
      String? address, 
      String? city, 
      String? pincode, 
      String? state, 
      String? country, 
      String? referralCode, 
      String? code,}){
    _userId = userId;
    _name = name;
    _mobile = mobile;
    _email = email;
    _image = image;
    _teamName = teamName;
    _favriteTeam = favriteTeam;
    _dob = dob;
    _gender = gender;
    _address = address;
    _city = city;
    _pincode = pincode;
    _state = state;
    _country = country;
    _referralCode = referralCode;
    _code = code;
}

  UserDetails.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _email = json['email'];
    _image = json['image'];
    _teamName = json['teamName'];
    _favriteTeam = json['favriteTeam'];
    _dob = json['dob'];
    _gender = json['gender'];
    _address = json['address'];
    _city = json['city'];
    _pincode = json['pincode'];
    _state = json['state'];
    _country = json['country'];
    _referralCode = json['referral_code'];
    _code = json['code'];
  }
  String? _userId;
  String? _name;
  String? _mobile;
  String? _email;
  String? _image;
  String? _teamName;
  dynamic _favriteTeam;
  String? _dob;
  String? _gender;
  String? _address;
  String? _city;
  String? _pincode;
  String? _state;
  String? _country;
  String? _referralCode;
  String? _code;

  String? get userId => _userId;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get image => _image;
  String? get teamName => _teamName;
  dynamic get favriteTeam => _favriteTeam;
  String? get dob => _dob;
  String? get gender => _gender;
  String? get address => _address;
  String? get city => _city;
  String? get pincode => _pincode;
  String? get state => _state;
  String? get country => _country;
  String? get referralCode => _referralCode;
  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['image'] = _image;
    map['teamName'] = _teamName;
    map['favriteTeam'] = _favriteTeam;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['address'] = _address;
    map['city'] = _city;
    map['pincode'] = _pincode;
    map['state'] = _state;
    map['country'] = _country;
    map['referral_code'] = _referralCode;
    map['code'] = _code;
    return map;
  }

}