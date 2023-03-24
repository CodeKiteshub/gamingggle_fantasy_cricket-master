import 'package:get/get.dart';
import 'package:tempalteflutter/controllers/auth/user_session.dart';

import '../../model/home/home_fixture_match.dart';
import '../../utils/network/api_call.dart';
import '../../widgets/toast_message.dart';

class HomeController extends GetxController {
  static final HomeController _languageController = HomeController._internal();

  factory HomeController() {
    return _languageController;
  }

  HomeController._internal();

  UserSession userSession = Get.find();
  var homeFixtureMatchList = <HomeFixtureMatch>[].obs;

  ///This method to sign in user
  ///
  /// * [data] map of the user sign in data
  /// * [endPoint] sign in API end point
  Future<bool> getHomeData(
      {Map<String, String>? data, String? endPoint}) async {
    try {
      final response = await callPostApi(
        data!,
        endPoint!,
      );
      if (response['responsecode'] == '200') {
        homeFixtureMatchList.value = List<HomeFixtureMatch>.from(
          response['data']['fixtureMatch']!.map(
            (x) => HomeFixtureMatch.fromMap(x),
          ),
        );
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
