// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/controllers/auth/user_session.dart';
import 'package:tempalteflutter/modules/login/continuebutton.dart';
import 'package:tempalteflutter/modules/login/create_password_screen.dart';
import 'package:tempalteflutter/modules/login/forget_password_screen.dart';
import 'package:tempalteflutter/modules/login/otpProgressView.dart';
import 'package:tempalteflutter/modules/login/otpTimer.dart';
import 'package:tempalteflutter/modules/register/registerScreen.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../utils/api_constants.dart';
import '../../widgets/progress_dialog.dart';
import '../../widgets/toast_message.dart';
import '../home/tabScreen.dart';

class ForgetVerifyOTPScreen extends StatefulWidget {
  const ForgetVerifyOTPScreen({Key? key, this.emailMobile, this.type}) : super(key: key);
  final String? emailMobile;
  final String? type;

  @override
  _ForgetVerifyOTPScreenState createState() => _ForgetVerifyOTPScreenState();
}

class _ForgetVerifyOTPScreenState extends State<ForgetVerifyOTPScreen>
    with TickerProviderStateMixin {
  var isLoginProsses = false;
  late AnimationController _animationController;
  var otpText = '';
  var istimeFinish = false;
  var otpTimerView = true;
  var otpController = TextEditingController();
  UserSession userSession = Get.find();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getThemeData().backgroundColor,
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top,
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 24),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Text(
                                      'Verify OTP',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 40,
                                        color: AllCoustomTheme.getThemeData()
                                            .primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            OtpProgressView(),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 60,
                              child: Container(
                                width: 130,
                                decoration: BoxDecoration(
                                  color: AllCoustomTheme.getThemeData()
                                      .backgroundColor,
                                  border: Border.all(
                                    width: 1.0,
                                    color: AllCoustomTheme.getTextThemeColors()
                                        .withOpacity(0.5),
                                  ),
                                ),
                                child: TextField(
                                  controller: otpController,
                                  cursorColor: AllCoustomTheme.getThemeData()
                                      .primaryColor,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 10.0,
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    color: AllCoustomTheme
                                        .getBlackAndWhiteThemeColors(),
                                  ),
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      counterStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.transparent)),
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  onChanged: (txt) {
                                    otpText = txt;
                                    if (!istimeFinish) {
                                      if (txt.length == 6) {
                                        _animationController.forward();
                                      } else {
                                        _animationController.reverse();
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            otpTimerView
                                ? OtpTimerView(timeCallBack: (isfinish) {
                                    if (isfinish) {
                                      if (!mounted) return;
                                      setState(() {
                                        istimeFinish = true;
                                        _animationController.forward();
                                        otpTimerView = false;
                                      });
                                    }
                                  })
                                : InkWell(
                                    onTap: () {
                                      ///Resend top to user
                                      ProgressDialog.showProgressDialog(
                                          context);
                                      AuthenticationController()
                                          .forgetPassword(data: {
                                        "EmailorNumber": widget.emailMobile!,
                                        "type": widget.type!,
                                      }, endPoint: FORGOTPASSWORD).then(
                                              (value) {
                                        Navigator.of(context).pop();
                                        if (value) {
                                          setState(() {
                                            otpTimerView = true;
                                          });
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        'Resend OTP',
                                        style: TextStyle(
                                          color: AllCoustomTheme.getThemeData()
                                              .primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                            Flexible(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 14, left: 14, bottom: 14),
                              child: ContinueButton(
                                name: 'Verify',
                                callBack: () async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  if (otpController.text.trim().isEmpty) {
                                    ShowToast.show(
                                      title: 'Validation Error!',
                                      message: 'Please Enter OTP!',
                                    );
                                    return;
                                  }

                                  ProgressDialog.showProgressDialog(context);
                                  AuthenticationController().verifyOTP(data: {
                                    'EmailorNumber': widget.emailMobile!,
                                    'otp': otpController.text.trim(),
                                    'type': widget.type!,
                                  }, endPoint: VERIFYFORGOTPASSWORD).then((value) {
                                    Navigator.pop(context);
                                    if (value) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Your phone verification successful.");
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreatePasswordScreen(),
                                        ),
                                      );
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
