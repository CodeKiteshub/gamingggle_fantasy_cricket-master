import 'package:get/get.dart';
import 'package:tempalteflutter/controllers/auth/user_session.dart';
import 'package:tempalteflutter/model/account_details.dart';
import 'package:tempalteflutter/model/user_playing_histroy.dart';

import '../../model/user_details.dart';
import '../../utils/network/api_call.dart';
import '../../widgets/toast_message.dart';

enum LoginResult { success, verificationPending, failed }

class UserDetailsController extends GetxController {
  static final UserDetailsController _userDetailsController =
      UserDetailsController._internal();

  factory UserDetailsController() {
    return _userDetailsController;
  }

  UserDetailsController._internal();

  UserSession userSession = Get.find();

  ///This method to getUserDetails
  ///
  /// * [data] map of the user sign in data
  /// * [endPoint] sign in API end point
  Future<UserDetails?> getUserDetails(
      {Map<String, String>? data, String? endPoint}) async {
    final response = await callPostApi(
      data!,
      endPoint!,
    );
    if (response['responsecode'] == '200') {
      print(response["data"]);
      return UserDetails.fromJson(response["data"]);
    } else {
      ///Show alert if API response is not valid
      ShowToast.show(
        title: 'Validation Error!',
        message: response['message'] ?? 'Please try again!',
      );
    }
    return null;
  }

  ///This method to getPlayingHistory
  ///
  /// * [data] map of the user sign in data
  /// * [endPoint] sign in API end point
  Future<UserPlayingHistory?> getPlayingHistory(
      {Map<String, String>? data, String? endPoint}) async {
    final response = await callPostApi(
      data!,
      endPoint!,
    );
    if (response['responsecode'] == '200') {
      print(response["data"]);
      return UserPlayingHistory.fromJson(response["data"]);
    } else {
      ///Show alert if API response is not valid
      ShowToast.show(
        title: 'Validation Error!',
        message: response['message'] ?? 'Please try again!',
      );
    }
    return null;
  }
  ///This method to getUserDetails
  ///
  /// * [data] map of the user sign in data
  /// * [endPoint] sign in API end point
  Future<AccountDetails?> getAccountDetails(
      {Map<String, String>? data, String? endPoint}) async {
    final response = await callPostApi(
      data!,
      endPoint!,
    );
    if (response['responsecode'] == '200') {
      print(response["data"]);
      return AccountDetails.fromJson(response["data"]);
    } else {
      ///Show alert if API response is not valid
      ShowToast.show(
        title: 'Validation Error!',
        message: response['message'] ?? 'Please try again!',
      );
    }
    return null;
  }
}
