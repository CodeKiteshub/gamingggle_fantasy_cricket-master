import 'package:get/get.dart';
import 'package:tempalteflutter/controllers/auth/user_session.dart';

import '../../utils/network/api_call.dart';
import '../../widgets/toast_message.dart';

enum LoginResult { success, verificationPending, failed }

class AuthenticationController extends GetxController {
  static final AuthenticationController _languageController =
      AuthenticationController._internal();

  factory AuthenticationController() {
    return _languageController;
  }

  AuthenticationController._internal();

  UserSession userSession = Get.find();

  ///This method to sign in user
  ///
  /// * [data] map of the user sign in data
  /// * [endPoint] sign in API end point
  Future<LoginResult> signInUser(
      {Map<String, String>? data, String? endPoint}) async {
    try {
      final response = await callPostApi(
        data!,
        endPoint!,
      );
      if (response['responsecode'] == '200') {
        ///Store all user data into local storage

        if (response['data']['verify'] == '1') {
          userSession.setUserId(response['data']['user_id']);
          userSession.setUserEmail(response['data']['email']);
          userSession.setUserMobile(response['data']['mobile']);
          userSession.setUserProfile(response['data']['image']);
          userSession.setIsLogin(true);
          return LoginResult.success;
        } else {
          return LoginResult.verificationPending;
        }
      } else {
        ///Show alert if API response is not valid
        ShowToast.show(
          title: 'Validation Error!',
          message: response['message'] ?? 'Please try again!',
        );
      }
      return LoginResult.failed;
    } catch (e) {
      print('============== Error $e');
      return LoginResult.failed;
    }
  }

  ///This method to sign Up user
  ///
  /// * [data] map of the user sign in data
  /// * [endPoint] sign in API end point
  Future<bool> signUpUser({Map<String, String>? data, String? endPoint}) async {
    try {
      final response = await callPostApi(
        data!,
        endPoint!,
      );
      if (response['responsecode'] == '200') {
        ///Store all user data into local storage
        userSession.setIsLogin(true);
        userSession.setUserId(response['data']['user_id']);
        userSession.setUserEmail(response['data']['email']);
        userSession.setUserMobile(response['data']['mobile']);
        // userSession.setUserProfile(response['data']['image']);

        ShowToast.show(
          title: 'Validation Error!',
          message: "${response['otp']}" ?? 'Please try again!',
        );
        return true;
      } else {
        ///Show alert if API response is not valid
        ShowToast.show(
          title: 'Validation Error!',
          message: response['message'] ?? 'Please try again!',
        );
      }
      return false;
    } catch (e) {
      print('============== Error $e');
      return false;
    }
  }

  ///This method to send OTP to mobile
  ///
  /// * [data] map of the user sign in data
  /// * [endPoint] sign in API end point
  Future<bool> resendOTP({Map<String, String>? data, String? endPoint}) async {
    try {
      final response = await callPostApi(
        data!,
        endPoint!,
      );
      if (response['responsecode'] == '200') {
        ShowToast.show(
          title: 'Validation Error!',
          message: response['data']['otp'] ?? 'Please try again!',
        );
        return true;
      } else {
        ///Show alert if API response is not valid
        ShowToast.show(
          title: 'Validation Error!',
          message: response['message'] ?? 'Please try again!',
        );
      }
      return false;
    } catch (e) {
      print('============== Error $e');
      return false;
    }
  }

  ///This method to forget password
  ///
  /// * [data] map of the user sign in data
  /// * [endPoint] sign in API end point
  Future<bool> forgetPassword(
      {Map<String, String>? data, String? endPoint}) async {
    try {
      final response = await callPostApi(
        data!,
        endPoint!,
      );
      if (response['responsecode'] == '200') {
        userSession.setUserId(response['data']['user_id']);
        ShowToast.show(
          title: 'Validation Error!',
          message: '${response['otp']}' ?? 'Please try again!',
        );
        return true;
      } else {
        ///Show alert if API response is not valid
        ShowToast.show(
          title: 'Validation Error!',
          message: response['message'] ?? 'Please try again!',
        );
      }
      return false;
    } catch (e) {
      print('============== Error $e');
      return false;
    }
  }

  ///This method to verify OTP
  ///
  /// * [data] map of the user sign in data
  /// * [endPoint] sign in API end point
  Future<bool> verifyOTP({Map<String, String>? data, String? endPoint}) async {
    try {
      final response = await callPostApi(
        data!,
        endPoint!,
      );
      if (response['responsecode'] == '200') {
        return true;
      } else {
        ///Show alert if API response is not valid
        ShowToast.show(
          title: 'Validation Error!',
          message: response['message'] ?? 'Please try again!',
        );
      }
      return false;
    } catch (e) {
      print('============== Error $e');
      return false;
    }
  }
}
