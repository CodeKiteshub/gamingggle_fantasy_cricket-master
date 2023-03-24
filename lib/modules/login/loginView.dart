// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/controllers/auth/auth_controller.dart';
import 'package:tempalteflutter/controllers/auth/user_session.dart';
import 'package:tempalteflutter/modules/login/forget_password_screen.dart';
import 'package:tempalteflutter/modules/login/sign_up_screen.dart';
import 'package:tempalteflutter/validator/validator.dart';
import 'package:tempalteflutter/widgets/progress_dialog.dart';

import '../../utils/api_constants.dart';
import '../home/tabScreen.dart';
import 'otpValidationScreen.dart';

class LoginView extends StatefulWidget {
  // final void Function(String? emailtxt, String? password)? loginCallBack;

  const LoginView({
    Key? key,
    /*this.loginCallBack*/
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // DateTime date = DateTime.now();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var _obscureConfirmText = true;
  final _formKey = GlobalKey<FormState>();
  UserSession userSession = Get.find();

  var emailtxt = '';
  var password = '';

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordController.dispose();
    emailController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email can not be empty';
    } else {
      // if (!Validators().emailValidator(value)) {
      //   return 'Email is not valid';
      // } else {
      //   return null;
      // }
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password can not be empty';
    } else {
      if (!Validators().passwordValidator(value)) {
        return 'Password length should be greater than 6 chars.';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 50, right: 16),
          child: Container(
            padding: EdgeInsets.only(bottom: 19),
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              decoration: new BoxDecoration(
                color: AllCoustomTheme.getThemeData().backgroundColor,
                borderRadius: new BorderRadius.circular(12.0),
                border: new Border.all(
                  width: 1.0,
                  color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color:
                          AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                      offset: Offset(0, 1),
                      blurRadius: 3.0),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        'Please login your account',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextFormField(
                          controller: emailController,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color:
                                AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          ),
                          autofocus: false,
                          focusNode: emailFocusNode,
                          decoration: InputDecoration(
                              labelText: 'Email Address/Mobile',
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Icon(Icons.person),
                              )),
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                          validator: _validateEmail,
                          // onSaved: (value) {
                          //   emailtxt = value!;
                          // },
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: TextFormField(
                          controller: passwordController,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color:
                                AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          ),
                          autofocus: false,
                          focusNode: passwordFocusNode,
                          keyboardType: TextInputType.text,
                          obscureText: _obscureConfirmText,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                            labelText: 'Password',
                            icon: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Icon(Icons.lock),
                            ),
                            suffixIcon: GestureDetector(
                              dragStartBehavior: DragStartBehavior.down,
                              onTap: () {
                                setState(() {
                                  _obscureConfirmText = !_obscureConfirmText;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Icon(
                                  _obscureConfirmText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  semanticLabel: _obscureConfirmText
                                      ? 'show password'
                                      : 'hide password',
                                ),
                              ),
                            ),
                          ),
                          validator: _validatePassword,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => const ForgetPasswordScreen());
                          },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  AllCoustomTheme.getThemeData().primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AllCoustomTheme.getThemeData().primaryColor,
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AllCoustomTheme
                                          .getBlackAndWhiteThemeColors()
                                      .withOpacity(0.5),
                                  offset: Offset(0, 1),
                                  blurRadius: 5.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50.0),
                              onTap: () {
                                _submit();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 75, right: 75, bottom: 10),
                                child: Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: AllCoustomTheme.getThemeData()
                                        .backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Center(
                      //   child: Text(
                      //     'Or sign in using social media',
                      //     style: TextStyle(
                      //         fontSize: 16, fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Image.asset(
                      //       'assets/fb_icon.png',
                      //       height: 44,
                      //       width: 44,
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     Image.asset(
                      //       'assets/google_icon.png',
                      //       height: 44,
                      //       width: 44,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE12,
                                  color: AllCoustomTheme.getThemeData()
                                      .primaryColor,
                                ),
                              ),
                              TextSpan(
                                  text: 'Register Now',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    color: AllCoustomTheme.getThemeData()
                                        .primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      ///Go to register screen.
                                      Get.to(() => SignUpScreen());
                                    }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // if(validateFields() != ''){
    //   ShowToast.show(title: 'Validation Error!', message: validateFields());
    //   return;
    // }

    if (_formKey.currentState!.validate() == false) {
      return;
    }
    _formKey.currentState!.save();
    // widget.loginCallBack!(emailtxt, password);
    ProgressDialog.showProgressDialog(context);
    AuthenticationController().signInUser(data: {
      "mobile": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "type": "Normal",
      "token": "asdfsadfasfedawer"
    }, endPoint: LOGIN).then((value) {
      if (value == LoginResult.success) {
        // MySharedPreferences().setUserDataString(value.!);
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TabScreen(),
          ),
        );
      } else if (value == LoginResult.verificationPending) {
        AuthenticationController().resendOTP(data: {
          'user_id': userSession.userId,
        }, endPoint: RESENDOTP).then((value) {
          Navigator.of(context).pop();
          if (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpValidationScreen(),
              ),
            );
          }
        });
      } else {
        Navigator.of(context).pop();
      }
    });
  }
}
