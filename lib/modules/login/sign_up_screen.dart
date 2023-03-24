import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempalteflutter/modules/login/loginView.dart';

import '../../constance/constance.dart';
import '../../constance/themes.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../utils/api_constants.dart';
import '../../validator/validator.dart';
import '../../widgets/progress_dialog.dart';
import '../../widgets/toast_message.dart';
import 'otpValidationScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var codeController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var mobileFocusNode = FocusNode();
  var codeFocusNode = FocusNode();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var confirmPasswordFocusNode = FocusNode();
  var _obscureText = true;
  var _obscureConfirmText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileFocusNode.dispose();
    emailFocusNode.dispose();
    codeFocusNode.dispose();
    passwordController.dispose();
    mobileController.dispose();
    codeController.dispose();
    emailController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email can not be empty';
    } else {
      if (!Validators().emailValidator(value)) {
        return 'Email is not valid';
      } else {
        return null;
      }
      return null;
    }
  }

  String? _validateMobile(String? value) {
    if (value!.isEmpty) {
      return 'Mobile Number can not be empty';
    } else {
      if (value.length != 10) {
        return 'Mobile Number is not valid';
      } else {
        return null;
      }
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
                        'Hello',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        'Please create your new account',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextFormField(
                          controller: mobileController,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color:
                                AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          ),
                          autofocus: false,
                          focusNode: mobileFocusNode,
                          decoration: InputDecoration(
                              labelText: 'Mobile No.',
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Icon(Icons.person),
                              )),
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                          validator: _validateMobile,
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
                              labelText: 'Email Address',
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
                          obscureText: _obscureText,
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
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  semanticLabel: _obscureText
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
                        height: 8,
                      ),
                      Container(
                        child: TextFormField(
                          controller: confirmPasswordController,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color:
                                AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          ),
                          autofocus: false,
                          focusNode: confirmPasswordFocusNode,
                          keyboardType: TextInputType.text,
                          obscureText: _obscureConfirmText,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                            labelText: 'Confirm Password',
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
                        height: 8,
                      ),
                      Container(
                        child: TextFormField(
                          controller: codeController,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color:
                                AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          ),
                          autofocus: false,
                          focusNode: codeFocusNode,
                          decoration: InputDecoration(
                              labelText: 'Enter invite code(Optional)',
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Icon(Icons.person),
                              )),
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                          // validator: _validateEmail,
                          // onSaved: (value) {
                          //   emailtxt = value!;
                          // },
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
                                  'SignUp',
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
                        height: 30,
                      ),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE12,
                                  color: AllCoustomTheme.getThemeData()
                                      .primaryColor,
                                ),
                              ),
                              TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    color: AllCoustomTheme.getThemeData()
                                        .primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      ///Go to register screen.
                                      Get.to(() => LoginView());
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

    if (_formKey.currentState!.validate() == false) {
      return;
    }
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ShowToast.show(
          title: 'Validation Error!',
          message: "Password and confirm Password mush be same");
      return;
    }
    _formKey.currentState!.save();
    // widget.loginCallBack!(emailtxt, password);
    ProgressDialog.showProgressDialog(context);
    AuthenticationController().signUpUser(data: {
      "mobile": mobileController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "code": codeController.text.trim(),
      "type": "Normal",
      // "token": "asdfsadfasfedawer"
    }, endPoint: SIGNUP).then((value) {
      if (value) {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpValidationScreen(),
          ),
        );
      } else {
        Navigator.of(context).pop();
      }
    });
  }
}
