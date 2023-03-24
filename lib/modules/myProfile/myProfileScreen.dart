// ignore_for_file: unused_field, unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/api/logout.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/home/homeScreen.dart';
import 'package:tempalteflutter/modules/myProfile/transectionHistoryScreen.dart';
import 'package:tempalteflutter/modules/myProfile/updateProfileScreen.dart';
import 'package:tempalteflutter/modules/pymentOptions/withdrawScreen.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

import '../../controllers/auth/UserDetailsController.dart';
import 'package:tempalteflutter/controllers/auth/user_session.dart';
import 'package:get/get.dart';

import '../../utils/api_constants.dart';

var responseData;
UserSession userSession = Get.find();

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with SingleTickerProviderStateMixin {
  double _appBarHeight = 100.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  var name = '';
  var imageUrl = '';
  var mobile = '';
  var email = '';
  var dob = '';
  var gender = '';
  var country = '';
  var state = '';
  var city = '';
  ScrollController _scrollController = new ScrollController();

  var data;

  @override
  void initState() {
    getUserData();
    super.initState();

    // var profileData = ApiProvider().getProfile();
    // if (profileData != null && profileData.data != null) {
    //   final txt = profileData.data!.name!.trim().split(' ');
    //   name = txt[0][0].toUpperCase() + txt[0].substring(1, txt[0].length);
    //   imageUrl = profileData.data!.image!;
    //   MySharedPreferences().setUserDataString(profileData.data!);
    // }
  }

  void getUserData() async {
    // var responseData = ApiProvider().getProfile();
    // data = responseData.data;
    UserDetailsController().getUserDetails(data: {
      "user_id": userSession.userId,
    }, endPoint: VIEWPROFILE).then((value) {
      if (value != null) {
        setState(() {
          imageUrl = value.image.toString();
          name = value.name.toString();
          email = value.email.toString();
          mobile = value.mobile.toString();
          dob = value.dob.toString();
          gender = value.gender.toString();
          country = value.country.toString();
          state = value.state.toString();
          city = value.city.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Stack(
        children: [
          Container(
            color: AllCoustomTheme.getThemeData().primaryColor,
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              appBar: AppBar(
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 44,
                        width: 44,
                        child: AvatarImage(
                          sizeValue: 44,
                          radius: 44,
                          isCircle: true,
                          imageUrl: imageUrl,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AllCoustomTheme.getThemeData().backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Text(
                        "My Detail",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Matches",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Wallet",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: FloatingActionButton(
                  foregroundColor:
                      AllCoustomTheme.getThemeData().backgroundColor,
                  backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfileScreen(
                          loginUserData: data,
                        ),
                      ),
                    );
                    getUserData();
                  },
                  child: Icon(Icons.edit),
                ),
              ),
              body: Container(
                color: AllCoustomTheme.getThemeData().backgroundColor,
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(0),
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    right: 16, left: 16, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 16, left: 16, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        email,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 16, left: 16, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'Mobile No',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        mobile,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 16, left: 16, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'Date of Birth',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        dob,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 16, left: 16, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'Gender',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        gender,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 16, left: 16, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'Country',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        country,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 16, left: 16, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'State',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        state,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.only(
                                    right: 16, left: 16, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Text(
                                        'City',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme
                                              .getTextThemeColors(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        city,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              logoutButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    PlayingHistory(),
                    Wallet(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      height: 30,
      child: InkWell(
        onTap: () {
          LogOut().logout(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.powerOff,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Logout',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.red,
                      fontSize: ConstanceData.SIZE_TITLE14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sliverText() {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 0),
      centerTitle: false,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 44,
            width: 44,
            child: AvatarImage(
              sizeValue: 44,
              radius: 44,
              isCircle: true,
              imageUrl:
                  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1534&q=80",
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Enric',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AllCoustomTheme.getThemeData().backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

class PlayingHistory extends StatefulWidget {
  @override
  _PlayingHistoryState createState() => _PlayingHistoryState();
}

class _PlayingHistoryState extends State<PlayingHistory> {
  bool isLoginProsses = false;

  // UserData data = UserData();
  var contests = '';
  var series = '';
  var wins = '';
  var matches = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isLoginProsses = true;
    });
    UserDetailsController().getPlayingHistory(data: {
      "user_id": userSession.userId,
    }, endPoint: MYPLAYINGHISTORY).then((value) {
      if (value != null) {
        print(value);

        setState(() {
          contests = value.contest.toString();
          series = value.series.toString();
          wins = value.wins.toString();
          matches = value.matchs.toString();
          isLoginProsses = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Center(
        child: ModalProgressHUD(
          inAsyncCall: isLoginProsses,
          color: Colors.transparent,
          progressIndicator: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Contests',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        contests,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Matches',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        matches,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Series',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        series,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Wins',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        wins,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool isLoginProsses = false;
  UserData data = UserData();
  bool emailApproved = false;
  bool panCardApproved = false;
  bool bankApproved = false;
  bool allApproved = false;
  String myBalance = "0";
  String deposit = "0";
  String winning = "0";
  String bonus = "0";

  @override
  void initState() {
    super.initState();
    UserDetailsController().getAccountDetails(data: {
      "user_id": userSession.userId,
    }, endPoint: MYACCOUNT).then((value) {
      if (value != null) {
        setState(() {
          myBalance = value.totalAmount.toString();
          deposit = (int.parse(value.totalAmount.toString()) -
                  int.parse(value.winningAmount.toString()))
              .toString();
          bonus = value.bonousAmount.toString();
          winning = value.winningAmount.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Center(
        child: ModalProgressHUD(
          inAsyncCall: isLoginProsses,
          color: Colors.transparent,
          progressIndicator: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    right: 16, left: 16, top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'My Balance',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE16,
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                    Text(
                      '₹' + myBalance,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE16,
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(
                    right: 16, left: 16, top: 4, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 110,
                      child: Text(
                        'Deposit',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '₹$deposit',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(
                    right: 16, left: 16, top: 4, bottom: 4),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 110,
                      child: Text(
                        'Winning',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WithdrawScreen(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        decoration: new BoxDecoration(
                          color: AllCoustomTheme.getThemeData()
                              .backgroundColor,
                          borderRadius: new BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(0, 1),
                                blurRadius: 5.0),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'withdraw'.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.green,
                              fontSize: ConstanceData.SIZE_TITLE14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      child: Text(
                        '₹$winning',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              !allApproved
                  ? Container(
                padding: EdgeInsets.only(top: 4),
                alignment: Alignment.centerRight,
                child: Text(
                  'Verify your account to be eligible to withdraw.      ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: Colors.red,
                  ),
                ),
              )
                  : SizedBox(),
              Divider(),
              Container(
                padding: EdgeInsets.only(
                    right: 16, left: 16, top: 8, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 110,
                      child: Text(
                        'Bonus',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        '₹' + bonus,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionHistoryScreen(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      color: AllCoustomTheme.getThemeData()
                          .primaryColor
                          .withOpacity(0.2),
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "My Transactions",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                                fontWeight: FontWeight.bold,
                                color: AllCoustomTheme.getThemeData()
                                    .primaryColor,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: ConstanceData.SIZE_TITLE22,
                            color: AllCoustomTheme.getThemeData()
                                .primaryColor,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final TabController controller;

  PersistentHeader(
    this.controller,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          color: AllCoustomTheme.getThemeData().backgroundColor,
          child: new TabBar(
            unselectedLabelColor: AllCoustomTheme.getTextThemeColors(),
            indicatorColor: AllCoustomTheme.getThemeData().primaryColor,
            labelColor: AllCoustomTheme.getThemeData().primaryColor,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AllCoustomTheme.getThemeData().primaryColor,
            ),
            tabs: [
              new Tab(text: 'Account Info'),
              new Tab(text: 'Playing History'),
              new Tab(text: 'Wallet'),
            ],
            controller: controller,
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  @override
  double get maxExtent => 41.0;

  @override
  double get minExtent => 41.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
