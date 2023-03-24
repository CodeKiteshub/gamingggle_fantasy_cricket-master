import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/common_string.dart';

class UserSession extends GetxController {
  static final UserSession userSession = UserSession._internal();

  factory UserSession() {
    return userSession;
  }

  UserSession._internal();

  GetStorage box = GetStorage();

  final _isLogin = false.obs;
  final _isProfileCompleted = false.obs;
  final _userId = ''.obs;
  final _firstName = ''.obs;
  final _lastName = ''.obs;
  final _userEmail = ''.obs;
  final _userMobile = ''.obs;
  final _countryCode = ''.obs;
  final _userProfile = ''.obs;
  final _token = ''.obs;

  init() async {
    _isLogin.value = box.read(isLogInString) ?? false;
    _isProfileCompleted.value = box.read(isProfileCompletedString) ?? false;
    _userId.value = box.read(userIdString) ?? '';
    _firstName.value = box.read(firstNameString) ?? '';
    _lastName.value = box.read(lastNameString) ?? '';
    _userEmail.value = box.read(userEmailString) ?? '';
    _userMobile.value = box.read(userMobileString) ?? '';
    _countryCode.value = box.read(userCountryCode) ?? '';
    _userProfile.value = box.read(userProfileString) ?? '';
    _token.value = box.read(tokenString) ?? '';
  }

  get userId => _userId.value;

  get firstName => _firstName.value;

  get lastName => _lastName.value;

  get isLogin => _isLogin.value;

  get isProfileCompleted => _isProfileCompleted.value;

  get userEmail => _userEmail.value;

  get userMobile => _userMobile.value;

  get countryCode => _countryCode.value;

  get userProfile => _userProfile.value;

  get token => _token.value;

  void setIsLogin(bool value) {
    _isLogin.value = value;
    setPref(isLogInString, value);
  }

  void setIsProfileCompleted(bool value) {
    _isProfileCompleted.value = value;
    setPref(isProfileCompletedString, value);
  }

  void setUserId(String value) {
    _userId.value = value;
    setPref(userIdString, value);
  }

  void setFirstName(String value) {
    _firstName.value = value;
    setPref(firstNameString, value);
  }

  void setLastName(String value) {
    _lastName.value = value;
    setPref(lastNameString, value);
  }

  void setUserEmail(String value) {
    _userEmail.value = value;
    setPref(userEmailString, value);
  }

  void setUserMobile(String value) {
    _userMobile.value = value;
    setPref(userMobileString, value);
  }

  void setCountyCode(String value) {
    _countryCode.value = value;
    setPref(userCountryCode, value);
  }

  void setUserProfile(String value) {
    _userProfile.value = value;
    setPref(userProfileString, value);
  }

  void setUserToken(String value) {
    _token.value = value;
    setPref(tokenString, value);
  }

  void setPref(String key, dynamic value) async {
    await box.write(key, value);
  }

  getPref(String key) async {
    await box.read(key);
  }

  Future<bool> logOut() async {
    await box.erase();
    return true;
  }
}
